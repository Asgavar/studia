let is_square_matrix m =
  List.fold_left (fun bool1 bool2 -> bool1 && bool2) true
    (List.map (fun len -> len = List.length m) (List.map List.length m))


let rec nth_column matrix n =
  List.map (fun row -> List.nth row n) matrix


let upto n =
  let rec _upto n =
    if n = -1 then [] else n :: _upto (n - 1)
  in List.rev (_upto (n - 1))


let transposed matrix =
  List.map (fun colno -> nth_column matrix colno) (upto (List.length matrix))


let zip xs ys =
  let rec _zip xs ys acc =
    match (xs, ys) with
      ([], _) | (_, []) -> acc
    | (x :: xs_tail, y :: ys_tail) -> _zip xs_tail ys_tail ((x, y) :: acc)
  in List.rev (_zip xs ys [])


let zipf f xs ys =
  List.map (fun pair -> f (fst pair) (snd pair)) (zip xs ys)


let mult_vec vector matrix =
  List.map (fun to_be_summed -> (List.fold_left (+) 0 to_be_summed))
    (List.map (fun idx -> zipf (fun from_vec from_mat -> from_vec * from_mat) vector (nth_column matrix idx))
       (upto (List.length vector)))


let mult_matrices m1 m2 =
  let rows_with_idx = zip m1 (upto (List.length m1))
  in List.map (fun row_idx -> mult_vec (fst row_idx) [(nth_column m2 (snd row_idx))])
    rows_with_idx


let t1 = is_square_matrix [[1; 2]; [3; 4]]
let t2 = is_square_matrix [[1; 2; 3]; [3; 4; 5]; [7; 8; 9]]
let t3 = is_square_matrix [[1; 2; 3]; [3; 4]]

let t4 = transposed [[1; 2; 3]; [4; 5; 6]; [7; 8; 9]]

let t5 = zip [1; 2; 3] ["a"; "b"; "c"]
let t6 = zip [1; 2; 3] [4; 5; 6]

let t7 = zipf (+) [1; 2; 3] [4; 5; 6]
let t8 = mult_vec [1; 2] [[2; 0]; [4; 5]]

let t9 = mult_matrices [[1; 1; 1]; [1; 1; 1]; [1; 1; 1]] [[1; 1; 1]; [1; 1; 1]; [1; 1; 1]]
