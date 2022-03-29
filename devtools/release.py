#!/usr/bin/env python3

import contextlib
import os
import shutil
import sys
import time
import urllib.request
import zipfile

VERSION = "2.4.0"
RELEASE_FOLDER = "release." + str(os.getpid())
QUAKE_FOLDER = os.path.join(RELEASE_FOLDER, "Quake")
QSS_VERSION = "2021-10-14"
QSS_URL = "https://triptohell.info/moodles/qss/quakespasm_spiked_win64_dev.zip"
QSS_LOCALFILE = "qss-temp.zip"
SQL_VERSION = "2.5"
SQL_URL = "https://github.com/m-x-d/Simple-Quake-Launcher-2/releases/download/{0}/SQLauncher_{0}.zip".format(SQL_VERSION)
SQL_LOCALFILE = "sql-temp.zip"
EXCLUSIONS = [
    ".git",
    ".gitattributes",
    ".gitignore",
    "devtools",
    "README.md"
]

def handle_zip(url, localfile):
    with contextlib.closing(urllib.request.urlopen(url)) as instream:
        with open(localfile, 'wb') as outstream:
            outstream.write(instream.read())
    latest_year = 1970
    latest_month = 1
    timestamp = "???"
    with zipfile.ZipFile(localfile, 'r') as zf:
        zip_contents = zf.namelist()
        for i in zf.infolist():
            zf.extract(i, QUAKE_FOLDER)
            time_tuple = i.date_time + (0, 0, -1)
            date_time = time.mktime(time_tuple)
            os.utime(os.path.join(QUAKE_FOLDER, i.filename), (date_time, date_time))
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
    return zip_contents, timestamp

def gen_toplevel_readme():
    with open(os.path.join(RELEASE_FOLDER, "how_to_use_quakestarter.txt"), 'w', newline='\r\n') as f:
        f.write("""\
The "Quake" folder here can be the start of a new Quake installation, so you
can put it anywhere you'd like your Quake game files to be (as long as you
don't choose some special/protected location). Or if you already have an
existing Quake installation that you'd like to continue to use, you can move
the files from this Quake folder into that existing folder.

In either case, before you get started: open the "quakestarter_readme.txt"
file from inside this Quake folder, and have a look. That readme file will
guide you through any necessary setup, step-by-step.
""")

def gen_readme(readme_contents, qss_timestamp, sql_timestamp, timestamp):
    new_readme_contents= []
    skip_next = False
    for line in readme_contents:
        if skip_next:
            skip_next = False
            continue
        if (qss_timestamp == "") and ("###QSS_VERSION###" in line):
            skip_next = True
        else:
            new_line = line.replace(
                "###QSS_VERSION###", QSS_VERSION).replace(
                "###QSS_TIMESTAMP###", qss_timestamp).replace(
                "###SQL_VERSION###", SQL_VERSION).replace(
                "###SQL_TIMESTAMP###", sql_timestamp).replace(
                "###VERSION###", VERSION).replace(
                "###TIMESTAMP###", timestamp)
            new_readme_contents.append(new_line)
    with open(os.path.join(QUAKE_FOLDER, "quakestarter_readme.txt"), 'w') as f:
        f.writelines(new_readme_contents)

def patch_autoexec():
    autoexec_path = os.path.join(QUAKE_FOLDER, "id1", "autoexec.cfg.example")
    shutil.copy2(autoexec_path, "autoexec.cfg.example.bak")
    with open(autoexec_path, 'r', newline='\r\n') as f:
        autoexec_contents = f.readlines()
    new_autoexec_contents= []
    for line in autoexec_contents:
        if line.lower().startswith("host_maxfps "):
            new_autoexec_contents.append(
                "// Since this package does not include Quakespasm-Spiked, this setting is\r\n")
            new_autoexec_contents.append(
                "// commented out for safety. Remove the leading doubleslash to activate it.\r\n")
            new_autoexec_contents.append("//" + line)
        else:
            new_autoexec_contents.append(line)
    with open(autoexec_path, 'w') as f:
        f.writelines(new_autoexec_contents)
    shutil.copystat("autoexec.cfg.example.bak", autoexec_path)

def unpatch_autoexec():
    autoexec_path = os.path.join(QUAKE_FOLDER, "id1", "autoexec.cfg.example")
    shutil.move("autoexec.cfg.example.bak", autoexec_path)

def gen_release():
    script_path = os.path.abspath(sys.argv[0])
    src = os.path.realpath(os.path.dirname(os.path.dirname(script_path)))
    os.mkdir(RELEASE_FOLDER)
    def exclusions_for_copy(dir, contents):
        if os.path.realpath(dir) != src:
            return []
        return EXCLUSIONS
    shutil.copytree(src, QUAKE_FOLDER, ignore=exclusions_for_copy)
    gen_toplevel_readme()
    _, sql_timestamp = handle_zip(SQL_URL, SQL_LOCALFILE)
    print("SQL2 version: {}".format(SQL_VERSION))
    print("SQL2 timestamp: {}".format(sql_timestamp))
    timestamp = time.strftime("%B %Y")
    print("Quakestarter version: {}".format(VERSION))
    print("Quakestarter timestamp: {}".format(timestamp))
    with open(os.path.join(QUAKE_FOLDER, "quakestarter_readme.txt"), 'r', newline='\r\n') as f:
        readme_contents = f.readlines()
    gen_readme(readme_contents, "", sql_timestamp, timestamp)
    release_name = "quakestarter-noengine-" + VERSION
    patch_autoexec()
    shutil.make_archive(release_name, "zip", root_dir=RELEASE_FOLDER, base_dir=".")
    unpatch_autoexec()
    qss_zip_contents, qss_timestamp = handle_zip(QSS_URL, QSS_LOCALFILE)
    print("QSS version: {}".format(QSS_VERSION))
    print("QSS timestamp: {}".format(qss_timestamp))
    gen_readme(readme_contents, qss_timestamp, sql_timestamp, timestamp)
    qss_manifest = [ l + '\r\n' for l in qss_zip_contents ]
    qss_manifest.insert(0, "\r\n")
    qss_manifest.insert(0, "manifest of Quakespasm-Spiked files:\r\n")
    with open(os.path.join(QUAKE_FOLDER, "qss_manifest.txt"), 'w') as f:
        f.writelines(qss_manifest)
    release_name = "quakestarter-" + VERSION
    shutil.make_archive(release_name, "zip", root_dir=RELEASE_FOLDER, base_dir=".")
    shutil.rmtree(RELEASE_FOLDER)
    return 0

if __name__ == "__main__":
    sys.exit(gen_release())
