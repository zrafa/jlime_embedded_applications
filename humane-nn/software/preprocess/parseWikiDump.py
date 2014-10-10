#!/usr/bin/env python
import bz2
import sys
import xml.sax
import re
import zlib
import string
import unittest
from cStringIO import StringIO
import csv
import pdb
import getopt
import os

whitelist = None
articles = {}

class Section:
  def __init__(self, crc, level, title, parent):
    self.crc=crc
    self.level=level
    self.title=title
    self.parent=parent
    self.text=""
    self.links=[] # [(title, offset), ...]
    self.title1Grams=[] # [(text, offset), ...]
    self.title2Grams=[] # [(text, text, offset, offset), ...]
    self.text1Grams=[] # [(text, offset), ...]
    self.text2Grams=[] # [(text, text, offset, offset), ...]

  def write(self, fout):
    """FORMAT: crc \t level \t parent \t title \t text"""
    fout.write( ("%08X" % self.crc) + "\t" + str(self.level) + "\t")
    fout.write( ("%08X" % self.parent) + "\t" + self.title.replace("\t","\\t").encode('utf-8') + "\t")
    fout.write( self.text.replace("\n","""\n""") )
    fout.write("\n")

  def writeHeader(self, fout):
    fout.write( "crc \t level \t parent \t title \t text \n")

class Article:
  def __init__(self, title):
    self.title = title
    self.size = 0
    self.topSize = 0 # Size of top-level summary text
    self.links = set()
    self.rlinks = set()
    self.redirect = 0

  def addSections(self, sections):
    if len(sections) > 0:
      self.topSize = len(sections[0].title) + len(sections[0].text)
    for s in sections:
      self.size += len(s.title) + len(s.text)
      self.links = self.links.union(set(s.links))

  def write(self, fd):
    fd.write( ("%08x" % CalcCrc(self.title)) + "\t" + ("%08x" % self.redirect) + "\t")
    fd.write( str(self.size) + "\t" + str(self.topSize) + "\t" + str(len(self.rlinks)) + "\t" + str(len(self.links)) + "\t")
    fd.write( self.title.encode("utf-8") + "\n")

  def writeHeader(self, fout):
    fout.write( "crc \t redirect \t textsize \t toptextsize\t in-degree \t out-degree \t title \n")

  def writeLinks(self, fout):
    fout.write( ("%08x" % CalcCrc(self.title)) + "\t" + str(len(self.links)) )
    for lnk in self.links:
      fout.write( "\t" + ("%08x" % lnk) )
    fout.write("\n")

def ReadArticleFromCsv(row):
  a = Article(row[6].decode("utf-8"))
  a.redirect = int(row[1],16)
  a.size = int(row[2])
  a.topSize = int(row[3])
  a.rlinks = range(0, int(row[4]))
  a.links = range(0, int(row[5]))
  return a

