#!/usr/bin/env python
# By Braddock Gaskill 8/11/09
# Prototypical Build System
# Using novel "Double Set" property classes

import os
import string

exeTargets=dict()
libTargets=dict()

class deset:
  class dimpl:
    def __init__(self, namevalue, members):
      self.name = namevalue[0]
      self.value = namevalue[1]
      self.members = members
  def __init__(self, namevalue):
    assert type(namevalue) == tuple, "deset usage error"
    if type(namevalue) == tuple:
      uset = duniv.get_deset(namevalue)
      if uset == None: # Make my own implementation
        self.impl = self.dimpl(namevalue, set())
        duniv.add_deset((namevalue), self)
      else:
        self.impl = uset.impl
  def name(self):
    return self.impl.name
  def value(self):
    return self.impl.value
  def members(self):
    return self.impl.members
  def add(self, x):
    if type(x) == list:
      for y in x:
        self.add(y)
      return
    x.props[self.impl.name] = self
    self.impl.members.add(x)
  def remove(self, x):
    del x.props[self.impl.name]
    self.impl.members.remove(x)
  def issuperset(self, x):
    return self.impl.members.issuperset(x)


class ditem(dict):
  def __init__(self, isUniverse=False):
    self.props = dict()
  def __getitem__(self, name):
    return self.props[name].value()
  def __setitem__(self, name, value):
    if self.props.has_key(name):
      s = self.props[name]
      s.remove(self) # obvious optimization here if old = new
    s = deset((name,value))
    s.add(self)
  def __delitem__(self, name):
    s = self.props[name]
    s.remove(self)
  def __eq__(self, other):
    return cmp(id(self),id(other))==0
  def __hash__(self):
    """Support primitive id hashing to participate in sets()"""
    return hash(id(self)) 
  
class duniverse:
  def __init__(self):
    self.desets = dict()
  def add_deset(self, namevalue, theset):
    self.desets[namevalue] = theset
  def get_deset(self, namevalue):
    return self.desets.get(namevalue, None)

# Dictionary of Universal Sets - contains everything
# Maps property (name,value) pairs to deset objects
duniv = duniverse()
targets = deset(("isTarget",True))

def getFileType(fname):
  if fname[-2:] == '.c':
    return ".c"
  elif fname[-2:] == '.h':
    return ".h"
  elif fname[-4:] == '.cpp':
    return ".cpp"
  elif fname[-4:] == '.hpp':
    return ".hpp"
  elif fname[-2:] == '.o':
    return ".o"
  elif fname[-2:] == '.a':
    return ".a"
  elif fname[-3:] == '.so':
    return ".so"
  else:
    return None

def updateFileStatus(fmember):
  """Update update time and existance"""
  fname = fmember["fileName"]
  fmember["fileExists"] = os.path.exists(fname)
  if fmember["fileExists"]:
    fmember["fileModified"] = os.path.getmtime(fname);
  

def addFile(n, fileType=None):
  print "addFile",n
  mems = deset(("fileName", n)).members()
  if len(mems) == 1:
    m = [x for x in mems][0]
  elif len(mems) == 0:
    m = ditem()
  else:
    assert len(mems) < 2, "fileName is not unique!"
  m["fileName"] = n
  if fileType == None:
    fileType = getFileType(n)
  if fileType != None:
    m["fileType"]= fileType
  updateFileStatus(m)
  return m

def addExe(n, sources):
  m = addFile(n, ".elf")
  m["isTarget"] = True
  deps = deset(((n,"dep"), True))
  m["dependencyClub"] = deps
  msrc = [addFile(s) for s in sources]
  deps.add(msrc)

def addLib(n, sources):
  m = addFile(n)
  m["isTarget"] = True
  deps = deset(((n,"dep"), True))
  m["dependencyClub"] = deps
  msrc = [addFile(s) for s in sources]
  deps.add(msrc)

isPosix = True

cc = "gcc"
cFlags = ["-std=c99", "-Winvalid-pch", "-Wall", "-Wno-long-long", "-pedantic"] 
includes="-I/usr/include/SDL"
#-o CMakeFiles/bgTreeCmd.dir/bgTree.c.o   -c /home/braddock/work/tviki/tviki/bgtree/bgTree.c

BGT_SRC=["bgCore.c", "crc32.c", "bgCore.h", "crc32.h", "bgDefines.h"]
addLib("libbgTree.a", BGT_SRC)

if isPosix:
  addExe("bgTreeCmd", ["bgTree.c", "libbgTree.a"])
  addExe("bgTest", ["bgTest.c", "libbgTree.a"])

def parseDepends(fname):
  f = open(fname, "r")
  lns = []
  line = ""
  for x in f:
    x = x.rstrip("\n")
    line += x.rstrip("\\")
    if x[-1] != "\\":
      lns.append(line)
      line = ""
  if len(line) > 0:
    lns.append(line)
  f.close()
  s1 = [x.split(":",1) for x in lns]
  s2 = [(x[0],x[1].split(" ")) for x in s1]
  s3 = [(x[0],[y for y in x[1] if len(y) > 0]) for x in s2]
  return s3

def addDepends(fname):
  deps = parseDepends(fname)
  print deps
  for ln in deps:
    t = ln[0]
    dtgt = addFile(t)
    dtgt["dependencyClub"] = deset(((t, "dep"), True))
    srcs = ln[1]
    msrcs = [addFile(s) for s in srcs]
    dtgt["dependencyClub"].add(msrcs)

def ccDepends(target):
  src = target["dependencyClub"].members()
  tmpfile = os.tmpnam()
  cmd = cc + " " + string.join(cFlags, " ") + " " + includes
  cmd += " -M -MF %s -MT %s " % (tmpfile, target["fileName"])
  cmd += string.join([x["fileName"] for x in src]," ")
  print cmd
  os.system(cmd)
  addDepends(tmpfile)

def ccCompile(target):
  #print "cc ",
  #print [(p[0], p[1].value()) for p in target.props.items()]
  src = target["dependencyClub"].members()
  cmd = cc + " " + string.join(cFlags, " ") + " " + includes
  cmd += " -o %s " % target["fileName"]
  cmd += string.join([x["fileName"] for x in src]," ")
  print cmd
  os.system(cmd)

for target in (deset(("isTarget",True)).members() & deset(("fileType",".a")).members()):
  ccDepends(target)
  #ccCompile(target)

for target in (deset(("isTarget",True)).members() & deset(("fileType",".elf")).members()):
  ccDepends(target)
  #ccCompile(target)

def PrintDepLevel(filename, level=0):
  aset = [x for x in deset(("fileName",filename)).members()]
  if len(aset) == 0:
    return
  tgt = [x for x in deset(("fileName",filename)).members()][0]
  if not tgt.props.has_key("dependencyClub"):
    return
  for dep in tgt["dependencyClub"].members():
    print " "*level + dep["fileName"]
  for dep in tgt["dependencyClub"].members():
    PrintDepLevel(dep["fileName"], level+4)

for target in deset(("isTarget",True)).members():
  print target["fileName"],": ",
  PrintDepLevel(target["fileName"], 0)
  #for dep in target["dependencyClub"].members():
  #  print dep["fileName"],[(p[0], p[1].value()) for p in dep.props.items()]
  print


