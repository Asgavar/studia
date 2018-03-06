P = []

for x in open('program.pygo'):
  L = x.split()
  if len(L) == 0:
    continue
  if L[1] == '=':
    P.append( ('=', L[0], ' '.join(L[2:])) )
  elif L[0] == 'print':
    P.append( ('print', ' '.join(L[1:])) )
  elif L[0] == 'goto':
    P.append( ('goto', L[1]) )
  elif L[0] == 'if':
    P.append( ('if', ' '.join(L[1:-2]) , L[-1]))

for instr in P:
  print (instr)

PC = 0
M = {} # memory

while PC < len(P):
  instr = P[PC]
  typ = instr[0]
  if typ == '=':
    M[instr[1]] = eval(instr[2], M)
    PC += 1
  elif typ == 'print':
    print (eval(instr[1], M))
    PC += 1
  elif typ == 'goto':
    PC = int(instr[1]) -1
  elif typ == 'if':
    warunek = eval(instr[1], M)
    if warunek:
      PC = int(instr[2]) - 1
    else:
      PC += 1
