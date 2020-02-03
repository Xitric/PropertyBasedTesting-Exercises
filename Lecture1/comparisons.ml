let print_bool = fun b ->
    Printf.printf "%b\n" b;;

(* Exercise 2 *)
(* We compare values *)
print_endline "Exercise 2";;
print_bool (0 = 0);; (* true *)
print_bool (0 <> 0);; (* false *)
print_bool (0l = 0l);; (* true *)
print_bool (0l <> 0l);; (* false *)

(* Exercise 3 *)
(* We compare memory locations *)
print_endline "\nExercise 3";;
print_bool (0 == 0);; (* true *)
print_bool (0 != 0);; (* false *)
print_bool (0l == 0l);; (* false *)
print_bool (0l != 0l);; (* true *)

(* Why? *)
(* The default int type uses stack memory, and therefore 0 == 0 is true *)
(* The special int32 type uses heap memory, and thus 0l = 0l are two pointers pointing to different locations in the heap, thus it is false *)
