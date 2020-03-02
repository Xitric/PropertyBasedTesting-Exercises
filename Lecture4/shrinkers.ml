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

(* Exercise 6, a *)
(* We iteratively try to cut the list in half, using the head and tail as smaller examples *)
(* After this, we can just try to cut away the front element of the list *)
(* Lastly, we can try to simplify the values inside the list *)

(* Exercise 6, b *)
let split_list l =
    let length = List.length l in
    let rec head l n =
        if n = 0 then
            []
        else match l with
            | [] -> []
            | a::rest -> a::(head rest (n-1)) in
    let rec tail l o n =
        if n = 0 then
            []
        else match l with
            | [] -> []
            | a::rest -> if o > 0 then tail rest (o-1) n
                        else a::(tail rest 0 (n-1)) in
    let head_count = length lsr 1 in
    (head l head_count, tail l head_count (length - head_count))

let my_list_shrinker l = match l with
    | [] -> Iter.empty (* No more elements *)
    | a::[] -> Iter.return [] (* Only one element left *)
    | _::rest -> let (head, tail) = split_list l in (* At least two elements left *)
        Iter.of_list [head; tail; rest]

let list_test_a = Test.make ~name:"List a" (set_shrink my_list_shrinker (list int)) (fun es -> List.rev es = es)
let list_test_b = Test.make ~name:"List b" (set_shrink my_list_shrinker (list int)) (fun es -> List.length es < 5)
let _ = QCheck_runner.run_tests [list_test_a; list_test_b]

(* The shrinker seems to find minimal lists in terms of their length, but it does not yet minimize the elements of the lists *)
