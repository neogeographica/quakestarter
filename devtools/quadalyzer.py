#!/usr/bin/env python3

# https://www.quaddicted.com/reviews/quaddicted_database.xml

import sys
import xml.etree.ElementTree as ET

from datetime import datetime


EPISODE_OR_HUB_MIN_MAPS = 5

EPISODE_RATING_GROUPS = [
  ('classic', datetime(2000, 8, 17, 0, 0), 3.8),
  ('modern', datetime(2015, 12, 25, 0, 0), 3.9),
  ('post AD', datetime(2020, 1, 1, 0, 0), 4.0),
  ('latest', datetime(9999, 1, 1, 0, 0), 4.0)
]

OTHER_RATING_GROUPS = [
  ('classic', datetime(2005, 11, 5, 0, 0), 4.3),
  ('post Quoth', datetime(2014, 1, 1, 0, 0), 4.3),
  ('age of jams', datetime(2020, 1, 1, 0, 0), 4.4),
  ('latest', datetime(9999, 1, 1, 0, 0), 4.4)
]


def get_episode_group(releaseinfo):
    for group in EPISODE_RATING_GROUPS:
        if group[1] > releaseinfo[1]:
            return group

def get_other_group(releaseinfo):
    for group in OTHER_RATING_GROUPS:
        if group[1] > releaseinfo[1]:
            return group

def analyze_db(dbfile):
    tree = ET.parse(dbfile)
    root = tree.getroot()
    episodes_or_hubs = []
    other = []
    for release in root:
        try:
            name = release.attrib['id']
            rating = float(release.attrib['normalized_users_rating'])
            datestr = release.find('date').text
            date = datetime.strptime(datestr, "%d.%m.%Y")
            is_episode_or_hub = False
            try:
                techinfo = release.find('techinfo')
                mapcount = len(techinfo.findall('startmap'))
                if mapcount >= EPISODE_OR_HUB_MIN_MAPS:
                    is_episode_or_hub = True
            except:
                pass
            try:
                tags = release.find('tags')
                for t in tags:
                    if t.text == 'episode':
                        is_episode_or_hub = True
            except:
                pass
            maptuple = (name, date, rating, datestr)
            if is_episode_or_hub:
                episodes_or_hubs.append(maptuple)
            else:
                other.append(maptuple)
        except:
            pass
    episodes_or_hubs.sort(key = lambda x: x[1])
    other.sort(key = lambda x: x[1])
    print("Episodes or hubs (need to check; !! = would pass \"Other\" rating bar too):")
    current_groupname = None
    for releaseinfo in episodes_or_hubs:
        group = get_episode_group(releaseinfo)
        if group[0] != current_groupname:
            current_groupname = group[0]
            print("*** " + current_groupname)
        if releaseinfo[2] >= group[2]:
            suffix = ""
            other_group = get_other_group(releaseinfo)
            if releaseinfo[2] >= other_group[2]:
                suffix = "!!"
            print(releaseinfo[0], releaseinfo[3], suffix)
    print()
    print("Other releases:")
    current_groupname = None
    for releaseinfo in other:
        group = get_other_group(releaseinfo)
        if group[0] != current_groupname:
            current_groupname = group[0]
            print("*** " + current_groupname)
        if releaseinfo[2] >= group[2]:
            print(releaseinfo[0], releaseinfo[3])


if __name__ == "__main__":
    sys.exit(analyze_db(sys.argv[1]))