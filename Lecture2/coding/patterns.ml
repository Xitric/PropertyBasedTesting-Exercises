(* Exercise 2 *)
(* Binding using pattern matching directly in the head *)
let fst (x, _) = x

(* Binding using pattern matching shorthand *)
let snd = function (_, y) -> y

(* Alternatively, we can write *)
let first p = match p with (x, _) -> x
