(* Exercise 3, a *)
(* Properties for List.map: *)
    (* Different paths: *)
        (* Applying two maps in different orders should produce the same result *)
        (* Multiplying by two (map) and then summing should be the same as summing and then multiplying by two *)
    (* There and back: *)
        (* Mapping in one way and then reversing it should arrive at the outset *)
    (* Invariance: *)
        (* The length is unchanged *)
        (* The sort order is unchanged if we apply certain operations to each element *)
    (* Idempotence: *)
        (* Two sign maps should be the same as one *)
    (* Smaller problem: *)
        (* If map works for small lists, it probably also works for larger lists *)
    (* Easy to verify: *)
        (* Adding 1 to each element should increase the sum by the length of the list *)
    (* Test oracle: *)
        (* We can create our own map function and compare outputs *)
    (* Related input/output: *)
        (* The identity map should not change the list *)
        (* Mapping by adding each number to itself should give the same result as multiplying each value by two *)

(* Properties independent of map function: *)
    (* Different paths: *)
        (* Mapping two lists and appending them is the same as appending the and mapping the combined list *)
    (* There and back: *)
        (* ??? *)
    (* Invariance: *)
        (* The length is unchanged *)
    (* Idempotence: *)
        (* ??? *)
    (* Smaller problem: *)
        (* If map works for small lists, it probably also works for larger lists *)
    (* Easy to verify: *)
        (* ??? *)
    (* Test oracle: *)
        (* We can create our own map function and compare outputs *)
    (* Related input/output: *)
        (* Mapping two lists where only one element differs should result in equal lists with the exception of the first element *)
            (* Reasoning: The individual values do not influence each other *)

(* Exercise 3, b *)
open QCheck

(* Mapping two lists and appending them is the same as appending the and mapping the combined list *)
let paths_test = Test.make
    ~name:"Different paths, same destination"
    ~count:10000
    (triple
        (list int)
        (list int)
        (fun1 Observable.int int))
    (fun (a, b, func) -> let f = Fn.apply func in
        (List.map f a) @ (List.map f b) = List.map f (a @ b))

(* The length is unchanged *)
let invariance_test = Test.make
    ~name:"Some things never change"
    ~count:10000
    (pair
        (list int)
        (fun1 Observable.int int))
    (fun (a, func) -> let f = Fn.apply func in
        List.length (List.map f a) = List.length a)

(* Mapping two lists where only one element differs should result in equal lists with the exception of the first element *)
let related_test = Test.make
    ~name:"Related inputs lead to related outputs"
    ~count:10000
    (triple
        int
        (list int)
        (fun1 Observable.int int))
    (fun (n, a, func) -> let f = Fn.apply func in
        List.map f a =
        match List.map f (n::a) with
            | _::b -> b
            | b -> b)

let _ = QCheck_runner.run_tests ~verbose:true [
    paths_test;
    invariance_test;
    related_test
]
