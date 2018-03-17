#!/usr/bin/env python

from ortools.graph import pywrapgraph

from utils import group


def execute_set(filename):
    with open(filename) as infile:
        lines = infile.readlines()
        lines = [line[:-1] for line in lines]

    case_count = lines[0]
    case_tuples = group(lines[1:], 3)

    for case in case_tuples:
        case_result = execute_case(case)
        print(case_result)


def execute_case(case_tuple):
    spaceships_count = (case_tuple[0].split()[0])
    one_ship_limit = int((case_tuple[0].split()[1]))
    colors = case_tuple[1].split()

    a_points = int(colors[0])
    b_points = int(colors[1])
    c_points = int(colors[2])

    space_flotilla = case_tuple[2]
    points_func = points_gain(a_points, b_points, c_points)

    a_max_streak = 0

    results = [
        strategy_shoot_everything(space_flotilla, points_func, one_ship_limit),
        strategy_maximum_flow(space_flotilla, points_func, one_ship_limit),
    ]

    # return max(results)


def points_gain(a, b, c):
    def inner(color_str):
        values = {
            'A': a,
            'B': b,
            'C': c
        }

        return values[color_str]

    return inner


def actual_points(flotilla, points_list, limit):
    multipliers = [1 for x in range(len(points_list))]

    for x in range(1, len(flotilla)):
        if flotilla[x] == flotilla[x-1]:
            prev_mult = multipliers[x-1]
            multipliers[x] = prev_mult + 1

    for x in range(len(points_list)):
        val_with_mult = points_list[x] * multipliers[x]
        points_list[x] = val_with_mult if val_with_mult < limit else limit

    return points_list


def strategy_shoot_everything(flotilla, points_func, limit):
    values = map(points_func, flotilla)
    values = actual_points(flotilla, list(values), limit)
    return sum(values)


def strategy_maximum_flow(flotilla, points_func, limit):
    start_nodes = []
    end_nodes = []
    capacities = []
    node_count = len(flotilla)
    FINAL_NODE = 42

    # TODO: ostatni punkt ma capacity = 0
    for x in range(node_count):
        print(node_count, flotilla)
        start_nodes.extend([x for y in range(node_count - x)])
        end_nodes.extend([x+y+1 for y in range(node_count - (x+1))])
        # kazdy wezel jest polaczony z koncowym pseudowezlem
        end_nodes.append(FINAL_NODE)

    combo_streak = 1

    # zawsze zaczynamy od pierwszego, bo nic na tym nie tracimy. uff.
    for edge in range(len(start_nodes)):
        if end_nodes[edge] == FINAL_NODE:
            weight = 1
        else:
            weight = points_func(flotilla[end_nodes[edge]])
            start_color = flotilla[start_nodes[edge]]
            end_color = flotilla[end_nodes[edge]]
            if start_color == end_color:
                # ten sam kolor, wiec ciagniemy combo
                combo_streak += 1
                print(combo_streak)
                mult_weight = weight * combo_streak
                print(f'przed: {weight}')
                print(f'po: {mult_weight}')
                weight = mult_weight if mult_weight < limit else limit
            else:
                combo_streak = 1
        capacities.append(weight)

    print(start_nodes)
    print(end_nodes)
    print(capacities)

    max_flow = pywrapgraph.SimpleMaxFlow()

    for x in range(len(start_nodes)):
        max_flow.AddArcWithCapacity(
            start_nodes[x],
            end_nodes[x],
            capacities[x]
        )

    while max_flow.Solve(0, FINAL_NODE) != max_flow.OPTIMAL:
        print(max_flow.OptimalFlow())

    print(max_flow.OptimalFlow())
    print(f'arcs = {max_flow.NumArcs()}')

    # print(max_flow.Solve(0, FINAL_NODE))
    # print(max_flow.Solve(0, FINAL_NODE))
    # print(max_flow.NumArcs())
    # print(max_flow.OptimalFlow())
    # print(max_flow.OPTIMAL)


if __name__ == '__main__':
    execute_set('spaceships_example.in')
