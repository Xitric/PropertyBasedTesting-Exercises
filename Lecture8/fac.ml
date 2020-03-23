let rec fac n = match n with
    | 0 -> 1
    | n -> n * fac (n - 1)
;;

(* This call will only result in 75% coverage, because the second pattern match is not invoked *)
(* Printf.printf "%i\n" (fac 0) *)

(* This results in 100% coverage *)
Printf.printf "%i\n" (fac 5)
