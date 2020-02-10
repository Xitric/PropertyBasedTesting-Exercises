open QCheck

(* Exercise 5 *)
(* A recursive function that merges two sorted lists into a new sorted lists *)
let rec merge a b = match (a, b) with
    | (a, []) -> a
    | ([], b) -> b
    | (i::rest_a, j::rest_b) ->
        if i < j then
            i :: merge rest_a b
        else
            j :: merge a rest_b

(* Among many others, the following properties should hold *)
(* List.length (merge a b) = (List.length a) + (List.length b) *)
let length_test = Test.make
    ~name:"Length test"
    (pair (list int) (list int))
    (fun (a, b) -> List.length (merge a b) = (List.length a) + (List.length b))

(* (is_ordered a) && (is_ordered b) ==> is_ordered (merge a b) *)
let rec is_ordered = function
    | i::j::l -> i <= j && is_ordered (j::l)
    | _ -> true

let order_test = Test.make
    ~name:"Order test"
    (pair (list int) (list int))
    (fun (a, b) ->
        let a = List.sort compare a in
        let b = List.sort compare b in
        (is_ordered a) && (is_ordered b) ==> is_ordered (merge a b))

(* merge a [] = a *)
let b_empty_test = Test.make
    ~name:"Right empty test"
    (list int)
    (fun a -> merge a [] = a)

(* merge [] b = b *)
let a_empty_test = Test.make
    ~name:"Left empty test"
    (list int)
    (fun b -> merge [] b = b)

(* merge a b = merge b a *)
let commutative_test = Test.make
    ~name:"Commutative test"
    (pair (list int) (list int))
    (fun (a, b) -> merge a b = merge b a)

(* merge a b = List.sort (a @ b) *)
let simple_sort_test = Test.make
    ~name:"Simple sort test"
    (pair (list int) (list int))
    (fun (a, b) ->
        let a = List.sort compare a in
        let b = List.sort compare b in
        merge a b = List.sort compare (a @ b))

let _ = QCheck_runner.run_tests ~verbose:true [
    length_test;
    order_test;
    b_empty_test;
    a_empty_test;
    commutative_test;
    simple_sort_test
]