def filterMarkup(section, t):
  """Ref: http://meta.wikimedia.org/wiki/Help:Wikitext_reference"""
  t = t.lstrip("\n"); # Remove leading blank lines
  t = re.sub('(?s)<!--.*?-->', "", t) # force removing comments
  t = re.sub("(\n\[\[[a-z][a-z][\w-]*:[^:\]]+\]\])+$","", t) # force remove last (=languages) list
  t = re.sub("(?u)^ \t]*==[ \t]*(\w)[ \t]*==[ \t]*\n", '[Image: \\1)]', t)
  def img2alt(m):
    imgname, other = m.groups()
    alttxt = other[other.rfind('|')+1:]
    return '[Image: %s]' % (alttxt)
  t = re.sub("\[\[[Ii]mage:([^.]*)(.*?)\]\]", img2alt, t) # todo: parser l'interieur
  def linkrow(m):
    oldlen = m.span()[1] - m.span()[0]
    linkName = m.groups()[-1]
    if linkName != None:
      section.links.append(CalcCrc(linkName))
    if m.groups()[2] != None:
      text = m.groups()[2]
    else:
      text = m.groups()[0]
    return text
  t = re.sub("(?:\[\[([^]|[:]*)\|([^][]*)\]\])|(?:\[\[([^\]|]*)\]\])", linkrow, t)
  t = re.sub("(?=\[\[([^]|[:]*)\|([^][]*)\]\])|(?=\[\[([^\]|]*)\]\])", linkrow, t)
  # Remove <ref>...</ref>
  rex = re.compile("<ref(.*?)>.*?</ref>",re.MULTILINE | re.DOTALL)
  t = re.sub(rex, "", t)
  rex = re.compile("<ref(.*?)/>",re.MULTILINE | re.DOTALL)
  t = re.sub(rex, "", t)
  t = re.sub("&quot;",'"',t)
  t = re.sub("&amp;",'&',t)
  t = re.sub("&nbsp;"," ",t)
  # For now, eliminate all macros
  rex = re.compile("{{.*?{{.*?}}.*?}}",re.MULTILINE | re.DOTALL)
  t = re.sub(rex, "", t)
  rex = re.compile("{{.*?}}",re.MULTILINE | re.DOTALL)
  t = re.sub(rex, "", t)
  # external links
  rex = re.compile("\[[^[].*? (.*?)\]",re.MULTILINE | re.DOTALL)
  t = re.sub(rex, "\\1", t)

  #t = re.subn('\n----', '\n<hr/>', t)[0]
  # Eliminate Tables for now
  rex = re.compile("{\|((.|\n)*?)\|}",re.MULTILINE)
  t = re.sub(rex, "", t)
  # Eliminate excessive spacing (often due to elimination of other elements)
  t = re.sub("\n\n+", "\n\n", t)
  t = string.replace((t.strip("\n")),"\n","\\n").replace("\t","\\t").replace("\r","\\r").encode('utf-8')
  return t

def PrintSections(fout, sections):
  for s in sections:
    s.write(fout)

def PrettyPrintSections(fout, sections):
  for x in sections:
    fout.write("\n" + "="*x.level + x.title.encode("utf-8") + "\n\n")
    t = x.text
    t = string.replace(t, "\\n", "\n")
    t = string.replace(t, "\\t", "\t")
    fout.write(t + "\n")
    

def CalcCrc(s):
  return zlib.crc32(s.upper().encode('utf-8')) & 0xffffffff

def ReverseLinks(title, links):
  global articles
  for lnk in links:
    art = articles.get(lnk)
    art.rlinks.add(title)
    articles[lnk] = art

def WriteReverseLinks(fout, rlnks):
  for ritem in rlnks.items():
    fout.write( ("%08x" % ritem[0])) + "\t" + str(len(ritem[1]))
    for lnk in ritem[1]:
      fout.write( "\t" + ("%08x" % lnk) )
    fout.write("\n")

def LoadReverseLinks(flnk):
  """Returns a set of reverse links given a tab delimited .lnk file"""
  r = {}
  for row in csv.reader(flnk, delimiter="\t", quoting=csv.QUOTE_NONE):
    src = row[0]
    for dst in row[2:]:
      rset = r.get(dst, set())
      rset.add(src)
      r[dst] = rset
  return r

def LoadReverseLinkCounts(flnk):
  """Returns a set of reverse links given a tab delimited .lnk file"""
  r = {}
  for row in csv.reader(flnk, delimiter="\t", quoting=csv.QUOTE_NONE):
    src = row[0]
    for dst in row[2:]:
      rset = r.get(dst, 0)
      rset += 1
      r[dst] = rset
  return r

def WriteReverseLinksOBSOLETE(fd):
  global articles
  sorted = articles.items()
  sorted.sort(lambda x,y: len(y[1].rlinks) - len(x[1].rlinks))
  for lnks in sorted:
    fd.write(str(lnks[0]))
    for lnk in lnks[1].rlinks:
      fd.write("\t" + lnk.encode("utf-8"))
    fd.write("\n")

def WriteArticles(fd, arts):
  sorted = arts.items()
  sorted.sort(lambda x,y: len(y[1].rlinks) - len(x[1].rlinks))
  for a in sorted:
    a[1].write(fd)

