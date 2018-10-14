let zero =
  fun f x -> x

let succ n =
  fun f x -> f (n f x)

let mul a b =
  fun f x -> a f (b f x)

let isZero =
  fun n ->
    n (fun x -> if x = 1 then 0 else 2) 1 = 1

let rec cnum_of_int i =
  if i = 0
    then zero
    else succ (cnum_of_int (i - 1))

let rec int_of_cnum cn =
  cn (fun x -> x + 1) 0
