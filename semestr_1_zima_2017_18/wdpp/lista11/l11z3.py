import komiwojazer

current_place = (0, 0)


def how_far_from_here(place):
    return komiwojazer.dist(current_place, place)


if __name__ == '__main__':
    with open('/home/asgavar/Dropbox/studia/wdpp/lista11/punkty.txt') as infile:
        places = infile.readlines()
    places = [pl[:-1].split() for pl in places][:-1]
    places = [(int(pl[0]), int(pl[1])) for pl in places]
    paths = []
    for place in places:
        current_place = place
        remaining = places[:]
        remaining.remove(place)
        visited = [place]
        while remaining:
            next_place = min(remaining, key=how_far_from_here)
            visited.append(next_place)
            remaining.remove(next_place)
            current_place = next_place
        paths.append(visited)
    best_path = min(paths, key=komiwojazer.length)
    print(f'Ścieżka o długości {komiwojazer.length(best_path)}')
    print(best_path)
    komiwojazer.draw_points(places)
    komiwojazer.draw_line(best_path, 'black')
    input()
