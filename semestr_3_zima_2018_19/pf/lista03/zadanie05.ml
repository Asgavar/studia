let leftmost_successor_in_prefix compare_func pivot xs =
  List.hd (List.sort compare_func (List.filter (fun x -> x > pivot) xs))


let replace_first_with before after xs =
  let rec _aux processed unprocessed =
    if (List.hd unprocessed) = before
    then (List.rev processed) @ (after :: (List.tl unprocessed))
    else _aux ((List.hd unprocessed) :: processed) (List.tl unprocessed)
  in _aux [] xs


let next_perm p compare_func =
  let rec _aux last_val p_seen p_unseen =
    if p_unseen = [] then p_seen else
    let compare_result = (compare_func last_val (List.hd p_unseen)) in
        if compare_result <= 0
        then _aux (List.hd p_unseen) ((List.hd p_unseen) :: p_seen) (List.tl p_unseen)
        (* head jest pivotem *)
        else let succ = leftmost_successor_in_prefix compare_func (List.hd p_unseen) p_seen
          in (List.rev (replace_first_with succ (List.hd p_unseen) p_seen)) @ (succ :: (List.tl p_unseen))
  in _aux (List.hd p) [] p


let all_perms p compare_func =
  let rec _aux first_p current acc =
    let next_p = next_perm current compare_func in
    if next_p = first_p
    then first_p :: acc
    else _aux first_p next_p (next_p :: acc)
  in _aux p p []


let t1 = leftmost_successor_in_prefix (fun a b -> a - b) 3 [7; 8; 9; 4; 3; 3; 4]
let t2 = replace_first_with 3 42 [1; 2; 3; 3; 4; 7]

let t3 = next_perm [4; 3; 2; 1] (fun a b -> a - b)
let t4 = next_perm [1; 2; 4; 3] (fun a b -> a - b)
let t5 = next_perm [5; 6; 7; 8] (fun a b -> a - b)

let t6 = all_perms [3; 2; 1] (fun a b -> a - b)
