#!/usr/bin/env python
import sys
import string
import zlib
import struct
import time

def ParseSchema(ln, schema):
  """ Parses a tab-delimited line using the typing information contained in
  schema.  Returns array of values."""
  ln = ln.rstrip("\n")
  ln = ln.split("\t")
  if len(ln) != len(string.replace(schema, "K", "")):
    raise Exception("Line does not match schema %s" % string.join(ln,"\t"))
  def doubleK():
    li=0
    for si in schema:
      if si == 'K':
        yield 0
      else:
        yield ln[li]
        li += 1
  ln = [x for x in doubleK()]
  v = []
  for i in xrange(len(schema)):
    if schema[i] == 's':
      v.append(ln[i].replace("\\n","\n").replace("\\t","\t"))
    elif schema[i] == 'x':
      v.append(int(ln[i], 16))
    elif schema[i] in ('i', 'I', 'h', 'H'):
      v.append(int(ln[i]))
    elif schema[i] in ('f', 'd'):
      v.append(float(ln[i]))
    elif schema[i] == 'K': # key string substitution
      # Insert dummies into v where we have K
      v.append(ln[0])
    else:
      raise Exception("Unknown Type Character in Schema %c" % schema[i])
  return v

def Serialize(v, schema, blobfile):
  """Serialize a set of values into blobfile according to schema"""
  if len(v) == 0:
    return 0
  buf=""
  for i in xrange(len(schema)):
    if schema[i] in ('I', 'x'):
      buf += struct.pack("I", v[i])
    elif schema[i] in ('i', 'h', 'H', 'f', 'd','b','B'):
      buf += struct.pack(schema[i], v[i])
    elif schema[i] in ('s', 'K'):
      buf += struct.pack('I', len(v[i]))
      buf += struct.pack(str(len(v[i])) + 's', v[i])
    else:
      raise Exception("Unknown Schema Character in Serialize %c" % schema[i])
  if len(buf) > 0:
    blobfile.write(buf)
  return len(buf)

def NormalizeKey(field, schema):
  if schema[0] == 's':
    return zlib.crc32(field) & 0xffffffff
  else:
    return field

def main(argv=None):
  if argv is None:
    argv = sys.argv
  if len(argv) < 2:
    sys.stderr.write("USAGE: %s <schema> [<blobfname>]\n");
    sys.stderr.write("Reads tab-delimited rows of data from stdin.\n")
    sys.stderr.write("Parses stdin data according to <schema> type information.\n")
    sys.stderr.write("If rows contain more than two columns, or if the second column is not of type int, then writes serialized row data to <blobfname>.\n")
    sys.stderr.write("Sorts all key/bloboffset pairs and writes them to stdout.\n")
    return -1
  schema = argv[1]
  bloboffset = 0
  if len(argv) > 2:
    blobfile = open(argv[2], "wb")
  else:
    blobfile = None
  linenum = 0
  starttime = time.time()
  keyvals = []
  for ln in sys.stdin:
    linenum += 1
    if not linenum % 100000:
      sys.stderr.write("\n%i" % linenum)
      t = time.time() - starttime
      sys.stderr.write(" t=%is %i lines/s " % (t, float(linenum)/t))
    elif not linenum % 2000:
      sys.stderr.write(".")
    v = ParseSchema(ln, schema)
    # First we convert key to crc32 if non-int
    k = NormalizeKey(v[0], schema)
    # Next we stash any strings or floats into blobfile
    # We only do this if there are more than two columns,
    # or if the second column is non-int (can't be stored directly)
    if blobfile and (len(v) > 2 or schema[1] not in ('x','i')):
      value = bloboffset
      bloboffset += Serialize(v[1:], schema[1:], blobfile)
    else:
      value = v[1]
    keyvals.append((k,value))
  if blobfile is not None:
    blobfile.close()
  sys.stderr.write("\nSorting....\n")
  t = time.time()
  keyvals.sort(lambda x,y: x[0]-y[0])
  sys.stderr.write("Sorted %i records in %f seconds\n" % (len(keyvals), time.time() - t))
  sys.stderr.write("Writing Key/Value Pairs to stdout\n")
  for kv in keyvals:
    sys.stdout.write("%x\t%x\n" % (kv[0], kv[1])) 
  sys.stderr.write("Read, Sorted, and Wrote %i records in %i seconds\n" % (len(keyvals), time.time() - starttime))
  return 0

if __name__ == "__main__":
  sys.exit(main())

