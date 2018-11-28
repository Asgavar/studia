type josephcell = {head: int; mutable tail: josephcell}

let make_joseph_list peoplecount =
  let rec aux very_head curr_count =
    if curr_count = peoplecount
    then {head=peoplecount; tail=very_head}
    else {head=curr_count; tail=(aux very_head (curr_count + 1))} in
  let rec first_head = {head=1; tail=first_head} in
  let tail_to_be_attached = aux first_head 2 in
  begin
    first_head.tail <- tail_to_be_attached;
    first_head
  end

let rec leaped_over xs n =
  if n = 0
  then xs
  else leaped_over xs.tail (n - 1)

(* zakładam, że liczba osób co które usuwamy człowieka
   z kółka jest większa od 1 - w przeciwnym wypadku odpowiedzią
   jest po prostu lista od 1 do n *)
let solve_joseph_problem peoplecount leapover =
  let rec aux curr_head answer =
    if (List.length answer) = peoplecount
    then answer
    else
      let prev_cell = leaped_over curr_head (leapover - 2) in
      begin
        let new_answer = prev_cell.tail.head :: answer in
        prev_cell.tail <- prev_cell.tail.tail;
        aux (leaped_over prev_cell 1) new_answer
      end
  in
  List.rev (aux (make_joseph_list peoplecount) [])


let test_make_joseph_list_1 = make_joseph_list 5
let test_leaped_over_1 = leaped_over test_make_joseph_list_1 2
let test_1 = solve_joseph_problem 7 3
let test_2 = solve_joseph_problem 10 2
let test_3 = solve_joseph_problem 42 3
