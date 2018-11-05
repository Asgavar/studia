let rec multitail xs howmany =
  if howmany = 1
  then List.tl xs
  else multitail (List.tl xs) (howmany - 1)

let test_multitail = multitail [1; 2; 3; 4; 5] 3

let rec lists_equal xs ys =
  match (xs, ys) with
    ([], []) -> true
  | (_, [])
  | ([], _) -> false
  | (x :: xs_tail, y :: ys_tail) ->
      if x = y then lists_equal xs_tail ys_tail else false

let test_lists_equal_yes = lists_equal [1; 2; 3] [1; 2; 3]
let test_lists_equal_no = lists_equal [1; 2; 3] [3; 2; 1]

let is_palindrome xs =
  let rec aux left prev_right right =
    match (left, right) with
      (left, []) -> lists_equal left prev_right
    | (left, [last_elem]) -> lists_equal left prev_right
    | (l :: left_tail, r :: r_tail) -> aux left_tail right (List.tl r_tail)
    | (_, _) -> failwith "something is wrong" in
  aux xs xs xs

let test_is_palindrome_1 = is_palindrome ['r'; 'o'; 't'; 'o'; 'r']
let test_is_palindrome_2 = is_palindrome ['a'; 'b'; 'b'; 'a']
let test_is_palindrome_3 = is_palindrome [5; 5; 5; 5]
let test_is_palindrome_4 = is_palindrome [1; 2; 3]
