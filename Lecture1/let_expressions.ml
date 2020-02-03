(* Exercise 6 *)
(* 1 *)
let x = 1 in x;;
(* Valid, it resolves to the value 1. The variable x is only bound locally and thus not available afterwards. *)

(* 2 *)
let x = 1 in let y = x in y;;
(* Valid, it first binds 1 to x, then binds x to y, and lastly resolves to the value of y, which is now 1. *)

(* 3 *)
(* let x = 1 and y = x in y *)
(* Invalid, this is not how "and" is used in OCaml. Instead we should keep nesting with "in". *)

(* 4 *)
(* let x = 1 and x = 2 in x *)
(* Invalid, same argument as above. It also tries to redeclare x without being in a nested scope. *)

(* 5 *)
let x = 1 in let x = x in x;;
(* Valid. We first bind 1 to x, and then shadow it by creating a new variable x that is bound to the original x. Lastly, it resolves to 1. *)

(* 6 *)
let a' = 1 in a' + 1;;
(* Valid, it first binds 1 to a' and then uses it in a body expression to evaluate the value 2. *)

(* 7 *)
(* let 'a = 1 in 'a + 1 *)
(* Invalid, identifiers cannot begin with a '. *)

(* 8 *)
let a'b'c = 1 in a'b'c;;
(* Valid, and it simply resolves to 1. *)

(* 9 *)
let x x = x + 1 in x 2;;
(*
Valid, this first defines a function x that takes one parameter x and adds 1 to it:
    let x x = x + 1
We then call the function with the argument 2, so it evaluates to 3:
    in x 2
 *)
