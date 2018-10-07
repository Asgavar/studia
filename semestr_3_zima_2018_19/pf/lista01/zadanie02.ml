let rec an_rec n =
  if n = 0 then 0 else 2 * (an_rec (n - 1)) + 1
let rec _an_tail_rec n acc ptr =
  if ptr = n then acc else _an_tail_rec n (2 * acc + 1) (ptr + 1)
let an_tail_rec n = _an_tail_rec n 0 0
