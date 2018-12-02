module type PQUEUE =
sig
  type priority
  type 'a t

  exception EmptyPQueue

  val empty : 'a t
  val insert : 'a t -> priority -> 'a -> 'a t
  val remove : 'a t -> priority * 'a * 'a t
end


module type ORDTYPE =
sig
  type t
  type comparison = LT | EQ | GT

  val compare : t -> t -> comparison
end


module ParameterizedPQueue (OrdType : ORDTYPE) : PQUEUE =
struct
  type priority = OrdType.t
  type 'a pqueue_entry = PQEntry of priority * 'a
  type 'a t = 'a pqueue_entry list

  exception EmptyPQueue

  let empty = []
  let insert pq elem_priority elem =
    PQEntry (elem_priority, elem) :: pq

  let remove pq =
    if pq = [] then raise EmptyPQueue else
    let pq_sorted = (List.sort (fun a_pair b_pair ->
        match (a_pair, b_pair) with
          PQEntry (a_priority, _), PQEntry (b_priority, _) when (OrdType.compare a_priority b_priority) = EQ -> 0
        | PQEntry (a_priority, _), PQEntry (b_priority, _) when (OrdType.compare a_priority b_priority) = GT -> -1
        | PQEntry (a_priority, _), PQEntry (b_priority, _) when (OrdType.compare a_priority b_priority) = LT -> 1
        | _, _ -> failwith "")
        pq)
    in
    let to_be_ret = List.hd pq_sorted in
    match to_be_ret with
      PQEntry (elem_priority, elem) -> (elem_priority, elem, (List.tl pq_sorted))
end


module IntOrdType : ORDTYPE =
struct
  type t = int
  (* TODO: jak poradzic sobie bez tej redefinicji? *)
  type comparison = LT | EQ | GT
  let compare x y =
    match (x, y) with
      (x, y) when x < y -> LT
    | (x, y) when x = y -> EQ
    | (x, y) when x > y -> GT
    | _ -> failwith ""
end


module IntPQueue = ParameterizedPQueue (IntOrdType)
(* module II = (IntPQueue:PQUEUE with type priority = IntPQueue.priority) *)
(* module II = (IntPQueue:PQUEUE with type t = int) *)
(* module PP = (IntPQueue:PQUEUE with type priority = int) *)


let first_tuple_elem tuple =
  match tuple with
    (a, _, _) -> a

let second_tuple_elem tuple =
  match tuple with
    (_, b, _) -> b

let third_tuple_elem tuple =
  match tuple with
    (_, _, c) -> c

let list_of_pq pq =
  let rec aux pq acc =
    try let pq_tl = IntPQueue.remove pq
      in aux (third_tuple_elem pq_tl) ((second_tuple_elem pq_tl) :: acc)
    with IntPQueue.EmptyPQueue -> acc
  in aux pq []

let sort_with_pq (xs : int list) =
  let initial_pq = IntPQueue.empty in
  let rec aux pq xs =
    match xs with
      [] -> list_of_pq pq
    | hd :: tl -> aux (IntPQueue.insert pq hd hd ) tl in
  aux initial_pq xs


let test_sort_with_pq_1 = sort_with_pq [1; 2; 3; 4; 5; 6; 7]
let test_sort_with_pq_2 = sort_with_pq [9; 8; 7; 6; 5; 4; 3; 2; 1]
let test_sort_with_pq_1 = sort_with_pq [42; 8; -99; 41]
