(* Exercise 2, a *)
open QCheck

let myshr = function
    | 0 -> Iter.empty
    | i -> Iter.return (i/2)

let ta = Test.make (set_shrink myshr int) (fun i -> false)
let _ = QCheck_runner.run_tests [ta]

(* Exercise 2, b *)
open QCheck

(* First we cut i in half to quickly get smaller values. Once we are close, we experiment with smaller random values *)
let (<+>) = Iter.(<+>)
let myshr_rand = function
    | 0 -> Iter.empty
    | i -> (Iter.return (i/2)) <+> (Iter.of_list (Gen.generate1 (Gen.list_size (Gen.return 1000) (Gen.int_bound (i - 1)))))

let tb = Test.make (set_shrink myshr_rand int) (fun i -> i < 432)
let _ = QCheck_runner.run_tests [tb]

(* Exercise 3 *)
(* This always reaches the same counter example (0,1) *)
(* I assume that it first reduces the left value, and eventually bottoms out at the smallest possible value 0 *)
(* Then it reduces the right value, which now bottoms out at 1 since (0,0) is not a counter example *)
let pair_test = Test.make (pair small_nat small_nat) (fun (i,j) -> i+j = 0);;
QCheck_runner.run_tests ~verbose:true [pair_test];;
