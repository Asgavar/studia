let compose f g = fun x -> f(g(x))

let rec iter f how_many_times =
  if how_many_times = 1
    then f
    else compose f (iter f (how_many_times - 1))

let multiply x y =
  iter (fun acc -> acc + x) (y - 1) x

let exp x y =
  iter (fun acc -> acc * x) (y - 1) x
