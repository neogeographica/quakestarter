#!/usr/bin/env python3

import contextlib
import os
import shutil
import sys
import time
import urllib.request
import zipfile

VERSION = "2.0.0-RC2"
ROOT_FOLDER = "Quake"
QSS_VERSION = "0.93.2ish"
QSS_URL = "https://fte.triptohell.info/moodles/qss/quakespasm_spiked_win64.zip"
QSS_LOCALFILE = "qss-temp.zip"
SQL_VERSION = "2.4"
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
            zf.extract(i, ROOT_FOLDER)
            time_tuple = i.date_time + (0, 0, -1)
            date_time = time.mktime(time_tuple)
            os.utime(os.path.join(ROOT_FOLDER, i.filename), (date_time, date_time))
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

def gen_release():
    script_path = os.path.abspath(sys.argv[0])
    src = os.path.realpath(os.path.dirname(os.path.dirname(script_path)))
    def exclusions_for_copy(dir, contents):
        if os.path.realpath(dir) != src:
            return []
        return EXCLUSIONS
    shutil.copytree(src, ROOT_FOLDER, ignore=exclusions_for_copy)
    qss_zip_contents, qss_timestamp = handle_zip(QSS_URL, QSS_LOCALFILE)
    print("QSS version: {}".format(QSS_VERSION))
    print("QSS timestamp: {}".format(qss_timestamp))
    _, sql_timestamp = handle_zip(SQL_URL, SQL_LOCALFILE)
    print("SQL2 version: {}".format(SQL_VERSION))
    print("SQL2 timestamp: {}".format(sql_timestamp))
    qss_manifest = [ l + '\r\n' for l in qss_zip_contents ]
    qss_manifest.insert(0, "\r\n")
    qss_manifest.insert(0, "manifest of Quakespasm-Spiked files:\r\n")
    with open(os.path.join(ROOT_FOLDER, "qss_manifest.txt"), 'w') as f:
        f.writelines(qss_manifest)
    timestamp = time.strftime("%B %Y")
    print("Quakestarter version: {}".format(VERSION))
    print("Quakestarter timestamp: {}".format(timestamp))
    with open(os.path.join(ROOT_FOLDER, "quakestarter_readme.txt"), 'r', newline='\r\n') as f:
        readme_contents = f.readlines()
    new_readme_contents = []
    for line in readme_contents:
        new_line = line.replace(
            "###QSS_VERSION###", QSS_VERSION).replace(
            "###QSS_TIMESTAMP###", qss_timestamp).replace(
            "###SQL_VERSION###", SQL_VERSION).replace(
            "###SQL_TIMESTAMP###", sql_timestamp).replace(
            "###VERSION###", VERSION).replace(
            "###TIMESTAMP###", timestamp)
        new_readme_contents.append(new_line)
    with open(os.path.join(ROOT_FOLDER, "quakestarter_readme.txt"), 'w') as f:
        f.writelines(new_readme_contents)
    release_name = "quakestarter-" + VERSION
    shutil.make_archive(release_name, "zip", base_dir=ROOT_FOLDER)
    shutil.rmtree(ROOT_FOLDER)
    return 0

if __name__ == "__main__":
    sys.exit(gen_release())
