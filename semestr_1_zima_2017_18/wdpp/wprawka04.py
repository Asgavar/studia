if __name__ == '__main__':
    with open('slowa.txt') as f:
        words_list = f.readlines()
        words_set = set(words_list)
        przesuniete = set()
    for word in words_list:
        tempword = word[:-1]  # bez \n na koncu
        przesuniecia = [tempword]
        for x in range(len(word) - 2):
            tempword = tempword[1:] + tempword[0]
            if tempword in przesuniete:
                continue
            if tempword + '\n' in words_set:
                #przesuniete.add(word)
                #przesuniete.add(tempword)
                przesuniecia.append(tempword)
        if len(przesuniecia) > 2:
            print(' '.join(przesuniecia))
            for prz in przesuniecia:
                przesuniete.add(prz)
