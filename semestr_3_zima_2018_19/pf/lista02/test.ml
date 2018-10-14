open OUnit2

let sublists_1 ctx =
  assert_equal
    [[1; 2; 3]; [1; 2]; [1; 3]; [1]; [2; 3]; [2]; [3]; []]
    (Lista02.sublists [1; 2; 3])

let sublists_2 ctx =
  assert_bool
    "Sublists count matches"
    (List.length (Lista02.sublists [4; 2]) = (List.length [[4; 2]; [4]; [2]; []]))

let sublists_3 ctx =
  assert_equal ([[]]) (Lista02.sublists [])

let custom_reverse_1 ctx =
  assert_equal [4; 3; 2; 1] (Lista02.custom_reverse [1; 2; 3; 4])

let cycle_1 ctx =
  assert_equal [4; 1; 2; 3] (Lista02.cycle [1; 2; 3; 4] 3)

let cmp_func = fun a b -> a < b

let merge_1 ctx =
  assert_equal [1; 2; 3; 4] (Lista02.merge cmp_func [1; 4] [2; 3])

let merges_are_equal_1 ctx =
  assert_equal (Lista02.merge cmp_func [42; 100] [900; -300])
               (Lista02.merge_tailrec cmp_func [42; 100] [900; -300])

let merge_sort_1 ctx =
  assert_equal [1; 2; 3; 4; 5; 6; 7] (Lista02.merge_sort [7; 6; 5; 4; 3; 2; 1])

let merge_sort_2 ctx =
  assert_equal [1; 2; 3; 4; 5; 6; 7] (Lista02.merge_sort [1; 2; 3; 4; 5; 6; 7])

let merge_sort_3 ctx =
  assert_equal [-7; -5; -3; -1; 2; 4; 6] (Lista02.merge_sort [-7; 6; -5; 4; -3; 2; -1])

let all_suffixes_1 ctx =
  assert_equal [[1; 2; 3; 4; 5]; [2; 3; 4; 5]; [3; 4; 5]; [4; 5]; [5]; []]
               (Lista02.all_suffixes [1; 2; 3; 4; 5])

let test_suite =
  "Lista02TestSuite" >:::
    ["sublists_1" >:: sublists_1;
     "sublists_2" >:: sublists_2;
     "sublists_3" >:: sublists_3;
     "custom_reverse_1" >:: custom_reverse_1;
     "cycle_1" >:: cycle_1;
     "merge_1" >:: merge_1;
     "merges_are_equal_1" >:: merges_are_equal_1;
     "merge_sort_1" >:: merge_sort_1;
     "merge_sort_2" >:: merge_sort_2;
     "merge_sort_3" >:: merge_sort_3;
     "all_suffixes_1" >:: all_suffixes_1;]

let () =
  run_test_tt_main test_suite