def ParsePageSections(pageTitle, pageText):
  HeadRegex = "(={2,5}) *([^=\n]+)={2,5}[^\n]*((\n|.)*)"
  crc = CalcCrc(pageTitle)
  sections = []
  parent = []

  splits = re.split("\n(?=={2,5}[^=\n]+={2,5})",pageText)

  sec = Section(crc, 0, pageTitle, 0)
  x = splits[0]
  match = re.match(HeadRegex,x)
  # Handle top level text, if any
  if match == None:  # No header found for this section == top level text
    # REDIRECT is a special top-level case
    m = re.match("#REDIRECT \[\[([^\]]+)\]\]",x)
    if m != None:
      crc2 = CalcCrc(m.group(1))
      sec.text = m.group(1).encode('utf-8') # Could be pruned
      sec.parent = crc2 # level 0 "parent", unique quality of redirects
    else:
      sec.text = filterMarkup(sec, x)
    splits = splits[1:]
  parent.append(crc)
  sections.append(sec)
  crc += 1

  # Handle each header section in turn
  for x in splits:
    if x == None or len(x) == 0:
      continue
    match = re.match(HeadRegex,x)
    if match == None:
      sys.stdout.write("No Header Found in section: " + x.encode("utf-8"))
      pdb.set_trace()
      continue
    equals = match.group(1)
    newlevel = len(equals) - 1
    sec = Section(crc, newlevel, string.rstrip(match.group(2)), 0)
    sec.text = filterMarkup(sec, match.group(3))
    parent = parent[:newlevel]
    sec.parent = parent[-1]
    parent.append(crc)
    sections.append(sec)
    crc += 1
  return sections

###
### Macro-specific parsing
###
# Macro content may introduces "\n" which conflicts with list-parsing code, thus s/\n/ /
def macroGeneric(mo):
  argv = mo.group()[2:-2].replace('\n', '').split('|')
  # Only one macro example implemented so far :-)
  if argv[0].startswith('formatnum:'):
    t = argv[0][10:]
  #elif argv[0].startswith(....): t = ...
  elif argv[0].startswith('main'):
    txt = "(main article : [[%s]])" % argv[1]
    t = '<i><font color="#FF4400">%s</font></i><br/>' % txt
  elif argv[0].startswith('reflist'):
    t = "<references/>"
  else:
    txt = "<b> %s</b> %s " % (argv[0], ", ".join(argv[1:]))
    t = '<i><font color="#FF4400">%s</font></i>' % txt
  return t

class XmlContentHandler(xml.sax.ContentHandler):
  def __init__(self, fsec, fart, flnk):
    self.element=['top']
    self.title=""
    self.text=[]
    self.fsec = fsec
    self.fart = fart
    self.flnk = flnk
    self.cnt = 0

  def characters(self, content):
    if self.element[-1] == 'text':
      self.text.append( content )
    elif self.element[-1] == 'title':
      self.title += content
    return

  def ignorableWhitespace(self, content):
    #print "Ignorable Whitespace"
    return

  def endElement(self, name):
    #print " </", name,"> "
    self.element.pop()
    if name == 'page':
      if not (self.cnt % 100):
        print self.cnt, self.title
      self.cnt += 1
      if whitelist == None or (CalcCrc(self.title) in whitelist):
        txt = string.join(self.text,'') # much faster than seperate concatenations
        sections = ParsePageSections(self.title, txt)
        art = Article(self.title)
        art.addSections(sections)
        art.redirect = sections[0].parent
        #ReverseLinks(self.title, art.links)
        PrintSections(self.fsec, sections)
        art.write(self.fart)
        art.writeLinks(self.flnk)
      #else:
      #  sys.stderr.write("Skipping " + self.title.encode("utf-8") + "\n")
      self.text = []
      self.title = ""
    return

  def startElement(self,name, attr):
    #print "<", name, attr.items(), "> ",
    self.element.append(name)
    return

def ReadWhitelist(fname):
  global whitelist
  whitelist = set()
  for row in csv.reader(open(fname), delimiter="\t", quoting=csv.QUOTE_NONE):
    t = row[1].replace("_"," ")
    whitelist.add(CalcCrc(t.decode('utf-8')))

def StringToKeywords(title):
  stopwords = set(['OF','THE','AND','IN','DE','A','FOR','TO','&','ON','(DISAMBIGUATION)'])
  words = [x.upper() for x in string.split(title) if x.upper() not in stopwords]
  crc = CalcCrc(title)
  return [(CalcCrc(w), crc) for w in words]

