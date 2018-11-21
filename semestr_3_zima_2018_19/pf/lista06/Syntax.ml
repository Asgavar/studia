(** Typ danych reprezentujący formuły zdaniowe *)
type 'a prop = Var of 'a | Top | Bot
             | Conj of 'a prop * 'a prop
             | Disj of 'a prop * 'a prop
             | Impl of 'a prop * 'a prop

(** Typ danych reprezentujący drzewa dowodu w systemie dedukcji
   naturalnej, wraz z typem ramek *)
type 'a pt = Ax of 'a prop
           | TopI
           | ConjI  of 'a pt * 'a pt
           | DisjIL of 'a pt * 'a prop
           | DisjIR of 'a prop * 'a pt
           | ImplI  of 'a hypt
           | BotE   of 'a prop
           | ConjEL of 'a pt
           | ConjER of 'a pt
           | DisjE  of 'a pt * 'a hypt * 'a hypt
           | ImplE  of 'a pt * 'a pt
and 'a hypt = 'a prop * 'a pt

(** Typ danych reprezentujący skryptowy zapis dowodu (patrz lista 5) w
   systemie dedukcji naturalnej, wraz z typem ramek *)
type 'a ps = PDone of 'a prop
           | PConc of 'a prop * 'a ps
           | PHyp  of 'a shyp * 'a ps
and 'a shyp = 'a prop * 'a ps


type 'a thing = TGoal of string * ('a prop) * ('a pt)
              | SGoal of string * ('a prop) * ('a ps)

(** Plik zawiera listę dowodów (jednego lub drugiego rodzaju) ze
   zmiennymi typu string *)
type file = string thing list


(* zadanie pierwsze *)
let rec conclusion_tree premises proof =
  match proof with
    Ax f -> if List.mem f premises then f else failwith "aksjomat znikąd"
  | TopI -> Top
  | BotE f -> f
  | ImplE (pred, impl_body) ->
    (match (conclusion_tree premises pred, conclusion_tree premises impl_body) with
      (p, Impl (p_impl, q_impl)) when p = p_impl -> q_impl
    | _ -> failwith "niewłaściwa implikacja")
  | ConjEL f -> (match conclusion_tree premises f with
      Conj (p, q) -> p
    | _ -> failwith "eliminacja czegoś, co nie było koniunkcją (L)")
  | ConjER f -> (match conclusion_tree premises f with
      Conj (p, q) -> q
      | _ -> failwith "eliminacja czegoś, co nie było koniunkcją (R)")
  | ConjI (p, q) -> Conj (conclusion_tree premises p, conclusion_tree premises q)
  | DisjIL (proof, new_prop) -> Disj (conclusion_tree premises proof, new_prop)
  | DisjIR (new_prop, proof) -> Disj (new_prop, conclusion_tree premises proof)
  | ImplI (new_prem, impl_proof) -> conclusion_tree (new_prem :: premises) impl_proof
  | DisjE (disj_proof, p_hypt, q_hypt) ->
    (match conclusion_tree premises disj_proof with
      Disj (p, q) ->
      (match (p_hypt, q_hypt) with
        ((p_hypt_p, p_hypt_proof), (q_hypt_q, q_hypt_proof)) when p_hypt_p = p && q_hypt_q = q ->
        (match (conclusion_tree (p :: premises) p_hypt_proof, conclusion_tree (q :: premises) q_hypt_proof) with
           (p_result, q_result) when p_result = q_result -> p_result
         | _ -> failwith "podczas eliminacji dysjunkcji implikacje dowiodły różnych rzeczy")
       | _ -> failwith "podczas eliminacji dysjunkcji przekazano niewłaściwe przesłanki")
     | _ -> failwith "próba eliminacji dysjunkcji, która nie jest dysjunkcją")

let is_proof_ok_tree proof =
  match proof with
    TGoal (goal_name, formula, proof) ->
    (match proof with
       ImplI (pred, succ) -> conclusion_tree [pred] succ
     | proof -> conclusion_tree [] proof)
  | SGoal (_, _, _) -> failwith "nie zrobiłem zadania drugiego"

let rec string_of_prop p =
  match p with
    Var f -> "Var " ^ f
  | Top -> "T"
  | Bot -> "F"
  | Conj (p, q) -> string_of_prop p ^ " AND " ^ string_of_prop q
  | Disj (p, q) -> string_of_prop p ^ " OR " ^ string_of_prop q
  | Impl (p, q) -> string_of_prop p ^ " => " ^ string_of_prop q

let print_proof_ok_info proof =
  try print_string ("poprawny dowód, " ^ string_of_prop (is_proof_ok_tree proof) ^ "\n")
  with Failure msg -> print_string ("błędny dowód, " ^ msg ^ "\n")
