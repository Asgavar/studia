from turtle import *
import random
import time
import math

M = 300
N = 10

def perm(L):
  "perm generuje listę wszystkich permutacji listy L"
  if len(L) == 0:
    return [ [] ]
  ps = perm(L[1:])
  return [ p[:i] + [L[0]] + p[i:] for p in ps for i in range(len(p)+1)]

speed('fastest')

points = []
for i in range(N):
  points.append( (random.randint(-M,M), random.randint(-M,M)) )

def draw_points(ps):
  pu()
  fillcolor('yellow')
  for p in ps:
    begin_fill()
    goto(*p)
    circle(10)
    end_fill()
  pd()

def draw_line(ps, c):
  pu()
  goto(*ps[0])
  pd()
  pencolor(c)
  for p in ps[1:]:
    goto(*p)  # == goto(p[0], p[1])

def dist(p1,p2):
  return ((p1[0] - p2[0]) ** 2 + (p1[1] - p2[1]) ** 2) ** 0.5

def length(path):
  d = 0.0
  for i in range(1, len(path)):
    d += dist(path[i-1], path[i])
  return d


if __name__ == '__main__':
  draw_points(points)

  best_perm = min(perm(points), key=length)
  print(best_perm)
  draw_line(best_perm, 'black')

  input()
