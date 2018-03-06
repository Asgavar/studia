#!/usr/bin/env python3.6

if __name__ == '__main__':
    with open('slowa.txt', 'r') as f:
        words_list = f.readlines()
        words_list = list(map(lambda x: x[:-1], words_list))  # uciecie koncowego \n
        words_set = set(words_list)
        for word in words_list:
            palindrome = word[::-1]
            if palindrome in words_set:
                print(f'{word} - > {palindrome}')
                words_set.discard(word)
                words_set.discard(palindrome)
