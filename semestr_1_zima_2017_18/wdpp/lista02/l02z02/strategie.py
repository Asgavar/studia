def piec_rosnacy(rzuty):
    for i in range(len(rzuty) - 4):
        dobrych_wyrazow = 1
        for j in range(5):
            if dobrych_wyrazow == 5:
                return True
            if rzuty[i+j+1] > rzuty[i+j]:
                dobrych_wyrazow += 1
            else:
                break
    return False

def szesc_niemalejacy(rzuty) -> bool:
    for i in range(len(rzuty) - 5):
        dobrych_wyrazow = 1
        for j in range(6):
            if dobrych_wyrazow == 6:
                return True
            if rzuty[i+j+1] >= rzuty[i+j]:
                dobrych_wyrazow += 1
            else:
                break
    return False
