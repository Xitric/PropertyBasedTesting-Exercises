open QCheck

(* Exercise 4 *)
let dice_gen = Gen.map2 (fun a b -> a + b + 2) (Gen.int_bound 5) (Gen.int_bound 5)

let dice_gen_full = make ~stats:[("Value", fun i -> i)] dice_gen
let dice_gen_test = Test.make ~count:100000 ~name:"Dice generator" dice_gen_full (fun _ -> true)

let _ = QCheck_runner.run_tests ~verbose:true [
    dice_gen_test
]
