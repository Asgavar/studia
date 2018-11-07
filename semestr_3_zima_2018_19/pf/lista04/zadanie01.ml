let rec startswith xs maybe_prefix =
  match (xs, maybe_prefix) with
    (xs, []) -> true
  | ([], maybe_prefix) -> false
  | (x :: xstl, mp :: maybe_prefixtl) ->
      if x = mp then startswith xstl maybe_prefixtl else false

let is_palindrome xs =
  let rec aux left right =
    match (left, right) with
      (left, []) -> startswith xs (List.rev left)
    | (left, [last_elem]) -> startswith xs (List.rev left)
    | (l :: left_tail, r :: r_tail) -> aux left_tail (List.tl r_tail)
    | (_, _) -> failwith "something is wrong" in
  aux xs xs

let test_is_palindrome = is_palindrome ['r'; 'o'; 't'; 'o'; 'r']
let test_is_palindrome = is_palindrome ['a'; 'b'; 'b'; 'a']
let test_is_palindrome = is_palindrome ['a'; 'b'; 'c'; 'd'; 'c'; 'b'; 'a']
let test_is_palindrome = is_palindrome [5; 5; 5; 5]
let test_is_palindrome = is_palindrome [1; 2; 3]
