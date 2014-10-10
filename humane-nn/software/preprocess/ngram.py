#!/usr/bin/env python
import sys,string
import math

def CalcNGrams(input):
  N=5
  grams=[]
  charCount=0
  [grams.append({}) for x in xrange(N+1)]
  while True:
    ln = input.readline()
    if len(ln) == 0:
      break
    r=[] 
    [r.append("\0") for x in xrange(N)]
    for c in ln:
      charCount += 1
      r.pop(0)
      r.append(c)
      s = string.join(r,"")
      grams[4][s] = grams[4].get(s,0) + 1
      grams[3][s[1:]] = grams[3].get(s[1:],0) + 1
      grams[2][s[2:]] = grams[2].get(s[2:],0) + 1
      grams[1][s[3:]] = grams[1].get(s[3:],0) + 1
      grams[0][s[4:]] = grams[0].get(s[4:],0) + 1
  return (charCount, grams)

def SortTupleSecond(x,y):
  if x[1] < y[1]:
    return 1
  elif x[1] > y[1]:
    return -1
  else:
    return 0

def PrintTop(charCount, gram, n):
  lst = [x for x in gram.items()]
  lst.sort(SortTupleSecond)
  i=1
  pcum=0.
  print "rank\tp       \t-log2(p)    \tgram\tsum(p[0:n])"
  for x in lst[:n]:
    p = float(x[1])/float(charCount)
    pcum += p
    print i,"\t", "%.5f" % p, "\t", "%.2f"%-math.log(p,2.) ,"\t",x[0],"\t","%.5f" % pcum 
    i+=1
  return lst[:n]

def PrintConditional(charCount, grams, n, rng):
  lst = [x for x in grams[1].items()]
  lst = [(x[0], float(x[1])/float(grams[0][x[0][0]]), grams[0][x[0][0]]) for x in lst if x[0][0] != '\0']
  lst.sort(SortTupleSecond)
  i=1
  print "rank\tp       \t-log2(p)    \tgram"
  pcum=0.
  for x in lst:
    if x[0][0] in rng:
      p = float(x[1])
      pcum += p
      print i,"\t", "%.5f" % p, "\t", "%.2f" % -math.log(p,2.) ,"\t",x[0], "\t%.5f" % pcum
      i+=1
    if i > n:
      return

def FindInSortedList(lst, value, default=-1):
  """Find value in sorted list and return index, 
     else return default"""
  try:
    return lst.index(value)
  except ValueError:
    return default

def CalcNib1Matrix(unigrams, bigrams, N=16):
  M = [[] for x in range(0,N)]
  lst = [x for x in unigrams.items()]
  lst.sort(SortTupleSecond)
  M[0] = [x[0] for x in lst[:N-1]]
  #M[0].sort()
  for i in range(0,N-1):
    lst = [x for x in bigrams.items() if x[0][0] == M[0][i]]
    lst.sort(SortTupleSecond)
    M[i+1] = [x[0][1] for x in lst[:N-1]]
    #M[i+1].sort()
  return M

def EncodeNib1(M, prev, cur):
  """Nibble encodes using matrix M, previous character, 
     and current character"""
  # Is prev char a known context?
  idx = FindInSortedList(M[0], prev, -1) + 1
  # is cur char in context
  idx2 = FindInSortedList(M[idx], cur, -1) 
  if idx2 >= 0:
    return [idx2]
  else:
    return [15, (ord(cur) >> 4) & 0xf, ord(cur) &0xf]

def EncodeNib1String(M, s, prev='\0'):
  E=[]
  for c in s:
    E.extend(EncodeNib1(M, prev, c))
    prev = c
  return E

def DecodeNib1(M, prev, c1, c2, c3):
  if c1 == 15:
    return (3, chr((c2 << 4) | c3))
  else:
    idx = FindInSortedList(M[0], prev, -1) + 1
    return (1, M[idx][c1])
 
def DecodeNib1Sequence(M, s, prev='\0'):
  str = ""
  slen = len(s)
  i = 0
  while i < slen:
    s2 = s[i:i+3] + [0, 0] # pad for end case
    (cnt, m) = DecodeNib1(M, prev, s2[0], s2[1], s2[2])
    str += m
    prev = m
    i += cnt
  return str

def AnalyzeNib1Sequence(M, s, prev='\0'):
  str = ""
  slen = len(s)
  i = 0
  cntNib=0
  cnt15=0
  while i < slen:
    if s[i] == 15:
      cnt15 += 1
      i += 3
    else:
      cntNib += 1
      i += 1
  return (cntNib, cnt15)

def CalcNib2Matrix(unigrams, bigrams):
  M = [[] for x in range(0,16)]
  lst = [x for x in unigrams.items()]
  lst.sort(SortTupleSecond)
  M[0] = [x[0] for x in lst[:14]]
  #M[0].sort()
  M[1] = [x[0] for x in lst[14:28]]
  #M[1].sort()
  for i in range(0,14):
    lst = [x for x in bigrams.items() if x[0][0] == M[0][i]]
    lst.sort(SortTupleSecond)
    M[i+2] = [x[0][1] for x in lst[:14]]
    #M[i+2].sort()
  return M

