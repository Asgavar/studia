(* int -> int *)
let f1 x = 1 * x
(* 'a -> 'b *)
let rec f2 x = f2 x
let f3 = fun a b -> (fun c -> a)