class FilterUnitTestCase(unittest.TestCase):

  def testLinks(self):
    a1="[[hello world]] okay [[hello|hi]]"
    a2="hello world okay hello"
    sec = Section(0, 0, "Title", 0)
    res = filterMarkup(sec, a1)
    self.assertEquals(res, a2)
    sections = ParsePageSections("HelloWorld", a1)
    self.assertEquals(sections[0].text, a2)
  def testParseSections(self):
    accepted = """92018651	0	00000000	Title1	This is the main body.
92018652	1	92018651	Header1	This is header1 body.\\nParagraph Two!\\nParagraph Three!
92018653	2	92018652	SubsectionA	This is Subsection A.
92018654	2	92018652	SubsectionB	Text of subsec B
92018655	1	92018651	Header 2	hdr2
"""
    buf = StringIO() 
    a1="""This is the main body.
== Header1 ==
This is header1 body.

Paragraph Two!


Paragraph Three!

=== SubsectionA ===
This is Subsection A.
=== SubsectionB ===
Text of subsec B
== Header 2 ==
hdr2
"""
    sections = ParsePageSections("Title1", a1)
    self.assertEquals(len(sections), 5)
    self.assertEquals(sections[1].text, "This is header1 body.\\nParagraph Two!\\nParagraph Three!")
    self.assertEquals(sections[2].title, "SubsectionA")
    PrintSections(buf, sections)
    self.assertEquals(buf.getvalue(), accepted)
  def runTest(self):
    self.testLinks()
    self.testParseSections()

def PrintUsage(argv, fhandle=None):
  if fhandle == None:
    f=sys.stdout
  else:
    f=fhandle
  print >>f, "USAGE:", argv[0], "--test"
  print >>f, "USAGE:", argv[0], "--basename=<outname> [--stage1 --fromDump=<dump.xml.bz2>] \\"
  print >>f, "\t", " [--stage2] [--stage3] \\"
  print >>f, "\t", " [--stage4 --maxSize=<#bytes> --maxTopSize=<#bytes>] [--stage5] \\"
  print >>f, "\t", " [--stage6] [--cleanup]"
  print >>f, "  --fromDump specifies a Wikipedia \"pages-articles\" dump to parse" 
  print >>f, "  --maxSize is the maximum size in bytes of articles to keep full text"
  print >>f, "  --maxTopSize is the maximum size in bytes of articles to keep top section (summary) text"

class Usage(Exception):
  def __init__(self, msg):
    self.msg = msg

