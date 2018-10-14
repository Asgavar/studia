(* int -> int *)
let f1 x = 1 * x
(* 'a -> 'b *)
let rec f2 x = f2 x
(* ('a -> 'b) -> ('c -> 'a) -> 'c -> 'b *)
let f3 f g x = f(g(x))
