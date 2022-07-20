#!/usr/bin/env python3

import contextlib
import filecmp
import os
import shutil
import subprocess
import sys
import time
import urllib.request
import zipfile

# We need 3.5.0 to use subprocess.run.
if sys.version_info < (3, 5, 0):
    sys.stderr.write("Python version 3.5 or later is required.\n")
    sys.exit(1)

SCRIPT_PATH = os.path.abspath(sys.argv[0])
SCRIPT_DIR = os.path.dirname(SCRIPT_PATH)
SRC_PATH = os.path.realpath(os.path.dirname(SCRIPT_DIR))
DOC_SRC_PATH = os.path.join(SRC_PATH, "docsource")

exec(open(os.path.join(DOC_SRC_PATH, "conf.py")).read())
RELEASE = release

RELEASE_URL = "https://github.com/neogeographica/quakestarter/releases/tag/v" + RELEASE

RELEASE_FOLDER = "release." + str(os.getpid())
QUAKE_FOLDER = os.path.join(RELEASE_FOLDER, "Quake")
ENGINE_STAGING_FOLDER = "engine-staging"
VKQ_VERSION = "1.20.3"
IW_VERSION = "0.6.0"
SQL_VERSION = "2.5"
VKQ_URL = "https://github.com/Novum/vkQuake/releases/download/{0}/vkquake-{0}_win64.zip".format(VKQ_VERSION)
VKQ_LOCALFILE = "vkq-temp.zip"
IW_URL = "https://github.com/andrei-drexler/ironwail/releases/download/v{0}/ironwail-{0}-win64.zip".format(IW_VERSION)
IW_LOCALFILE = "iw-temp.zip"
SQL_URL = "https://github.com/m-x-d/Simple-Quake-Launcher-2/releases/download/{0}/SQLauncher_{0}.zip".format(SQL_VERSION)
SQL_LOCALFILE = "sql-temp.zip"
EXCLUSIONS = [
    ".git",
    ".gitattributes",
    ".gitignore",
    "devtools",
    "docsource",
    "README.md"
]

def handle_zip(url, localfile, destdir):
    with contextlib.closing(urllib.request.urlopen(url)) as instream:
        with open(localfile, 'wb') as outstream:
            outstream.write(instream.read())
    latest_year = 1970
    latest_month = 1
    timestamp = "???"
    with zipfile.ZipFile(localfile, 'r') as zf:
        for i in zf.infolist():
            zf.extract(i, destdir)
            time_tuple = i.date_time + (0, 0, -1)
            date_time = time.mktime(time_tuple)
            os.utime(os.path.join(destdir, i.filename), (date_time, date_time))
            year = i.date_time[0]
            month = i.date_time[1]
            if year > latest_year:
                latest_year = year
                latest_month = month
                timestamp = time.strftime("%B %Y", time_tuple)
            elif year == latest_year:
                if month > latest_month:
                    latest_month = month
                    timestamp = time.strftime("%B %Y", time_tuple)
    os.remove(localfile)
    return timestamp

def gen_toplevel_readme():
    with open(os.path.join(RELEASE_FOLDER, "how_to_use_quakestarter.txt"), 'w', newline='\r\n') as f:
        f.write("""\
The "Quake" folder here can be the start of a new Quake installation, so you
can put it anywhere you'd like your Quake game files to be (as long as you
don't choose some special/protected location). Or if you already have an
existing Quake installation that you'd like to continue to use, you can move
the files from this Quake folder into that existing folder.

In either case, before you get started: open "quakestarter_readme.html" from
inside this Quake folder, and have a look. That page will guide you through
any necessary setup, step-by-step. It's also a gateway to more information on
all sorts of topics about Quake singleplayer.
""")

