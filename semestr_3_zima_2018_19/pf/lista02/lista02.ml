let rec custom_append xs ys =
  match xs with
    [] -> ys
  | x :: tail ->
      x :: custom_append tail ys


let rec custom_map f xs =
  match xs with
    [] -> []
  | x :: tail ->
      (f x) :: (custom_map f tail)


let custom_reverse xs =
  let rec _custom_reverse acc left_to_rev =
    match left_to_rev with
      [] -> acc
    | x :: tail -> _custom_reverse (x :: acc) tail
  in _custom_reverse [] xs


let rec sublists xs =
  match xs with
    [] -> [[]]
  | x :: tail ->
      (custom_map (fun subl -> x :: subl) (sublists tail)) @ sublists tail


let cycle xs n =
  let rec _cycle list_so_far xs n =
    match xs with
      [] -> []
    | x :: [] -> x :: (custom_reverse list_so_far)
    | x :: tail -> _cycle (x :: list_so_far) tail n
  in _cycle [] xs n


let rec merge cmp left right =
    match (left, right) with
      ([], r) -> r
    | (l, []) -> l
    | (l :: left_tail, r :: right_tail) ->
        if (cmp l r)
          then l :: (merge cmp left_tail right)
          else r :: (merge cmp left right_tail)

let merge_tailrec cmp left right =
  let rec _merge_tailrec acc left right =
    match (left, right) with
      ([], []) -> acc
    | ([], r :: right_tail) ->
        _merge_tailrec (r :: acc) [] right_tail
    | (l :: left_tail, []) ->
        _merge_tailrec (l :: acc) left_tail []
    | (l :: left_tail, r :: right_tail) ->
        if (cmp l r)
        then _merge_tailrec (l :: acc) left_tail right
        else _merge_tailrec (r :: acc) left right_tail
  in custom_reverse (_merge_tailrec [] left right)


(* wynikiem jest odwrocona polowka,
ale w tym wypadku nie ma to znaczenia *)
let halve xs =
  let half_length = List.length xs / 2 in
  let rec _halve acc xs left_to_cut =
    match left_to_cut with
      0 -> (acc, xs)
    | _ -> _halve (List.hd xs :: acc) (List.tl xs) (left_to_cut - 1)
  in _halve [] xs half_length


let rec merge_sort xs =
  match xs with
    [] -> []
  |  x :: [] -> [x]
  | _ :: _ ->
      let halves = halve xs in
      let left_half = fst halves in
      let right_half = snd halves in
        merge_tailrec (fun a b -> a < b) (merge_sort left_half) (merge_sort right_half)


let rec all_suffixes xs =
  match xs with
    [] -> [] :: []
  | x :: tail -> xs :: all_suffixes tail


let all_prefixes xs =
  custom_map (fun prefix -> custom_reverse prefix) (all_suffixes (custom_reverse xs))
