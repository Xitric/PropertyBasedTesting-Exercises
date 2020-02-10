open QCheck

(* Exercise 6 *)
(* i = Int64.to_int (Int64.of_int i) *)
(* I expect this to hold, since my operating system is 64-bit *)
let int_64_test = Test.make
    ~name:"Int 64 test"
    int
    (fun i -> i = Int64.to_int (Int64.of_int i))

(* i = Int32.to_int (Int32.of_int i) *)
(* I do not expect this to hold, since my operating system is 64-bit and thus I might lose some data *)
let int_32_test = Test.make
    ~name:"Int 32 test"
    int
    (fun i -> i = Int32.to_int (Int32.of_int i))

(* i = int_of_string (string_of_int i) *)
(* I expect this to hold *)
let string_test = Test.make
    ~name:"String test"
    int
    (fun i -> i = int_of_string (string_of_int i))

(* Running the tests verify my expectations *)
let _ = QCheck_runner.run_tests ~verbose:true [
    int_64_test;
    int_32_test;
    string_test
]
