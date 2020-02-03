(* Exercise 4 *)
(* In order to evaluate *)
(* "I love QuickCheck " ^ 2 *)
(* We must either use print formatting *)
Printf.printf "I love QuickCheck %d" 2;;

(* Or convert the number to a string, because values of different types cannot be concatenated together: *)
print_endline ("I love QuickCheck " ^ string_of_int 2);;

