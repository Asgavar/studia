let some_stream n = n
let sq_stream n = n * n
let ab_stream n = if n mod 2 = 0 then 'a' else 'b'

let hd stream = stream 0
let tl stream = fun n -> stream (n + 1)

let add stream constant = fun n -> (stream n) + constant

let stream_map stream f = fun n -> f (stream n)
let double_stream_map left_stream right_stream f =
  fun n -> f (left_stream n) (right_stream n)

let replace stream replace_with replace_each =
  fun n -> if n mod replace_each = 0 then replace_with else (stream n)

let take stream each_nth =
  fun n -> stream (n * each_nth)

let scan stream f a =
  let rec new_stream n =
    if n = 0 then (f a (stream 0)) else (f (new_stream (n - 1)) (stream n))
  in new_stream

let rec _tabulate start finish so_far stream =
  if so_far > finish then [] else
  if so_far >= start then
    (stream so_far)::_tabulate start finish (so_far + 1) stream
  else _tabulate start finish (so_far + 1) stream
let tabulate ?(start=0) finish stream = _tabulate start finish 0 stream
