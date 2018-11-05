type 'a formula = Var of 'a | Neg of 'a formula | Conj of 'a formula * 'a formula | Disj of 'a formula * 'a formula

let vars_used f =
  let rec aux so_far current =
    match current with
      Var varname -> varname :: so_far
    | Neg form -> aux so_far form
    | Conj (left, right) -> (aux [] left) @ (aux so_far right)
    | Disj (left, right) -> (aux [] left) @ (aux so_far right) in
  aux [] f

let test_vars_used = vars_used (Conj ((Var 'x'), Disj((Var 'y'), Neg(Conj ((Var 'z'), (Neg (Var 'y')))))))
