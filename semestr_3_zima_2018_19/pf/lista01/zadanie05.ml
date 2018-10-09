let ctrue = fun x y -> if x > y then x else y
let cfalse = fun x y -> if x < y then x else y
let cand bool1 bool2 =
  fun x y -> if (bool1 x y = bool2 x y) && (bool1 x y = ctrue x y) then x else y
let cor bool1 bool2 =
  fun x y -> if bool1 x y = ctrue x y || bool2 x y = ctrue x y then x else y
let cbool_of_bool boolval =
  if boolval then ctrue else cfalse
let bool_of_cbool cboolval =
  if cboolval true false then true else false
