#!/usr/bin/env python
#
# Reads TSV exported from VizieR and tries to integrate it with western
# star_names.fab from Stellarium.
#

import sys
import re


if len( sys.argv) != 3:
  print "Use: %s path-to-HIP-export.tsv path-to-star_name.fab" % sys.argv[0]
  sys.exit()


def _parse_right_ascension( representation):
  """
  Provides the Right Ascension from a representation in Hours, Minutes and Seconds.
  """
  match = re.match("(\d+) (\d+) ([\d\.]+)", representation)
  if match:
    hours, minutes, seconds = [ float( match.group( i)) for i in [ 1, 2, 3]]
    return hours + minutes/60 + seconds/3600
  else:
    raise Exception("Bad right ascension: %s" % representation)


def _parse_declination( representation):
  """
  Provides the Declination from a representation in Degrees, Minutes and Seconds.
  """
  match = re.match("([\+\-\d]+) (\d+) (\d+)", representation)
  if match:
    degrees, minutes, seconds = [ float( match.group( i)) for i in [ 1, 2, 3]]
    if 0 < degrees:
      return degrees + minutes/60 + seconds/3600
    else:
      return degrees - minutes/60 - seconds/3600
  else:
    raise Exception("Bad declination: %s" % representation)


name_of_object = {}

# Read the list of common names of stars
for line in file( sys.argv[2]).readlines():
  line = line.strip()
  hip_id, name = line.split("|")
  name_of_object[ int( hip_id)] = name


# Read the export of the Hipparcos catalogue
expected_fields = ["HIP", "RAhms", "DEdms", "Vmag"]
expecting = "header"
print "HIP\tRA2000\tDE2000\tVmag\tName"
for line in file( sys.argv[1]).readlines():
  line = line.strip()
  # Skip comments and blank lines
  if line.startswith("#") or 0 == len( line):
    continue
  elif expecting == "header":
    fields = line.split("\t")
    assert fields == expected_fields
    expecting = "divider"
  elif expecting == "divider" and "-"[0] == line[0]:
    expecting = "data"
  elif expecting == "data":
    value = line.split("\t")
    if len( expected_fields) == len( value):
      hip_id = int( value[0])
      try:
        name = name_of_object[ hip_id]
        del name_of_object[ hip_id]
      except KeyError:
        name = None
      right_ascension = _parse_right_ascension( value[1])
      declination     = _parse_declination( value[2])
      magnitude       = float( value[3])
      print "%i\t%.6f\t%.6f\t%.2f\t%s" % ( hip_id, right_ascension, declination, magnitude, name or "")
    else:
      print "Bad: %s" % line

# Some of these unused names are for objects as dim as Vmag=12
sys.stderr.write("Unused names: %s\n" % repr( name_of_object))

