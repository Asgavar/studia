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

let test_suite =
  "Lista02TestSuite" >:::
    ["sublists_1" >:: sublists_1;
     "sublists_2" >:: sublists_2;
     "sublists_3" >:: sublists_3;
     "custom_reverse_1" >:: custom_reverse_1;
     "cycle_1" >:: cycle_1]

let () =
  run_test_tt_main test_suite
