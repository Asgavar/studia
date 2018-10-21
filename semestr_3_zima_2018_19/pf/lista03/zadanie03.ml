let neighbors xs =
  let rec _neighbors xs last_x left right left_ready acc =
    if left_ready then
      _neighbors xs last_x right [] false (left :: acc)
    else match xs with
        [] -> left :: acc
      | x :: tail ->
        if x = last_x then _neighbors tail x (x :: left) right false acc
        else _neighbors tail x left (x :: right) true acc
  in List.rev (_neighbors xs (List.hd xs) [] [] false [])


let t1 = neighbors [1; 1; 2; 3; 3; 4]
let t2 = neighbors [42; 42; 42; 42; 7]
let t2 = neighbors [5; 4; 3; 2; 1; 1]
