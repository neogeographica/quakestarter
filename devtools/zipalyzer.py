#!/usr/bin/env python3

import os
import sys
import zipfile

# We need 3.7.2 to be able to seek within a zipfile read stream.
if sys.version_info < (3, 7, 2):
    sys.stderr.write("Python version 3.7.2 or later is required.\n")
    sys.exit(1)

try:
    import expak
except ImportError:
    sys.stderr.write("The expak module is required.\n")
    sys.exit(1)

knowndirs = ['gfx','locs','maps','music','particles','progs','skins','sound','textures']

def handle_error(msg, errors):
    msg_line = '  ' + msg + '\n'
    sys.stderr.write(msg)
    errors.append(msg)

def gen_zip_analysis(results_dir, demos, configs, docs, errors, config_flags):
    (has_loose_autoexec, has_pak_autoexec, has_loose_quakerc, has_pak_quakerc) = config_flags
    with open(os.path.join(results_dir, 'analysis'), 'w') as analysis:
        if len(errors) == 0:
            analysis.write("errors: n/a\n\n")
        else:
            analysis.write("errors:\n")
            analysis.write(errors)
            analysis.write('\n')
        def write_list(list, listname):
            if len(list) == 0:
                analysis.write(listname + ": n/a\n")
            else:
                analysis.write(listname + ": {}\n".format(' '.join(list)))
            analysis.write('\n')
        write_list(configs, "configs")
        write_list(docs, "docs")
        analysis.write("\nrecommendations for settings:\n\n")
        if has_pak_quakerc:
            analysis.write("  set skip_quakerc_gen=true\n")
        startdemos = ' '.join(demos).lower()
        if len(demos) != 0:
            analysis.write("  set startdemos={}\n".format(startdemos))
        analysis.write("\n\nother notes:\n")
        startdemos_in_config = False
        different_startdemos_in_config = False
        demos_in_config = False
        for cfg in configs:
            with open(os.path.join(results_dir, cfg), 'r') as f:
                for line in f:
                    sl = line.strip()
                    if sl.lower().startswith("startdemos"):
                        startdemos_in_config = True
                        if sl[11:].lower() != startdemos:
                            different_startdemos_in_config = True
                    elif sl.lower().startswith("demos"):
                        demos_in_config = True
        if startdemos_in_config:
            if different_startdemos_in_config:
                analysis.write(
                    "\nAt least one cfg has a different idea about startdemos...\n")
            else:
                analysis.write(
                    "\nAt least one cfg has a (matching) startdemos command.\n")
        if demos_in_config:
            analysis.write(
                "\nAt least one config has a demos command. Removable?\n")
        if has_loose_quakerc:
            analysis.write(
                "\nHas a loose quake.rc file. Examine to see if it should be "
                "preserved (skip_quakerc_gen=true) or parts moved into "
                "modsettings.\n")
        if has_loose_autoexec:
            analysis.write("\nLoose autoexec.cfg will be removed.")
            if has_pak_quakerc or has_loose_quakerc:
                analysis.write(
                    " This could be problematic if skip_quakerc_gen is true! "
                    "Anything important in that autoexec.cfg?\n")
            else:
                analysis.write(
                    " Examine to see if there are bits that should be moved "
                    "into modsettings.\n")
        if has_pak_autoexec:
            analysis.write(
                "\nautoexec.cfg in pak file; for shame! Should add a prelaunch_msg "
                "warning about this.\n")
        if len(docs) != 0:
            analysis.write(
                "\nExamine docs to see if they mention any settings "
                "that should be in modsettings.")
            if has_pak_quakerc or has_loose_quakerc:
                analysis.write(
                    " This could be problematic if skip_quakerc_gen is true!\n")
            else:
                analysis.write("\n")

