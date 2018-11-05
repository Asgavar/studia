type 'a btree = Leaf | Node of 'a btree * 'a * 'a btree
type 'a node_count_btree = NodeCountLeaf | NodeCountNode of 'a node_count_btree * int * 'a * 'a node_count_btree * int

let node_counts_from_node_count_btree ncbtree =
  match ncbtree with
    NodeCountLeaf -> (0, 0)
  | NodeCountNode (ltree, ltree_nc, nodeval, rtree, rtree_nc) -> (ltree_nc, rtree_nc)

let nodes_under_this_node ncbtree =
  let ncs = node_counts_from_node_count_btree ncbtree in
  (fst ncs) + (snd ncs)

let rec node_count_btree_from_btree tree =
  match tree with
    Leaf -> NodeCountLeaf
  | Node (ltree, nodeval, rtree) ->
    let transformed_ltree = (node_count_btree_from_btree ltree)
    and transformed_rtree = (node_count_btree_from_btree rtree) in
    let ltree_ncs = (node_counts_from_node_count_btree transformed_ltree)
    and rtree_ncs = (node_counts_from_node_count_btree transformed_rtree) in
    let add_to_left = match transformed_ltree with NodeCountLeaf -> 0 | _ -> 1
    and add_to_right = match transformed_ltree with NodeCountLeaf -> 0 | _ -> 1 in
    NodeCountNode (transformed_ltree, (add_to_left + (fst ltree_ncs) + (snd ltree_ncs)), nodeval, transformed_rtree, (add_to_right + (fst rtree_ncs) + (snd rtree_ncs)))

let rec is_node_count_btree_balanced ncbtree =
  match ncbtree with
    NodeCountLeaf -> true
  | NodeCountNode (ltree, ltree_nc, nodeval, rtree, rtree_nc) ->
    let under_left = (nodes_under_this_node ltree)
    and under_right = (nodes_under_this_node rtree) in
    let diff = under_left - under_right in
    diff > -2 && diff < 2 && (is_node_count_btree_balanced ltree) && (is_node_count_btree_balanced rtree)

let test_btree = Node(
                       Node(
                            Node(
                                 Leaf,
                                 4,
                                 Leaf
                                ),
                            2,
                            Leaf
                           ),
                       1,
                       Node(
                            Node(
                                 Leaf,
                                 5,
                                 Node(
                                      Leaf,
                                      6,
                                      Leaf
                                     )
                                ),
                            3,
                            Leaf
                           )
                      )

let test = node_count_btree_from_btree test_btree
let test2 = node_counts_from_node_count_btree (node_count_btree_from_btree test_btree)
let test3 = nodes_under_this_node (node_count_btree_from_btree test_btree)
let test4 = is_node_count_btree_balanced (node_count_btree_from_btree test_btree)
