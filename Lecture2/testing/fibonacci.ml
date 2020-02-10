open QCheck

(* Exercise 8 *)
(* The traditional, recursive formulation (terrible) *)
let rec fib_textbook = function
    | (0 | 1) as i -> i
    | i -> fib_textbook (i - 1) + fib_textbook (i - 2)

(* An iterative, bottom-up, linear-time algorithm (better) *)
let rec fib_bottom_up i =
    if i = 0 then
        0
    else let rec fib one_behind two_behind n =
        if n > i then one_behind else
        fib (one_behind + two_behind) one_behind (n + 1) in
    fib 1 0 2

(* A sub-linear algorithm (best) *)
(* Not going to happen *)

(* Comparing them for agreement using small positive numbers *)
(* WANRING: Extremely slow 20+ minutes *)
let fib_test = Test.make
    ~name:"Fibonacci test"
    ~count:10
    small_nat
    (fun i -> fib_textbook i = fib_bottom_up i)

let _ = QCheck_runner.run_tests ~verbose:true [
    fib_test
]
