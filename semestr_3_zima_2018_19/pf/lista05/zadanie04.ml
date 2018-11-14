type 'a formula = Var of 'a (* | Neg of 'a formula *) | Conj of 'a formula * 'a formula
  | Disj of 'a formula * 'a formula | Impl of 'a formula * 'a formula

let rec posneg_formula form =
  match form with
    Var whatever -> [whatever], []
  | Disj (left, right)
  | Conj (left, right) ->
      let left_posneg_formula = posneg_formula left
      and right_posneg_formula = posneg_formula right in
      (fst left_posneg_formula) @ (fst right_posneg_formula), (snd left_posneg_formula) @ (snd right_posneg_formula)
  | Impl (left, right) ->
      let left_posneg_formula = posneg_formula left
      and right_posneg_formula = posneg_formula right in
      (snd left_posneg_formula) @ (fst right_posneg_formula), (fst left_posneg_formula) @ (snd right_posneg_formula)

let test = posneg_formula (Impl (Var 'p', Var 'p'))
let test = posneg_formula (Impl ((Disj (Var 'a', Var 'b')), Var 'c'))
let test = posneg_formula (Impl (Impl (Var 'x', Var 'x'), Conj (Var 'x', Var 'x')))
