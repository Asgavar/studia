type 'a btree = Leaf | Node of 'a btree * 'a * 'a btree

let prod tree =
  let rec aux tree cont =
    match tree with
      Leaf -> cont 1
    | Node (ltree, nodeval, rtree) ->
        aux ltree (fun so_far -> nodeval * so_far * (aux rtree cont))
  in aux tree (fun x -> x)

let prod_plus tree =
  let rec aux tree cont =
    match tree with
      Leaf -> cont 1
    | Node (ltree, 0, rtree) -> 0
    | Node (ltree, nodeval, rtree) ->
        aux ltree (fun so_far -> nodeval * so_far * (aux rtree cont))
  in aux tree (fun x -> x)

let test_tree =
  Node (Node (Leaf, 2, Leaf), 4, Node (Leaf, 3, Leaf))
let test_tree_plus =
  Node (Node (Leaf, 2, Leaf), 0, Node (Leaf, 3, Leaf))

let test_result = prod test_tree
let test_result_plus = prod_plus test_tree_plus
