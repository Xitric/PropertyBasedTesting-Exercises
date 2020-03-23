open QCheck

type aexp =
  | X
  | Lit of int
  | Plus of aexp * aexp
  | Times of aexp * aexp [@@deriving show]

let rec interpret xval ae = match ae with
  | X -> xval
  | Lit i -> i
  | Plus (ae0, ae1) ->
    let v0 = interpret xval ae0 in
    let v1 = interpret xval ae1 in
    v0 + v1
  | Times (ae0, ae1) ->
    let v0 = interpret xval ae0 in
    let v1 = interpret xval ae1 in
    v0 * v1

(* There's a problem in the following.
   Can you spot it?
   Otherwise the coverage report will reveal it... *)

(* The generator never generates variables. *)
(* This is seen in the coverage report of only 96% *)

let leafgen = Gen.map (fun i -> Lit i) Gen.int
let mygen =
  Gen.sized (Gen.fix (fun recgen n -> match n with
    | 0 -> leafgen
    | n ->
      Gen.oneof
	[leafgen;
        (* Uncomment this line to fix the generator and achieve 100% coverage *)
        (* Gen.return X; *)
         Gen.map2 (fun l r -> Plus(l,r)) (recgen(n/2)) (recgen(n/2));
         Gen.map2 (fun l r -> Times(l,r)) (recgen(n/2)) (recgen(n/2))]))
let arb_tree = make ~print:show_aexp mygen

let test_interpret =
  Test.make ~name:"test interpret"
    (triple small_int arb_tree arb_tree)
    (fun (xval,e0,e1) -> interpret xval (Plus(e0,e1))
                         = interpret xval (Plus(e1,e0)))
;;
QCheck_runner.run_tests ~verbose:true [test_interpret]

(* Coverage results are available for me at *)
(* file://wsl%24/Ubuntu//home/xitric/ocaml-projects/Lecture8/coverage/index.html *)
