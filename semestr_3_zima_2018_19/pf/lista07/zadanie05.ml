let make_joseph_list peoplecount =
  let list_to_be_cycled_over = (List.init peoplecount (fun n: int -> n)) in
  (* TODO *)
  [1; 2; 3]

let rec leaped_over xs n =
  if n = 0
  then xs
  else leaped_over (List.tl xs) (n - 1)

module JosephSet = Set.Make(
  struct let compare = Pervasives.compare
    type t = int end)

let solve_joseph_problem peoplecount leapover =
  let already_removed = JosephSet.empty in
  let rec aux curr_list already_removed answer =
    if JosephSet.mem (List.hd curr_list) already_removed
    then answer
    else aux (leaped_over curr_list (leapover - 1)) (JosephSet.add (List.hd curr_list) already_removed) ((List.hd curr_list) :: answer)
  in
  aux (make_joseph_list peoplecount) already_removed []

let test_make_joseph_list_1 = make_joseph_list 3
let test_1 = solve_joseph_problem 7 3
