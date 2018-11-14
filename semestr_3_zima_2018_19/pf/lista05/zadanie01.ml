type 'a lazylist = LazyNull | LazyCons of 'a * (unit -> 'a lazylist)
type 'a stdlib_lazylist = StdLibLazyNull | StdLibLazyCons of 'a * 'a stdlib_lazylist lazy_t

let rec leibnitz_stream value_so_far n =
  let current = (-1.) ** (n -. 1.) *. 1. /. ((n *. 2.) -. 1.) in
  LazyCons (value_so_far +. current, (fun () -> leibnitz_stream (value_so_far +. current) (n +. 1.)))

let rec stdlib_leibnitz_stream value_so_far n =
  let current = (-1.) ** (n -. 1.) *. 1. /. ((n *. 2.) -. 1.) in
  StdLibLazyCons (value_so_far +. current, lazy (stdlib_leibnitz_stream (value_so_far +. current) (n +. 1.)))

let lazyvalue lxs =
  match lxs with
    LazyNull -> failwith "null passed"
  | LazyCons (value, _) -> value

let stdlib_lazyvalue slxs =
  match slxs with
    StdLibLazyNull -> failwith "null passed"
  | StdLibLazyCons (value, _) -> value

let lazynext lxs =
  match lxs with
    LazyNull -> LazyNull
  | LazyCons (_, next) -> next ()

let stdlib_lazynext slxs =
  match slxs with
    StdLibLazyNull -> StdLibLazyNull
  | StdLibLazyCons (_, next) -> Lazy.force next

let rec lazymap f lxs =
  match lxs with
    LazyNull -> LazyNull
  | LazyCons (value, next_func) ->
      let current = lxs
      and next = lazynext lxs
      and nextnext = lazynext (lazynext lxs) in
      LazyCons ((f (lazyvalue current) (lazyvalue next) (lazyvalue nextnext)), (fun () -> (lazymap f next)))

let x = lazy (2 + 2)
let forced_x = Lazy.force x

let rec naturals_stream prev =
  LazyCons ((prev +. 1.), (fun () -> (naturals_stream (prev +. 1.))))

let euler_transformation x y z =
  z -. (((y -.z) ** 2.) /. (x -. (2. *. y) +. z))

let test = 4. *. lazyvalue (lazynext (lazynext (lazynext (lazynext (lazynext (lazynext (lazynext (leibnitz_stream 0. 1.))))))))
let test = lazymap (fun a b c -> a +. b +. c) (naturals_stream 0.)
let test = lazynext (lazymap (fun a b c -> a +. b +. c) (naturals_stream 0.))
let test = lazynext (lazynext (lazymap (fun a b c -> a +. b +. c) (naturals_stream 0.)))
let test = 4. *. (lazyvalue (lazymap euler_transformation (leibnitz_stream 0. 1.)))
