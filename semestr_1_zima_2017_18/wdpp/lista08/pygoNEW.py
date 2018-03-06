P = []

for x in open('program.pygo'):
  L = x.split()
  if len(L) == 0:
    continue
  etykieta = ' '
  if L[0] not in ('print', 'goto', 'if') and L[1] != '=':
      # czyli instrukcja jest poprzedzona etykietą
      etykieta = L[0][:-1]
      L = L[1:]
  if L[1] == '=':
    P.append( ('=', L[0], ' '.join(L[2:]), etykieta) )
  elif L[0] == 'print':
    P.append( ('print', ' '.join(L[1:]), etykieta) )
  elif L[0] == 'goto':
    P.append( ('goto', L[1], etykieta) )
  elif L[0] == 'if':
    P.append( ('if', ' '.join(L[1:-2]) , L[-1], etykieta))

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
    if instr[1].isdigit():
      PC = int(instr[1]) -1
    else:
      etykieta = instr[1]
      for x in range(len(P)):
          if P[x][2] == etykieta:
              PC = x
  elif typ == 'if':
    warunek = eval(instr[1], M)
    if warunek:
      PC = int(instr[2]) - 1
    else:
      PC += 1
