open QCheck

(* Exercise 7 *)
let rec euclid_gcd a b =
    if b = 0 then
        a
    else if a > b then
        euclid_gcd (a - b) b
    else
        euclid_gcd a (b - a)

let rec hickey_gcd a b =
    let r = a mod b in
    if r = 0 then
        b
    else
        hickey_gcd b r

(* We now perform a comparison with Hickey's algorithm as the oracle and ours as an alternative *)
(* The algorithms are only defined for positive integers a and b *)
let gcd_test = Test.make
    ~name:"GCD test"
    (pair pos_int pos_int)
    (fun (a, b) -> hickey_gcd a b = euclid_gcd a b)

let _ = QCheck_runner.run_tests ~verbose:true [
    gcd_test
]
