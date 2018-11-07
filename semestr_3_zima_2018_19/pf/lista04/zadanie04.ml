type 'a formula = Var of 'a | Neg of 'a formula | Conj of 'a formula * 'a formula | Disj of 'a formula * 'a formula

let rec contains xs elem =
  match xs with
    [] -> false
  | hd :: tl -> hd = elem || contains tl elem

let rec remove_duplicates xs =
  match xs with
    [] -> []
  | hd :: tl -> if contains tl hd then (remove_duplicates tl) else hd :: (remove_duplicates tl)

let vars_used f =
  let rec aux so_far current =
    match current with
      Var varname -> varname :: so_far
    | Neg form -> aux so_far form
    | Conj (left, right) -> (aux [] left) @ (aux so_far right)
    | Disj (left, right) -> (aux [] left) @ (aux so_far right) in
  remove_duplicates (aux [] f)

let rec map_append f xs =
  match xs with
    [] -> []
  | hd :: tl -> (f hd) @ (map_append f tl)

let rec all_values vars =
  match vars with
    [] -> failwith "niemozliwe"
  | [last] -> [[(last, true)]; [(last, false)]]
  | hd :: tl -> map_append (fun vals -> [(hd, true) :: vals; (hd, false) :: vals]) (all_values tl)

let rec varval varname vals =
  let head = (List.hd vals) in
    if (fst head) = varname then (snd head) else varval varname (List.tl vals)

let rec formulaval form vals =
  match form with
    Var varname -> varval varname vals
  | Neg form_inside -> not (formulaval form_inside vals)
  | Conj (left_form, right_form) -> (formulaval left_form vals) && (formulaval right_form vals)
  | Disj (left_form, right_form) -> (formulaval left_form vals) || (formulaval right_form vals)

(* type typeinferencesilencer = List | true | false *)

let rec process_what_is_supposed_to_be_a_tautology current_formval current_varval =
  match current_formval with
    [] -> (true, [])
  | true :: tl -> process_what_is_supposed_to_be_a_tautology tl (List.tl current_varval)
  | false :: tl -> (false, List.hd current_varval)

let rec is_tautology form =
  let varvals = all_values (vars_used form) in
  process_what_is_supposed_to_be_a_tautology (List.map (fun vv -> formulaval form vv) varvals) varvals

let rec nnf form =
  match form with
    Var varname -> form
  | Neg (Var varname) -> form
  | Neg (Disj (left_form, right_form)) -> Conj ((nnf left_form), (nnf right_form))
  | Neg (Conj (left_form, right_form)) -> Disj ((nnf left_form), (nnf right_form))
  | Neg (Neg form) -> form
  | Disj (left_form, right_form) -> Disj ((nnf left_form), (nnf right_form))
  | Conj (left_form, right_form) -> Conj ((nnf left_form), (nnf right_form))

let satisfied_varvals form =
  List.filter (fun vals -> formulaval form vals) (all_values (vars_used form))

let unsatisfied_varvals form =
  List.filter (fun vals -> not (formulaval form vals)) (all_values (vars_used form))

let rec filp_varvals vv =
  match vv with
    [] -> []
  | hd :: tl -> ((fst hd), not (snd hd)) :: filp_varvals tl

let dnf form =
  satisfied_varvals form

let cnf form =
  List.map (fun vv -> filp_varvals vv) (unsatisfied_varvals form)

let is_tautology_syntactically form =
  (List.length (dnf form)) = int_of_float (2. ** float_of_int (List.length (vars_used form)))

let is_unsatisfiable_syntactically form =
  (List.length (cnf form)) = int_of_float (2. ** float_of_int (List.length (vars_used form)))

let test_contains = contains [1; 2; 3] 3
let test_contains = contains [1; 2; 3] 0
let test_remove_duplicates = remove_duplicates [1; 2; 3; 1; 4; 3; 3]
let test_vars_used = vars_used (Conj ((Var 'x'), Disj((Var 'y'), Neg(Conj ((Var 'z'), (Neg (Var 'y')))))))
let test_all_values = all_values test_vars_used
let test_is_tautology = is_tautology (Disj ((Var 'p'), (Neg (Var 'p'))))
let test_is_tautology = is_tautology (Disj ((Var 'p'), (Neg (Var 'q'))))
let test_is_tautology = is_tautology (Conj ((Var 'p'), (Neg (Var 'q'))))
let test_nnf = nnf (Neg (Conj ((Var 'x'), Disj((Var 'y'), Neg(Conj ((Var 'z'), (Neg (Var 'y'))))))))
let test_dnf = dnf (Neg (Conj ((Var 'x'), Disj((Var 'y'), Neg(Conj ((Var 'z'), (Neg (Var 'y'))))))))
let test_cnf = cnf (Neg (Conj ((Var 'x'), Disj((Var 'y'), Neg(Conj ((Var 'z'), (Neg (Var 'y'))))))))
let test_is_tautology_syntactically = is_tautology_syntactically (Disj ((Disj ((Var 'p'), (Neg (Var 'p')))), (Neg (Var 'p'))))
let test_is_unsatisfiable_syntactically = is_unsatisfiable_syntactically (Conj ((Conj ((Var 'p'), (Var 'q'))), (Neg (Var 'p'))))
