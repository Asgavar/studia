let left_startswith_reversed_right left right =
  let rec aux left right =
    match right with
      [] -> failwith "niemozliwe"
    | [last] -> ((List.hd left) = last, (List.tl left))
    | _ ->
        let further_tuple = aux left (List.tl right) in
          ((fst further_tuple) && (List.hd (snd further_tuple)) = (List.hd right)), (List.tl (snd further_tuple)) in
  fst (aux left right)

let is_palindrome xs =
  let rec aux left right =
    match (left, right) with
      (left, []) -> left_startswith_reversed_right xs left
    | (left, [last_elem]) -> left_startswith_reversed_right xs left
    | (l :: left_tail, r :: r_tail) -> aux left_tail (List.tl r_tail)
    | (_, _) -> failwith "something is wrong" in
  aux xs xs

let test_is_palindrome = is_palindrome ['r'; 'o'; 't'; 'o'; 'r']
let test_is_palindrome = is_palindrome ['a'; 'b'; 'b'; 'a']
let test_is_palindrome = is_palindrome ['a'; 'b'; 'c'; 'd'; 'c'; 'b'; 'a']
let test_is_palindrome = is_palindrome [5; 5; 5; 5]
let test_is_palindrome = is_palindrome [1; 2; 3]
let test_left_startswith_reversed_right = left_startswith_reversed_right [1; 2; 3; 4] [3; 2; 1]
