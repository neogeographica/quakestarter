#!/usr/bin/env python3

import contextlib
import os
import shutil
import sys
import urllib.request
import zipfile

PACKAGE_VERSION = "2.0.0"
ROOT_FOLDER = "Quake"
QSS_URL = "https://fte.triptohell.info/moodles/qss/quakespasm_spiked_win64.zip"
QSS_LOCALFILE = "qss-temp.zip"
SQL_URL = "https://github.com/m-x-d/Simple-Quake-Launcher-2/releases/download/2.4/SQLauncher_2.4.zip"
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
    with zipfile.ZipFile(localfile, 'r') as zf:
        zip_contents = zf.namelist()
        zf.extractall(ROOT_FOLDER)
    os.remove(localfile)
    return zip_contents

def gen_release():
    script_path = os.path.abspath(sys.argv[0])
    src = os.path.realpath(os.path.dirname(os.path.dirname(script_path)))
    def exclusions_for_copy(dir, contents):
        if os.path.realpath(dir) != src:
            return []
        return EXCLUSIONS
    shutil.copytree(src, ROOT_FOLDER, ignore=exclusions_for_copy)
    qss_zip_contents = handle_zip(QSS_URL, QSS_LOCALFILE)
    handle_zip(SQL_URL, SQL_LOCALFILE)
    qss_manifest = [ l + '\n' for l in qss_zip_contents ]
    qss_manifest.insert(0, "\n")
    qss_manifest.insert(0, "manifest of Quakespasm-Spiked files:\n")
    with open(os.path.join(ROOT_FOLDER, "qss-manifest.txt"), 'w') as f:
        f.writelines(qss_manifest)
    release_name = "quake_sp_starter_pack-" + PACKAGE_VERSION
    shutil.make_archive(release_name, "zip", base_dir=ROOT_FOLDER)
    shutil.rmtree(ROOT_FOLDER)
    return 0

if __name__ == "__main__":
    sys.exit(gen_release())
