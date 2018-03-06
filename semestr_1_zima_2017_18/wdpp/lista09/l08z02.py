#!/usr/bin/env python3.6

def get_occurences(of_word):
    ret = {}
    for character in of_word:
        character = character.lower()  # przyda sie przy zadaniu 3.
        current_count = ret[character] if character in ret else 0
        ret[character] = current_count + 1
    return ret

def is_composable(word, from_word):
    word_letters = get_occurences(word)
    from_word_letters = get_occurences(from_word)
    for letter in word:
        try:
            if from_word_letters[letter] < word_letters[letter]:
                return False
        except:  # w 'wiekszym' slowie danej litery nie bylo wcale
            return False
    return True

if __name__ == '__main__':
    print(get_occurences('abba'))
    print(get_occurences('konstantynopolitańczykiewiczówna'))
    print(is_composable('aktyw', 'lokomotywa'))
    print(is_composable('kot', 'lokomotywa'))
    print(is_composable('motyl', 'lokomotywa'))
    print(is_composable('żak', 'lokomotywa'))
    print(is_composable('kotka', 'lokomotywa'))
