type glasses = Glasses of (int list) * (int list)
type move = Fill of int | Drain of int | Transfer of int * int

let volumes gs =
  match gs with
    Glasses (vols, _) -> vols

let values gs =
  match gs with
    Glasses (_, vals) -> vals

let rec fill nth gs =
  let vols = (volumes gs)
  and vals = (values gs) in
  match nth with
    0 ->
      Glasses (vols, (List.hd vols) :: (List.tl vals))
  | nth ->
      let further_glasses = fill (nth - 1) (Glasses ((List.tl vols), (List.tl vals))) in
      let further_vols = (volumes further_glasses)
      and further_vals = (values further_glasses) in
      Glasses ((List.hd vols :: further_vols), (List.hd vals :: further_vals))

let rec drain nth gs =
  let vols = (volumes gs)
  and vals = (values gs) in
  match nth with
    0 ->
      Glasses (vols, 0 :: (List.tl vals))
    | nth ->
        let further_glasses = drain (nth - 1) (Glasses ((List.tl vols), (List.tl vals))) in
        let further_vols = (volumes further_glasses)
        and further_vals = (values further_glasses) in
        Glasses ((List.hd vols :: further_vols), (List.hd vals :: further_vals))

let rec set_glass_value nth n_val gs =
  let vols = (volumes gs)
  and vals = (values gs) in
  match nth with
    0 ->
      Glasses (vols, n_val :: (List.tl vals))
    | nth ->
        let further_glasses = set_glass_value (nth - 1) n_val (Glasses ((List.tl vols), (List.tl vals))) in
        let further_vols = (volumes further_glasses)
        and further_vals = (values further_glasses) in
        Glasses ((List.hd vols :: further_vols), (List.hd vals :: further_vals))

let rec transfer fromth toth gs =
  let vols = (volumes gs)
  and vals = (values gs) in
  let current_from = List.nth vals fromth
  and current_to = List.nth vals toth
  and to_capacity = List.nth vols toth in
  let vol_left_in_target = to_capacity - current_to in
  match current_from with
    0 -> gs
  | current_from when current_from < vol_left_in_target ->
      (* set_glass_values fromth 0 toth (current_to + current_from) gs *)
      set_glass_value toth (current_to + current_from) (set_glass_value fromth 0 gs)
  | current_from ->
      (* set_glass_values fromth (current_from - vol_left_in_target) toth (current_to + vol_left_in_target) *)
      set_glass_value toth (current_to + vol_left_in_target) (set_glass_value fromth (current_from - vol_left_in_target) gs)

let all_generic gs constructor_func =
  let vols = volumes gs in
  let rec aux idx vols_so_far =
    match vols_so_far with
      [] -> []
    | hd :: tl -> [[constructor_func idx]] @ aux (idx + 1) tl in
  aux 0 vols

let all_fills gs =
  all_generic gs (fun idx -> Fill idx)

let all_drains gs =
  all_generic gs (fun idx -> Drain idx)

let all_transfers gs =
  let max_idx = (List.length (volumes gs)) - 1 in
  let rec aux left right =
    match (left, right) with
      (left, right) when left = max_idx && right = max_idx -> []
    | (left, right) when left = right -> aux left (right + 1)
    | (left, right) when right = max_idx -> [[Transfer (left, max_idx)]] @ aux (left + 1) 0
    | (left, right) -> [[Transfer (left, right)]] @ aux left (right + 1) in
  aux 0 0

let all_one_step_moves gs =
  all_fills gs @ all_drains gs @ all_transfers gs

let rec map_append f xs =
  match xs with
    [] -> []
  | hd :: tl -> (f hd) @ (map_append f tl)

let all_successor_moves mvs gs =
  let options_to_consider = all_one_step_moves gs in
  let rec aux options mvs =
    match options with
      [] -> []
    | hd :: tl -> (List.map (fun moves_before -> moves_before @ hd) mvs) @ aux tl mvs in
  aux options_to_consider mvs

type 'a simplerlazylist = LazyCons of 'a * (unit -> 'a simplerlazylist)

let lazyvalue lxs =
  match lxs with LazyCons (value, _) -> value

let lazynext lxs =
  match lxs with LazyCons (_, next) -> next ()

let rec almost_lazy_all_moves_list mvs gs =
  match mvs with
    [] -> almost_lazy_all_moves_list (all_successor_moves mvs gs) gs
  | hd :: tl -> LazyCons (hd, fun () -> (almost_lazy_all_moves_list tl gs))

let rec is_moves_list_ok_for_us mvs target_val gs =
  match mvs with
    [] -> List.for_all (fun v -> v = target_val) (values gs)
  | hd :: tl ->
      match hd with
        Fill idx -> is_moves_list_ok_for_us tl target_val (fill idx gs)
      | Drain idx -> is_moves_list_ok_for_us tl target_val (drain idx gs)
      | Transfer (fromth, toth) -> is_moves_list_ok_for_us tl target_val (transfer fromth toth gs)

let rec almost_lazy_stream_of_sols current_moves_list target_val gs =
  if is_moves_list_ok_for_us (lazyvalue current_moves_list) target_val gs
  then LazyCons ((lazyvalue current_moves_list), fun () -> almost_lazy_stream_of_sols (lazynext current_moves_list) target_val gs)
  else almost_lazy_stream_of_sols (lazynext current_moves_list) target_val gs

let rec nsols desired_volume howmany gs =
  let rec aux solstream howmany =
    if howmany = 0
    then []
    else lazyvalue solstream :: aux (lazynext solstream) (howmany - 1) in
  aux (almost_lazy_stream_of_sols (almost_lazy_all_moves_list (all_one_step_moves gs) gs) desired_volume gs) howmany

let test_glasses = Glasses ([4; 9], [4; 6])
let test_glasses_2 = Glasses ([1; 2; 3; 4], [0; 0; 0; 0])

let test_fill = fill 0 test_glasses
let test_fill = fill 1 test_glasses
let test_drain = drain 0 test_glasses
let test_drain = drain 1 test_glasses
let test_transfer = transfer 0 1 test_glasses
let test = [Fill 1; Drain 2; Transfer (3, 4)]
let test = all_fills test_glasses_2
let test = all_drains test_glasses_2
let test = all_transfers test_glasses_2
let test = all_one_step_moves test_glasses_2
let test_all_successor_moves = all_successor_moves (all_one_step_moves test_glasses_2) test_glasses_2
let test_is_ok_for_us_nope = is_moves_list_ok_for_us (List.hd test_all_successor_moves) 3 test_glasses_2
let test_is_ok_for_us_yup = is_moves_list_ok_for_us [Fill 0; Fill 1; Drain 0; Fill 0;] 4 (Glasses ([4; 4], [1; 1]))

(* let test_sols_stream = almost_lazy_stream_of_sols (almost_lazy_all_moves_list (all_one_step_moves test_glasses) test_glasses) 0 test_glasses *)
(* let test_nsols = nsols 0 1 test_glasses *)