def extract_pakres(pak, pak_stream, res_name, results_dir):
    target = expak.encode_targets({res_name})
    target_info = expak.get_target_info(pak_stream, target)
    (file_name, file_off, file_len) = target_info[0]
    pak_stream.seek(file_off)
    file_contents = pak_stream.read(file_len)
    if len(file_contents) != file_len:
        raise IOError(2, "unexpected EOF reading {} from {}".format(res_name, pak))
    res_filename = os.path.join(pak, res_name)
    file_path = os.path.join(results_dir, res_filename)
    try:
        os.makedirs(os.path.dirname(file_path))
    except OSError as e:
        if e.errno != errno.EEXIST:
            raise
    with open(file_path, 'wb') as res_file:
        res_file.write(file_contents)

def process_pak(zf, pak, results_dir, demos, configs, errors):
    print("  analyzing {} ...".format(pak))
    all_success = True
    has_autoexec = False
    has_quakerc = False
    with zf.open(pak) as pak_stream:
        target_info = expak.get_target_info(pak_stream, None)
        if target_info is None:
            handle_error("{} is not a pak file".format(pak))
            return False
        pak_contents = [t[0].decode() for t in target_info]
        for p in pak_contents:
            pl = p.lower()
            if pl.split('/')[0] in knowndirs:
                continue
            if pl.endswith('.dem'):
                demos.append(p[:-4])
            elif pl == 'autoexec.cfg' or pl == 'quake.rc':
                configs.append(os.path.join(pak, p))
                if pl == 'autoexec.cfg':
                    has_autoexec = True
                elif pl == 'quake.rc':
                    has_quakerc = True
                print("  extracting {} from {}".format(p, pak))
                try:
                    extract_pakres(pak, pak_stream, p, results_dir)
                except:
                    handle_error("exception extracting {} from {}".format(p, pak))
                    all_success = False
    print("  ... done ({})".format(pak))
    return all_success, has_autoexec, has_quakerc

def process_zip(zip):
    print("analyzing {} ...".format(zip))
    demos = []
    configs = []
    docs = []
    errors = []
    results_dir = os.path.splitext(os.path.basename(zip))[0] + '_results'
    # If we get an exception here, let it flow up. Need to stop things.
    os.mkdir(results_dir)
    zf = zipfile.ZipFile(zip, 'r')
    zip_contents = zf.namelist()
    all_success = True
    has_loose_quakerc = False
    has_pak_quakerc = False
    has_loose_autoexec = False
    has_pak_autoexec = False
    for f in zip_contents:
        fl = f.lower()
        if fl.split('/')[0] in knowndirs:
            continue
        extractme = False
        if fl == 'autoexec.cfg' or fl.endswith('/autoexec.cfg'):
            configs.append(f)
            extractme = True
            has_loose_autoexec = True
        elif fl == 'quake.rc' or fl.endswith('/quake.rc'):
            configs.append(f)
            extractme = True
            has_loose_quakerc = True
        elif fl.endswith('.txt') or fl.endswith('.doc') or fl.endswith('.pdf') or fl.endswith('.htm') or fl.endswith('.html'):
            docs.append(f)
            extractme = True
        if extractme:
            print("  extracting {}".format(f))
            try:
                zf.extract(f, path=results_dir)
            except:
                handle_error("exception extracting {}".format(f))
                all_success = False
            continue
        if fl.endswith('.dem'):
            demos.append(f[:-4])
        elif fl.endswith('.pak'):
            pak_success, this_has_pak_autoexec, this_has_pak_quakerc = process_pak(
                zf, f, results_dir, demos, configs, errors)
            all_success = pak_success and all_success
            has_pak_autoexec = this_has_pak_autoexec or has_pak_autoexec
            has_pak_quakerc = this_has_pak_quakerc or has_pak_quakerc
    config_flags = (has_loose_autoexec, has_pak_autoexec, has_loose_quakerc, has_pak_quakerc)
    gen_zip_analysis(results_dir, demos, configs, docs, errors, config_flags)
    print("... done ({})".format(zip))
    return all_success

def process_zips(ziplist):
    all_success = True
    for zip in ziplist:
        all_success = process_zip(zip) and all_success
    if all_success:
        return 0
    return 1

if __name__ == "__main__":
    sys.exit(process_zips(sys.argv[1:]))
