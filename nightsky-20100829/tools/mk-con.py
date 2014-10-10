#!/usr/bin/env python
#
# Reads Stellarium constellation data and tries to integrate it with TSV from VizieR/Hipparcos.
#

import sys
import re


if len( sys.argv) != 2:
  print "Use: %s path-to-HIP-export.tsv" % sys.argv[0]
  sys.exit()


class Object:
  pass


def _parse_right_ascension( representation):
  """
  Provides the Right Ascension from a representation in Hours, Minutes and Seconds.
  """
  match = re.match("(\d+) (\d+) ([\d\.]+)", representation)
  if match:
    hours, minutes, seconds = [ match.group( i) for i in [ 1, 2, 3]]
    return float( hours) + float( minutes)/60 + float( seconds)/3600
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


# Read the export of the Hipparcos catalogue
object_with_id = {}
expected_fields = ["HIP", "RAhms", "DEdms", "Vmag"]
expecting = "header"
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
      ob = Object()
      ob.right_ascension = _parse_right_ascension( value[1])
      ob.declination     = _parse_declination( value[2])
      ob.magnitude       = float( value[3])
      object_with_id[ value[0]] = ob
    else:
      print "Bad: %s" % line


name_for_abbrev = {}

for line in file("out-of-control/constellation_names.eng.fab").readlines():
  line = line.strip()
  abbrev, name = line.split("\t")
  name_for_abbrev[ abbrev] = name


for line in file("out-of-control/constellationship.fab").readlines():
  line = line.strip()
  values = line.split()
  abbrev = values.pop(0)
  count = int( values.pop(0))
  con_lines = []
  while 0 < count:
    from_id = values.pop(0)
    to_id = values.pop(0)
    if from_id not in object_with_id:
      sys.stderr.write("Absent: %s\n" % from_id)
    if to_id not in object_with_id:
      sys.stderr.write("Absent: %s\n" % to_id)
    con_lines.append("%s-%s" % ( from_id, to_id))
    count -= 1
  print "%s\t%s" % ( name_for_abbrev[abbrev], "\t".join( con_lines))

