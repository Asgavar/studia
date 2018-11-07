type 'a place = 'a list * 'a list

let find_nth xs n =
  let rec aux prevs nexts counter =
    if counter = n
    then (prevs, nexts)
    else aux ((List.hd nexts) :: prevs) (List.tl nexts) (counter + 1) in
  aux [] xs 0

let collapse p =
  (List.rev (fst p)) @ (snd p)

let add elem p =
  (fst p), elem :: (snd p)

let del p =
  (fst p), List.tl (snd p)

let next p =
  (List.hd (snd p)) :: (fst p), (List.tl (snd p))

let prev p =
  (List.tl (fst p)), (List.hd (fst p)) :: (snd p)

let test1 = find_nth [1; 2; 3; 4; 5] 2
let test2 = collapse test1
let test3 = add 42 test1
let test4 = collapse (del test1)
let test5 = next test1
let test5 = prev test1

let property1 = collapse (add 3 (find_nth [1; 2; 4] 2)) = [1; 2; 3; 4]
let property2 = collapse (del (find_nth [1; 2; 4] 2)) = [1; 2]
let property3 = del (add 1337 test1) = test1
