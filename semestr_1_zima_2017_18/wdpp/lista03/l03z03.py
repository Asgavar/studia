#!/usr/bin/env python3.6
# -*- coding: utf-8 -*-

def usun_nawiasy(s):
    l_par = s.find('(')
    if l_par == -1:
        return s
    r_par = s.find(')')
    left_side = s[:l_par]
    right_side = s[r_par+1:]
    return usun_nawiasy(left_side + right_side)

if __name__ == '__main__':
    print(usun_nawiasy('Ala nie (a moze jednak?)ma kota (rosyjskiego)'))
    print(usun_nawiasy('Jeden (One) Dwa () Trzy ()Cztery'))
