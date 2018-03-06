#!/usr/bin/env python3

def potega(a,n):
   wynik = 1 
   for i in range(n):
      wynik = wynik * a
   return wynik
   
def kwadrat(n):
   for i in range(n):
      for j in range(n):
         print ("*", end="")
      print()
      
def kwadrat2(n):
   for i in range(n):
      print (n * "#")      
  
for i in range(10):
   print ("Przebieg:",i)
   print (20 * "-")
   if i < 5:
      kwadrat(3+2*i)
   else:
      kwadrat2(i-2)
   print()    # pusty wiersz   
