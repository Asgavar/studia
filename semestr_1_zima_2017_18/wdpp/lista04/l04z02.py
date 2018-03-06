import functools
import random

"""
W tym programie znajduje sie kilka prostych funkcji demonstrujacych operacje na listach.

[!] oznacza, ze w danym miejscu konieczne jest dopisanie (ew. zmiana) istniejacego kodu.

Prawidlowy wynik dzialania programu znajduje sie na stronie KNO
"""

def parzysta(n):
   return n % 2 == 0 
   
#
# Funkcje, ktore licza cos dla listy
#

def suma1(L):
   "Sumowanie elementow listy"
   wynik = 0
   for element in L:
      wynik += element
   return wynik
   
def suma2(L): #[!]
   "L[0] zmieniony na 0"
   wynik = 0
   for indeks in range(len(L)):
      wynik += L[indeks]
   return wynik
   
def sumaParzystych(L): #[!]
   "Suma parzystych elementow listy. W tej funkcji rowniez jest blad. Powinienes skorzystac z funkcji parzysta"
   wynik = 0
   for element in L:
       if parzysta(element):
           wynik += element
   return wynik
   
#
# Funkcje (procedury), ktore robia cos dla listy (ale nie modyfikuja listy)
#

def zeSpacjami(n,k):
   "Jak liczba n zajmuje mniej niz k znakow, to dodaje z tylu odpowiednia liczbe spacji (lub znakow '_' do wyboru)"
   s = str(n)
   if len(s) < k:
     s += " " * (k-len(s))  #[!]
   return s  

def histogram(L):
   "Wypisuje histogram dla listy L. Liczba z gwiazdkami nie powinna sie sklejac, gwiazdki powinny zaczynac sie w czwartej kolumnie"
   for liczba in L:
      print (zeSpacjami(str(liczba), 3) + "*" * liczba) #[!]
      
#
# Funkcje (procedury), ktore modyfikuja liste, bedaca argumentem
#

def powiekszLiczby(L): #[!]
   "funkcja powieksza wszystkie elementy listy L. Nie zwraca niczego istotnego (wywolujemy ja jako procedure)"
   for i in range(len(L)):
      L[i] = L[i] + 1
   
def normalizuj(L): #[!]
   "funkcja odejmuje od kazdego elementu listy L srednia wartosc wszystkich elementow tej listy"
   srednia = functools.reduce(lambda x, y: x + y, L) / len(L)
   return list(map(lambda x: x - srednia, L))

def znormalizowana(L): #[!]
   "Funkcja zwraca znormalizowana liste. Powinna wykorzystac funkcje znormalizuj, nie moze zmieniac swojego argumentu. W funkcji jest blad."
   return normalizuj(L)

#
# Funkcje, ktore tworza nowe listy
#   

def powiekszoneParzysteZZerami(L):
   """ Funkcja zwraca liste, w ktorej wszystkie parzyste liczby zostaja powiekszone o 1, a nieparzyste pominiete. 
       Dodatkowo w wyniku po kazdej liczbie dodany jest dodatkowy element, rowny 0
   """
   wynik = []
   for n in L:
      if parzysta(n):
         wynik.append(n+1)  # Jesli wolisz: wynik += [n+1]
         wynik.append(0)    # Znowu, mozna: wynik += [0]
   return wynik      
   
def madrzejsza(L): #[!]
   """ Funkcja zwraca "madrzejsza" wersje listy L. Pomija w niej krotkie slowa (dlugosc <= 3), jako nie dosc madre,   
       dodatkowo po kazdym slowie dodaje jakies madre slowo z listy madrych slow.
       Implementacja ponizej mocno rozmija sie ze specyfikacja.
   """
       
   madreSlowa = ["istotnie", "zasadniczo", "rudymentalnie", "rustykalnie", "radykalnie", "hej"]
   
   wynik = []
   for i in range(len(L)):
       if len(L[i]) > 3:
           wynik.append(L[i])
           wynik.append(random.choice(madreSlowa))
   return wynik   
   

###################################################################################
# Demonstracja dzialania
###################################################################################

L = [1,2,3,4,5]

print ("Dla listy " + str(L) + " suma elementow rowna sie")
print (suma1(L))
print (suma2(L))
print ("Jak zsumujemy tylko parzyste, to otrzymamy")
print (sumaParzystych(L))
print ("")         

H = [1,2,3,4,5,6,7,4,8,4,8,2,2,1,10]
print ("Histogram dla listy " + str(H))
histogram(H)
print ("")         

print ("Zaczynamy od " + str(L) + " i zwiekszamy 4 razy")

powiekszLiczby(L); print (L) # raczej nie uzywamy srednikow, ale tu nie moglem sie powstrzymac
powiekszLiczby(L); print (L)
powiekszLiczby(L); print (L)
powiekszLiczby(L); print (L)

L = [1,2,3,4,5]
L2 = L[:]

print ("")         
print ("Zaczynamy od " + str(L2) + " i normalizujemy 3 razy")

normalizuj(L2); print (L2)
normalizuj(L2); print (L2)
normalizuj(L2); print (L2)

print ("Dlaczego ciagle to samo?")

print ("O, i znowu:")

print (znormalizowana(L))
print ("Oczywiscie mamy " + str(L) + " == [1,2,3,4,5]") 

print ("")         
print ("Powiekszamy parzyste, pomijamy nieparzyste i wstawiamy 0 po")         
print (powiekszoneParzysteZZerami(L))


print ("Cos madrego na zakonczenie:")         
Dane = "nauka programowania w pythonie wcale nie jest taka trudna".split()
print (" ".join(madrzejsza(Dane)))


