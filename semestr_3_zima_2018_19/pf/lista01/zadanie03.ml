let compose f g = fun x -> f(g(x))
let rec iter f x how_many_times =
  if how_many_times = 1 then f x
  else f (iter f x (how_many_times - 1))
(* let multiply x y = iter (+) x y *)
