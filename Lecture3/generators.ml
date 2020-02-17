open QCheck

(* Exercise 3, a *)
(* A generator for generating both large and small ints, as well as corner cases such as -1, 0, 1, min_int, and max_int *)
(* The corner case generator is much less frequent because it has a much narrower output space *)
let corner_int = Gen.frequency [
    (10, int.gen);
    (10, small_signed_int.gen);
    (1, Gen.oneofl [
        -1; 0; 1; Int.min_int; Int.max_int
    ])
]

(* Try out with: *)
(* Gen.generate ~n:100 corner_int;; *)

(* Exercise 3, b *)
let corner_int_full = make ~stats:[("Value", fun i -> i)] corner_int
let corner_int_test = Test.make ~count:100000 ~name:"Corner int generator" corner_int_full (fun _ -> true)

let _ = QCheck_runner.run_tests ~verbose:true [
    corner_int_test
]
