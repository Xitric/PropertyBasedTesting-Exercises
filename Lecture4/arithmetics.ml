open QCheck

(* Used for exercise 4 *)
(* Type definition for an arithmetic expression such as *)
(*
    2 * x + 3 * 4
*)
type aexp =
    | X
    | Lit of int
    | Plus of aexp * aexp
    | Times of aexp * aexp

(* Calculate the value of the expression given a certain value of the variable *)
let rec interpret xval ae = match ae with
    | X -> xval
    | Lit i -> i
    | Plus (ae1, ae2) -> (interpret xval ae1) + (interpret xval ae2)
    | Times (ae1, ae2) -> (interpret xval ae1) * (interpret xval ae2)

(* Generate a string representation of the expression *)
let rec string_of_aexp ae = match ae with
    | X -> "x"
    | Lit i -> string_of_int i
    | Plus (ae1, ae2) -> "(" ^ string_of_aexp ae1 ^ " + " ^ string_of_aexp ae2 ^ ")"
    | Times (ae1, ae2) -> "(" ^ string_of_aexp ae1 ^ " * " ^ string_of_aexp ae2 ^ ")"

(* Generator for leaf elements *)
let leaf_gen = Gen.oneof [
    Gen.return X;
    Gen.map (fun i -> Lit i) int.gen
]

(* Generator for trees *)
let tree_gen = Gen.sized (Gen.fix (
    fun gen n -> match n with
        | 0 -> leaf_gen
        | n -> Gen.oneof [
            leaf_gen;
            Gen.map2 (fun l r -> Plus(l, r)) (gen (n/2)) (gen (n/2));
            Gen.map2 (fun l r -> Times(l, r)) (gen (n/2)) (gen (n/2))
        ]
))
let tree_gen_full = make tree_gen ~print:string_of_aexp
