type 'a proofelem =
    Var of 'a
  | Conj of 'a proofelem * 'a proofelem
  | Disj of 'a proofelem * 'a proofelem
  | Impl of 'a proofelem * 'a proofelem
  | Box of 'a proofelem * 'a proofelem list

type 'a proof = Proof of 'a proofelem list

let list_of_proof p =
  match p with
    Proof (ps) -> ps

(* od tego miejsca w zasadzie zadanie 4. *)
let rec _posneg_proof pelem =
  match pelem with
    Var whatever -> [whatever], []
  | Disj (left, right)
  | Conj (left, right) ->
      let left_posneg_proof = _posneg_proof left
      and right_posneg_proof = _posneg_proof right in
      (fst left_posneg_proof) @ (fst right_posneg_proof), (snd left_posneg_proof) @ (snd right_posneg_proof)
  | Impl (left, right) ->
      let left_posneg_proof = _posneg_proof left
      and right_posneg_proof = _posneg_proof right in
      (snd left_posneg_proof) @ (fst right_posneg_proof), (fst left_posneg_proof) @ (snd right_posneg_proof)
  | Box (premise, rest) ->
    let premise_posneg = _posneg_proof premise
    and rest_posneg = posneg_proof rest in
    (snd premise_posneg) @ (fst rest_posneg), (fst premise_posneg) @ (snd rest_posneg)

and posneg_proof p_as_list =
  match p_as_list with
    [] -> ([], [])
  | hd :: tl ->
    let hd_posneg = _posneg_proof hd
    and tl_posneg = posneg_proof tl in
    (fst hd_posneg) @ (fst tl_posneg), (snd hd_posneg) @ (snd tl_posneg)