def main(argv=None):
  global whitelist
  if argv is None:
    argv = sys.argv
  try:
    try:
      opts, args = getopt.getopt(argv[1:], "h", ["help", "fromDump=", "basename=", "test", "stage1", "stage2", "stage3", "stage4", "stage5", "stage6", "stage7", "cleanup", "maxSize=", "maxTopSize=", "testText="])
      dopts = dict(opts)
    except getopt.error, msg:
      raise Usage(msg)
    if dopts.has_key("--help") or dopts.has_key("-h"):
      PrintUsage(argv)
      return 0
    if dopts.has_key("--test"):
      argv = argv[:-1]
      unittest.main(argv = argv)
      suite = unittest.TestSuite()
      suite.addTest(FilterUnitTestCase())
      unittest.TextTestRunner().run(suite)
      return(0)
    if dopts.has_key("--testText"):
      fname = dopts["--testText"]
      if fname == "-":
        f = sys.stdin
      else:
        f = open(fname, "r")
      txt = f.read()
      txt = txt.decode("utf-8")
      txt = txt.replace("&lt;","<")
      txt = txt.replace("&gt;",">")
      txt = txt.replace("&quot;",'"')
      secs = ParsePageSections("TITLE", txt)
      PrettyPrintSections(sys.stdout, secs)
      print "TAB FORMAT"
      PrintSections(sys.stdout, secs)
      return 0
    if (not dopts.has_key("--basename")):
      raise Usage("--basename required")
    else:
      basename = dopts["--basename"]
    # Test for commands we may need later
    os.environ['PATH'] += ":../bgtree/:../build/unix/bgtree"
    if dopts.has_key("--stage5") or dopts.has_key("--stage6") or dopts.has_key("--stage7"):
      ret = os.system("which bgPrep.py")
      if ret != 0:
        print >>sys.stderr, "ERROR: could not find bgPrep.py in path.  Please set path."
        return -1
      ret = os.system("which bgTreeCmd")
      if ret != 0:
        print >>sys.stderr, "ERROR: could not find bgTreeCmd in path.  Please set path."
        return -3
    if dopts.has_key("--stage1"):
      print >>sys.stderr, "STAGE 1: Parse Article Data From Dump File"
      if dopts.has_key("--fromDump"):
        dumpname = dopts["--fromDump"]
      else:
        raise Usage("--fromDump required")
      f = bz2.BZ2File(dumpname,'r')
      fsec = open(basename + ".sec", "w")
      fart = open(basename + ".art","w")
      flnk = open(basename + ".lnk","w")
      xml.sax.parse(f, XmlContentHandler(fsec, fart, flnk))
    if dopts.has_key("--stage2"):
      print >>sys.stderr, "STAGE 2a: Computing Reverse Link In-Degree Counts"
      flnk = open(basename + ".lnk","r")
      rlnks = LoadReverseLinkCounts(flnk)
      print >>sys.stderr, "STAGE 2b: Writing Reverse Link In-Degree Article Table"
      fart = open(basename + ".art", "r")
      fart2 = open(basename + ".art2", "w")
      for row in csv.reader(fart, delimiter="\t", quoting=csv.QUOTE_NONE):
        a = ReadArticleFromCsv(row)       
        a.rlinks = range(0, rlnks.get(row[0],0))
        a.write(fart2)
      fart.close()
      fart2.close()
      print >>sys.stderr, "STAGE 2c: Renaming new article file over old"
      os.rename(basename + ".art2", basename + ".art")
    if dopts.has_key("--stage3"):
      print >>sys.stderr,"STAGE 3a: Sorting Articles by In-Degree"
      cmd = "sort -k5 -r -n " + basename + ".art >" +basename + ".sorted"     
      print >>sys.stderr, cmd
      os.system(cmd)
    if dopts.has_key("--stage4"):
      print >>sys.stderr, 'STAGE 4a: Creating whitelist from sorted articles'
      maxSize = 1e12
      if dopts.has_key("--maxSize"):
        maxSize = int(dopts["--maxSize"])
      else:
        raise UsageError("--maxSize argument required for stage4")
      if dopts.has_key("--maxTopSize"):
        maxTopSize = int(dopts["--maxTopSize"])
      else:
        raise UsageError("--maxTopSize argument required for stage4")
      cumSize = 0
      whitelist = set()
      graylist = set()
      fsorted = open(basename + ".sorted", "r")
      rows = csv.reader(fsorted, delimiter="\t", quoting=csv.QUOTE_NONE)
      for row in rows:
        a = ReadArticleFromCsv(row)       
        cumSize += a.size
        if cumSize > maxSize:
          break
        whitelist.add(int(row[0],16))
      print >>sys.stderr, 'STAGE 4b: Creating graylist (top section only) article list'
      cumTopSize = 0
      for row in rows:
        a = ReadArticleFromCsv(row)       
        cumTopSize += a.size
        if cumTopSize > maxTopSize:
          break
        graylist.add(int(row[0],16))
      print >>sys.stderr, "  len(whitelist)=",len(whitelist),"sz=",cumSize,"len(graylist)=",len(graylist),"sz=",cumTopSize
      print >>sys.stderr, 'STAGE 4c: Creating pruned section list'
      fsec = open(basename + ".sec", "r")
      fprune = open(basename + ".pruned", "w")
      run=0
      for ln in fsec:
        if ln.rstrip() != "":
          row = ln.split("\t")
          try:
            crc = int(row[0], 16)
            parent = int(row[2], 16)
            if crc in whitelist:
              if crc != parent: # Exclude redirect to self due to case insensitivity
                run = crc
            if crc == run:
              fprune.write(ln)
              run = run + 1
            elif crc in graylist:
              fprune.write(ln) # only write top level text, don't start a run
            elif (int(row[1]) == 0) and (parent in whitelist or parent in graylist):
              # Save redirect to one of our whitelist or graylisted articles
              fprune.write(ln)
          except ValueError:
            print "ERROR: Invalid row found:", ln
    if dopts.has_key("--stage5"):
      print >>sys.stderr, "STAGE 5a: Converting to BGTree blobfile and key pairs"
      print >>sys.stderr, "STAGE 5b: Creating BGTree Database"
      cmd = "cat " +basename+ ".pruned | bgPrep.py xixss "+basename+"-sec.bgb >"+basename+"-sec.bgprep"
      print >>sys.stderr, cmd
      os.system(cmd)
      cmd = "bgTreeCmd create "+basename+"-sec.bgt `wc -l "+basename+"-sec.bgprep | cut -f1 -d' '` <" + basename+"-sec.bgprep"
      print >>sys.stderr, cmd
      os.system(cmd)
    if dopts.has_key("--stage6"):
      print >>sys.stderr, "STAGE 6a: Generating prefix table"
      fprune = open(basename + ".pruned", "r")
      fpre = open(basename + ".pre", "w")
      #for row in csv.reader(fprune, delimiter="\t", quoting=csv.QUOTE_NONE):
      for row in fprune:
        row = string.split(row, "\t")
        crc = int(row[0], 16)
        parent = int(row[2], 16)
        title = row[3].decode('utf-8')
        if parent == 0: # We only care about article titles
          for i in range(1, len(title)):
            fpre.write("%08x" % CalcCrc(title[:i]) + "\t" + row[0].encode('utf-8') )
            #+ "\t" + title[:i].encode('utf-8') + 
            fpre.write("\n")
      fpre.close()
      fprune.close()
      print >>sys.stderr, "STAGE 6b: Converting prefix table to BGTree Database"
      cmd = "cat " +basename+ ".pre | bgPrep.py xx >"+basename+"-pre.bgprep"
      print >>sys.stderr, cmd
      os.system(cmd)
      cmd = "bgTreeCmd create "+basename+"-pre.bgt `wc -l "+basename+"-pre.bgprep | cut -f1 -d' '` <" + basename+"-pre.bgprep"
      print >>sys.stderr, cmd
      os.system(cmd)
    if dopts.has_key("--stage7"):
      # Generate keyword dictionary, unigram, and bigram tables
      print >>sys.stderr, "STAGE 7a: Creating Lexicon from Titles"
      fprune = open(basename + ".pruned", "r")
      lexicon = dict()
      wordcount = 0
      singlekeys = []
      for row in fprune:
        row = string.split(row, "\t")
        crc = int(row[0], 16)
        parent = int(row[2], 16)
        title = row[3].decode('utf-8')
        level = int(row[1])
        if level == 0: # We only care about article titles
          title = title.upper()
          singlekeys.extend(StringToKeywords(title))
          words = string.split(title)
          for w in words:
            lexicon[w] = lexicon.get(w,0) + 1
            wordcount += 1
      fprune.close()
      sorted = lexicon.items()
      sorted.sort(lambda x,y: x[1] - y[1])
      flex = open(basename + ".lex","w")
      for w in sorted:
        flex.write(w[0].encode('utf-8') + "\t" + str(w[1]) + "\n")
      flex.close()
      print >>sys.stderr, "STAGE 7b: Writing out 1-gram table"
      f1gm = open(basename + ".1gm","w")
      for x in singlekeys:
        f1gm.write(("%08x" % x[0]) + "\t" + ("%08x" % x[1]) + "\n")
      f1gm.close()
      print >>sys.stderr, "STAGE 7c: Converting prefix table to BGTree Database"
      cmd = "cat " +basename+ ".1gm | bgPrep.py xx >"+basename+"-1gm.bgprep"
      print >>sys.stderr, cmd
      os.system(cmd)
      cmd = "bgTreeCmd create "+basename+"-1gm.bgt `wc -l "+basename+"-1gm.bgprep | cut -f1 -d' '` <" + basename+"-1gm.bgprep"
      print >>sys.stderr, cmd
      os.system(cmd)
    if dopts.has_key("--cleanup"):
      print >>sys.stderr, "CLEAN-UP STAGE: Removing intermediate files"
      ext = ['.art', '.lnk', '.pre', '-pre.bgprep', '.pruned', '.sec', '.sorted', '-sec.bgprep']
      for e in ext:
        name = basename + e
        if os.path.exists(name):
          sys.stderr.write("rm "+name.encode('utf-8')+"\n")
          os.remove(name)
  except Usage, err:
    print >>sys.stderr, err.msg
    print >>sys.stderr, "for help use --help"
    return -2

if __name__ == '__main__':
  sys.exit(main())


