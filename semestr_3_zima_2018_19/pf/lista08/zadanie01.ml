module type PQUEUE =
sig
  type priority
  type 'a t

  exception EmptyPQueue

  val empty : 'a t
  val insert : 'a t -> priority -> 'a -> 'a t
  val remove : 'a t -> priority * 'a * 'a t
end


module PQueue : (PQUEUE with type priority = int) =
struct
  type priority = int
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
          PQEntry (a_priority, _), PQEntry (b_priority, _) when a_priority = b_priority -> 0
        | PQEntry (a_priority, _), PQEntry (b_priority, _) when a_priority > b_priority -> -1
        | PQEntry (a_priority, _), PQEntry (b_priority, _) when a_priority < b_priority -> 1
        | _, _ -> failwith "ups, właśnie udowodniliśmy, że zbiór liczb całkowitych nie jest liniowo uporządkowany")
        pq)
    in
    let to_be_ret = List.hd pq_sorted in
    match to_be_ret with
      PQEntry (elem_priority, elem) -> (elem_priority, elem, (List.tl pq_sorted))
end


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
    try let pq_tl = PQueue.remove pq
      in aux (third_tuple_elem pq_tl) ((second_tuple_elem pq_tl) :: acc)
    with PQueue.EmptyPQueue -> acc
  in aux pq []

let sort_with_pq xs =
  let initial_pq = PQueue.empty in
  let rec aux pq xs =
    match xs with
      [] -> list_of_pq pq
    | hd :: tl -> aux (PQueue.insert pq hd hd ) tl in
  aux initial_pq xs


(* testy *)

let test_pq = PQueue.empty

let test_1 = PQueue.insert
    (PQueue.insert
       (PQueue.insert test_pq 2 "powinienem byc drugi") 4 "ja pierwszy") (-42) "ja ostatni :c"

let test_1_first_rm =
  (PQueue.remove test_1)
let test_1_second_rm =
  (PQueue.remove (third_tuple_elem test_1_first_rm))
let test_1_third_rm =
  (PQueue.remove (third_tuple_elem test_1_second_rm))

let test_1_res =
  (second_tuple_elem test_1_first_rm) :: (second_tuple_elem test_1_second_rm) :: (second_tuple_elem test_1_third_rm) :: []

let test_sort_with_pq_1 = sort_with_pq [1; 2; 3; 4; 5; 6; 7]
let test_sort_with_pq_2 = sort_with_pq [9; 8; 7; 6; 5; 4; 3; 2; 1]
let test_sort_with_pq_1 = sort_with_pq [42; 8; -99; 41]