def EncodeNib2(M, prev, cur):
  """Nibble encodes using matrix M, previous character, 
     and current character"""
  # Is prev char a known context?
  idx = FindInSortedList(M[0], prev, -2) + 2
  # is cur char in context
  idx2 = FindInSortedList(M[idx], cur, -1) 
  if idx2 >= 0:
    return [idx2]
  else:
    idx3 = FindInSortedList(M[1], cur, -1)
    if idx3 >= 0:
      return [14, idx3]
    else:
      return [15, (ord(cur) >> 4) & 0xf, ord(cur) &0xf]

def EncodeNib2String(M, s, prev='\0'):
  E=[]
  for c in s:
    E.extend(EncodeNib2(M, prev, c))
    prev = c
  return E

def DecodeNib2(M, prev, c1, c2, c3):
  if c1 == 15:
    return (3, chr((c2 << 4) | c3))
  elif c1 == 14:
    return (2, M[1][c2])
  else:
    idx = FindInSortedList(M[0], prev, -2) + 2
    return (1, M[idx][c1])
 
def DecodeNib2Sequence(M, s, prev='\0'):
  str = ""
  slen = len(s)
  i = 0
  while i < slen:
    s2 = s[i:i+3] + [0, 0] # pad for end case
    (cnt, m) = DecodeNib2(M, prev, s2[0], s2[1], s2[2])
    str += m
    prev = m
    i += cnt
  return str

def AnalyzeNib2Sequence(M, s, prev='\0'):
  str = ""
  slen = len(s)
  i = 0
  cntNib=0
  cnt14=0
  cnt15=0
  while i < slen:
    if s[i] == 15:
      cnt15 += 1
      i += 3
    elif s[i] == 14:
      cnt14 += 1
      i += 2
    else:
      cntNib += 1
      i += 1
  return (cntNib, cnt14, cnt15)

def AnalyzeForHuffmanSize(seq, sizes):
  sz=0
  for c in seq:
    sz += sizes[c]
  return sz

def AnalyzeStringForRuns(s):
  slen = len(s)
  run = [0 for x in range(0,6)]
  prev = '\0'
  prevrun = 0
  i=0
  while i < slen:
    if s[i] == prev:
      for j in range(0, min(prevrun+1, 6)):
        run[j] += 1
      prevrun += 1
    else:
      prev = s[i]
      prevrun = 0
    i += 1
  return run

def CalcFirstOrderEntropy(unigrams):
  """Calc per-character entropy in bits"""
  H=0.
  N=float(sum(unigrams.values()))
  for x in unigrams.items(): 
    p = float(x[1])/N
    H -= p*math.log(p, 2.0)
  return H

def CalcStringFirstOrderEntropy(s, unigrams, unk=.00001):
  """Calculate information measure (surpisal) for string """
  H=0.
  N=float(sum(unigrams.values()))
  unk = N*unk
  for c in s:
    p = float(unigrams.get(c, unk))/N
    H += -math.log(p, 2.0)
  return H

def CalcStringSecondOrderEntropy(s, unigrams, bigrams, unk=1./2**12):
  """Calculate information measure (surpisal) for string. 
  Returns tuple of exact information measure in bits, 
  and more real-world information measure rounded up to nearest bit for each symbol"""
  H=0.
  Hbits=0
  prev='\0'
  for c in s:
    try:
      p = float(bigrams[prev+c])/float(unigrams[prev])
    except KeyError:
      p = unk
    if p == 0.0:
      p = unk
    H += -math.log(p, 2.0)
    Hbits += math.ceil(-math.log(p, 2.0))
    prev = c
  return H,Hbits

def CalcStringThirdOrderEntropy(s, unigrams, bigrams, trigrams, unk=.00001):
  """Calculate information measure (surpisal) for string. 
  Returns tuple of exact information measure in bits, 
  and more real-world information measure rounded up to nearest bit for each symbol"""
  H=0.
  Hbits=0
  prev='\0\0'
  for c in s:
    p = float(trigrams.get(prev+c, unk))/float(bigrams.get(prev, unk))
    if p == 0.0:
      p = unk
    H += -math.log(p, 2.0)
    Hbits += math.ceil(-math.log(p, 2.0))
    prev = prev[1] + c
  return H,Hbits

def StripNGramsByMatrix(M, unigrams, bigrams):
  """Returns a reduced version of grams which only has information
     relevant to the Nib1 matrix M.  Used for experimentation."""
  charset = []
  for m in M:
    charset.extend(m)
  charset = set(charset)
  U = [x for x in unigrams.items() if x[0] in charset]
  #B = [x for x in bigrams.items() if (x[0][0] in charset) and (x[0][1] in charset)]
  B = []
  for idx in range(0,len(M1[0])):
    for c in M[idx+1]:
      k=M[0][idx] + c
      B.append((k, bigrams[k]))
  U = dict(U)
  B = dict(B)
  return [U, B]