def gen_readme(readme_contents, vkq_timestamp, iw_timestamp, sql_timestamp, timestamp):
    new_readme_contents= []
    for line in readme_contents:
        if (vkq_timestamp == "") and ("###VKQ_VERSION###" in line):
            pass
        elif (iw_timestamp == "") and ("###IW_VERSION###" in line):
            pass
        else:
            new_line = line.replace(
                "###VKQ_VERSION###", VKQ_VERSION).replace(
                "###VKQ_TIMESTAMP###", vkq_timestamp).replace(
                "###IW_VERSION###", IW_VERSION).replace(
                "###IW_TIMESTAMP###", iw_timestamp).replace(
                "###SQL_VERSION###", SQL_VERSION).replace(
                "###SQL_TIMESTAMP###", sql_timestamp).replace(
                "###TIMESTAMP###", timestamp)
            new_readme_contents.append(new_line)
    with open(os.path.join(QUAKE_FOLDER, "quakestarter_readme.html"), 'w') as f:
        f.writelines(new_readme_contents)

def gen_docs():
    copy_dest = os.path.join(SCRIPT_DIR, QUAKE_FOLDER, "quakestarter_html")
    subprocess.run(
        ["make", "-C", DOC_SRC_PATH, "copydocs", "COPYDIR="+copy_dest],
        stdout=subprocess.DEVNULL
    )

def gen_version_config():
    with open(os.path.join(QUAKE_FOLDER, "quakestarter_scripts", "_version_installed.cmd"), 'w', newline='\r\n') as f:
        f.write("set version_installed=" + RELEASE_URL)

def gen_release_manifest(filename):
    files = [f + "\r\n" for f in os.listdir(QUAKE_FOLDER) if f != "id1"]
    files += ["id1\\" + f + "\r\n" for f in os.listdir(os.path.join(QUAKE_FOLDER, "id1"))]
    with open(os.path.join(QUAKE_FOLDER, "quakestarter_scripts", filename), 'w') as f:
        f.writelines(files)

def patch_autoexec():
    autoexec_path = os.path.join(QUAKE_FOLDER, "id1", "autoexec.cfg.example")
    shutil.copy2(autoexec_path, "autoexec.cfg.example.bak")
    with open(autoexec_path, 'r', newline='\r\n') as f:
        autoexec_contents = f.readlines()
    new_autoexec_contents= []
    for line in autoexec_contents:
        if line.lower().startswith("host_maxfps "):
            new_autoexec_contents.append(
"// Since this package does not include any particular Quake engine, this\r\n")
            new_autoexec_contents.append(
"// setting is commented out for safety. If you know that your chosen Quake\r\n")
            new_autoexec_contents.append(
"// engine can support high framerates without errors, you can remove the\r\n")
            new_autoexec_contents.append(
"// leading doubleslash before this setting to activate it.\r\n")
            new_autoexec_contents.append("//" + line)
        else:
            new_autoexec_contents.append(line)
    with open(autoexec_path, 'w') as f:
        f.writelines(new_autoexec_contents)
    shutil.copystat("autoexec.cfg.example.bak", autoexec_path)

def unpatch_autoexec():
    autoexec_path = os.path.join(QUAKE_FOLDER, "id1", "autoexec.cfg.example")
    shutil.move("autoexec.cfg.example.bak", autoexec_path)

def merge_files(source_a_name, source_a_dir, source_b_name, source_b_dir):
    def extracted_files(source_dir):
        source_files = os.listdir(source_dir)
        if len(source_files) == 0:
            print("WARNING: {} is empty!".format(source_dir))
        elif len(source_files) == 1:
            new_root = os.path.join(source_dir, source_files[0])
            if os.path.isdir(new_root):
                return extracted_files(new_root)
        return [os.path.join(source_dir, f) for f in source_files]
    source_a_files = extracted_files(source_a_dir)
    source_b_files = extracted_files(source_b_dir)
    for f in source_a_files:
        shutil.copy2(f, QUAKE_FOLDER)
    for f in source_b_files:
        f_base = os.path.basename(f)
        f_dest = os.path.join(QUAKE_FOLDER, f_base)
        if os.path.exists(f_dest):
            if filecmp.cmp(f, f_dest, shallow=False):
                continue
            if os.stat(f).st_mtime < os.stat(f_dest).st_mtime:
                print("NOTE: file {} taken from {} since it is newer".format(f_base, source_a_name))
                continue
            print("NOTE: file {} taken from {} since it is newer".format(f_base, source_b_name))
        shutil.copy2(f, QUAKE_FOLDER)
    source_a_set = set([os.path.basename(f) for f in source_a_files])
    source_b_set = set([os.path.basename(f) for f in source_b_files])
    common_set = source_a_set & source_b_set
    source_a_unique_set = source_a_set - common_set
    source_b_unique_set = source_b_set - common_set
    manifest_lines = [
        "files unique to {}:\r\n".format(source_a_name),
        "\r\n"
    ]
    manifest_lines += [f + "\r\n" for f in source_a_unique_set]
    manifest_lines += [
        "\r\n"
        "files unique to {}:\r\n".format(source_b_name),
        "\r\n"
    ]
    manifest_lines += [f + "\r\n" for f in source_b_unique_set]
    manifest_lines += [
        "\r\n"
        "files used in both {} and {}:\r\n".format(source_a_name, source_b_name),
        "\r\n"
    ]
    manifest_lines += [f + "\r\n" for f in common_set]
    return manifest_lines

