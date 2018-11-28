let make_fresh_reset_pair =
  let rec curr_idx = ref 0
  and fresh = (fun varname ->
      curr_idx := (!curr_idx + 1);
      varname ^ string_of_int !curr_idx)
  and reset = (fun new_idx -> curr_idx := new_idx)
  in
  (fresh, reset)

let fr_pair = make_fresh_reset_pair
let fresh = fst fr_pair
let reset = snd fr_pair

let test_1 = fresh "x"
let test_2 = fresh "x"
let test_3 = fresh "x"
let test_4 = fresh "x"

let unit = reset 42

let test_43 = fresh "x"
let test_44 = fresh "x"
let test_45 = fresh "x"
let test_46 = fresh "x"
