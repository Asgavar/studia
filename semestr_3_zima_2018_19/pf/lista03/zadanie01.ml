let horner_tailrec coefficients x =
  let rec _horner_tailrec acc coefficients x =
    match coefficients with
      [] -> acc
    | head :: tail -> _horner_tailrec ((x *. acc) +. head) tail x
  in _horner_tailrec 0. coefficients x


let horner_hiddenrec coefficients x =
  List.fold_left (fun acc next_coefficient -> x *. acc +. next_coefficient) 0. coefficients


let horner_hiddenrec_reversed coefficients x =
  List.fold_right (fun next_coefficient acc -> x *. acc +. next_coefficient) coefficients 0.


let rec horner_explicitrec_reversed coefficients x =
  match coefficients with
    [] -> 0.
  | head :: tail -> x *. (horner_explicitrec_reversed tail x) +. head


let t1 = horner_tailrec [1.; 2.; 3.; 4.] 2.
let t2 = horner_hiddenrec [1.; 2.; 3.; 4.] 2.
let t3 = horner_hiddenrec_reversed [4.; 3.; 2.; 1.] 2.
let t4 = horner_explicitrec_reversed [4.; 3.; 2.; 1.] 2.
