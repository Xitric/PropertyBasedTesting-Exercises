(* Exercise 3 *)
(* A non-tail-recursive recursive sum function *)
let rec sum = function
    | [] -> 0
    | i::rest -> i + sum rest

(* A recursive member function that returns as soon as the value is found *)
let rec member list a = match list with
    | [] -> false
    | i::rest ->
        if i = a then
            true
        else
            member rest a


(* Exercise 4 *)
open QCheck

(* Property based test that tests the property *)
(* sum (list1 @ list2) = (sum list1) + (sum list2) *)
(* Generate a pair of random int lists, and test the property *)
let sum_test = Test.make
    ~name:"Sum test"
    ~count:100
    (pair (list int) (list int))
    (fun (a, b) -> sum (a @ b) = (sum a) + (sum b))

let _ = QCheck_runner.run_tests ~verbose:true [sum_test]
