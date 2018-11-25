type 'a list_mutable = LMnil | LMcons of 'a * 'a list_mutable ref

let rec concat_copy l1 l2 =
  match l1 with
    LMnil -> l2
  | LMcons (hd, tl) -> LMcons (hd, ref (concat_copy !tl l2))

let concat_share l1 l2 =
  let rec new_list_hd = l1
  and aux l1 l2 =
    match l1 with
      LMnil -> failwith "coś poszło nie tak!"
    | LMcons (hd, tl) when !tl = LMnil -> begin tl := l2; new_list_hd end
    | LMcons (hd, tl) -> aux !tl l2 in
  aux l1 l2

let test_list_1 = LMcons (1, ref (LMcons (2, ref (LMcons (3, ref (LMcons (4, ref LMnil)))))))
let test_list_2 = LMcons (5, ref (LMcons (6, ref (LMcons (7, ref (LMcons (8, ref LMnil)))))))

let test_copy_1 = concat_copy test_list_1 test_list_2
let test_copy_2 = concat_copy test_list_2 test_list_1

let test_share_1 = concat_share test_list_1 test_list_2
let test_share_2 = concat_share test_list_2 test_list_1
