Cyfry = {}

Cyfry[0] = """
 ###  
#   #
#   #
#   #
 ###
"""

Cyfry[1] = """
  #
 ##
  #
  #
 ###
"""

Cyfry[4] = """
 # 
#
#####
  #
  #
"""


Cyfry[2] = """
 ###  
#   #
  ##
 #
#####
"""

Cyfry[5] = """
##### 
#   
####
    #
####
"""

Cyfry[8] = """
 ###  
#   #
 ### 
#   #
 ###
"""

Cyfry[6] = """
 ###  
#   
#### 
#   #
 ###
"""

Cyfry[9] = """
 ###  
#   #
 ####
    #
 ###
"""

Cyfry[3] = """
####  
    #
 ### 
    #
####
"""

Cyfry[7] = """
#####
   #
 ###
 #
# 
"""

Pytajnik = """
 ###  
#   #
  ##
   
  #
"""

def popraw(s):
   L = s.split('\n')
   for i in range(len(L)):
      if len(L[i]) < 5:
         L[i] += (5-len(L[i])) * " "
      else:
         L[i] = L[i][:5]   
   return L[1:-1]      

def dajCyfre(n):
   if n not in range(10):
      return popraw(Pytajnik)
   return popraw(Cyfry[n])
   
