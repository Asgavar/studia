type ('a, 'b) memoentry = {arg: 'a; retval: 'b}
type ('a, 'b) memostore = ('a, 'b) memoentry array ref

let make_memostore () =
  [||]

let add_to_memostore arg retval ms =
  ms := Array.append [|{arg=arg; retval=retval}|] !ms

let find_in_memostore arg ms =
  let rec aux idx =
    if ms.(idx).arg = arg
    then ms.(idx).retval
    else aux (idx + 1)
  in
  aux 0

let rec fib n =
  if n <= 2
  then 1
  else fib (n - 2) + fib (n - 1)

let memo = ref (make_memostore ())

let rec fib_memo n =
  try find_in_memostore n !memo
  with Invalid_argument msg ->
    if n <= 2
    then begin
      add_to_memostore n 1 memo;
      1
    end
    else
      let retval = fib_memo (n - 2) + fib_memo (n - 1) in
      begin
        add_to_memostore n retval memo;
        retval
      end

let test_fib_1 = fib 33
let test_fib_memo_1 = fib_memo 33

let test_fib_2 = fib 1000
let test_fib_memo_2 = fib_memo 1000

let test_fib_3 = fib 13378
let test_fib_memo_3 = fib_memo 13378
