import itertools
import random
import sys


def is_everyone_alive(state_str):
    """
    Informuje, czy ruch jest dozwolony.
    """
    river_sides = state_str_to_sets(state_str)
    for side in river_sides:
        if side in ({'W', 'G'}, {'G', 'C'}):
            return False
    return True


def get_successors(state):
    """
    Zwraca liste poprawnych nastepnych ruchow.
    """
    if everybody_transported(state):
        return []
    left_side, right_side = state_str_to_sets(state)
    farmer_side = left_side if 'F' in left_side else right_side
    other_side = right_side if 'F' in left_side else left_side
    successors = []
    farmer_side.discard('F')
    farmer_side.add('')  # samotna podroz farmera
    everybody_waiting = ''.join(other_side)
    for being in farmer_side:
        src_side = ''.join(farmer_side).replace(being, '')
        dest_side = everybody_waiting + being + 'F'
        next_state_str = src_side + '|' + dest_side if other_side == right_side else dest_side + '|' + src_side
        if is_everyone_alive(next_state_str):
            successors.append(next_state_str)
    return successors


def state_str_to_sets(state):
    state = state.split('|')
    left, right = state[0], state[1]
    left, right = set(left), set(right)
    return left, right


def everybody_transported(state_str):
    """
    Informuje, czy gra dobiegla konca.
    """
    left_side = state_str.split('|')[0]
    return len(left_side) == 0


def dfs(graph, node, log):
    log.append(node)
    if everybody_transported(node):
        return log
    to_visit = [x for x in graph[node] if x not in log]
    for next_move in to_visit:
        log_or_not_a_log = dfs(graph, next_move, log[:])
        if log_or_not_a_log:
            return log_or_not_a_log


def random_search(graph, node, log):
    log.append(node)
    if everybody_transported(node):
        return log
    next_node = random.choice(graph[node])
    return random_search(graph, next_node, log)



if __name__ == '__main__':
    state_ids = 'FGWC|'
    nodes = itertools.permutations(state_ids)
    graph = {}
    for node in nodes:
        node = ''.join(node)
        graph[node] = get_successors(node)
    dfs_path = dfs(graph, 'FGWC|', [])
    print(dfs_path)
    random_path = random_search(graph, 'FGWC|', [])
    print(random_path)