def gen_release():
    try:
        shutil.rmtree(RELEASE_FOLDER)
    except FileNotFoundError:
        pass
    try:
        shutil.rmtree(ENGINE_STAGING_FOLDER)
    except FileNotFoundError:
        pass
    os.mkdir(RELEASE_FOLDER)
    os.mkdir(ENGINE_STAGING_FOLDER)
    vkq_staging = os.path.join(ENGINE_STAGING_FOLDER, "vkq")
    iw_staging = os.path.join(ENGINE_STAGING_FOLDER, "iw")
    os.mkdir(vkq_staging)
    os.mkdir(iw_staging)
    def exclusions_for_copy(dir, contents):
        if os.path.realpath(dir) != SRC_PATH:
            return []
        return EXCLUSIONS
    shutil.copytree(SRC_PATH, QUAKE_FOLDER, ignore=exclusions_for_copy)
    gen_toplevel_readme()
    gen_docs()
    gen_version_config()
    sql_timestamp = handle_zip(SQL_URL, SQL_LOCALFILE, QUAKE_FOLDER)
    print("SQL2 version: {}".format(SQL_VERSION))
    print("SQL2 timestamp: {}".format(sql_timestamp))
    timestamp = time.strftime("%B %Y")
    print("Quakestarter release: {}".format(RELEASE))
    print("Quakestarter timestamp: {}".format(timestamp))
    with open(os.path.join(QUAKE_FOLDER, "quakestarter_readme.html"), 'r') as f:
        readme_contents = f.readlines()
    gen_readme(readme_contents, "", "", sql_timestamp, timestamp)
    release_name = "quakestarter-noengine-" + RELEASE
    patch_autoexec()
    gen_release_manifest("noengine-manifest.txt")
    gen_release_manifest("manifest.txt")
    shutil.make_archive(release_name, "zip", root_dir=RELEASE_FOLDER, base_dir=".")
    unpatch_autoexec()
    vkq_timestamp = handle_zip(VKQ_URL, VKQ_LOCALFILE, vkq_staging)
    print("VKQ version: {}".format(VKQ_VERSION))
    print("VKQ timestamp: {}".format(vkq_timestamp))
    iw_timestamp = handle_zip(IW_URL, IW_LOCALFILE, iw_staging)
    print("IW version: {}".format(IW_VERSION))
    print("IW timestamp: {}".format(iw_timestamp))
    gen_readme(readme_contents, vkq_timestamp, iw_timestamp, sql_timestamp, timestamp)
    manifest_lines = merge_files("vkQuake", vkq_staging, "ironwail", iw_staging)
    with open(os.path.join(QUAKE_FOLDER, "engines_manifest.txt"), 'w') as f:
        f.writelines(manifest_lines)
    release_name = "quakestarter-" + RELEASE
    gen_release_manifest("manifest.txt")
    shutil.make_archive(release_name, "zip", root_dir=RELEASE_FOLDER, base_dir=".")
    shutil.rmtree(RELEASE_FOLDER)
    return 0

if __name__ == "__main__":
    sys.exit(gen_release())
