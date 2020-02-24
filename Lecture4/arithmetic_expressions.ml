open QCheck
open Arithmetics

(* Exercise 4, a *)
(* For all cases I would first try literal leaves, then variables, and lastly other trees. *)
(* For the literal leaves, I would further try edge cases such as -1, 0, and 0 before other numbers. *)
(* For internal nodes, I would try replacing entire subtrees with literals before shrinking recursively. *)

(* Exercise 4, b *)
(* Jan's shrinker *)
let (<+>) = Iter.(<+>)
let rec tshrink e = match e with
    | X -> Iter.empty
    | Lit i -> Iter.map (fun i' -> Lit i') (Shrink.int i)
    | Plus (ae0, ae1) ->
        (Iter.of_list [ae0; ae1])
        <+> (Iter.map (fun ae0' -> Plus (ae0',ae1)) (tshrink ae0))
        <+> (Iter.map (fun ae1' -> Plus (ae0,ae1')) (tshrink ae1))
    | Times (ae0, ae1) ->
        (Iter.of_list [ae0; ae1])
        <+> (Iter.map (fun ae0' -> Times (ae0',ae1)) (tshrink ae0))
        <+> (Iter.map (fun ae1' -> Times (ae0,ae1')) (tshrink ae1))

(* A more aggressive shrinker *)
let rec aggressive_shrink e =
    let base_iter = Iter.of_list [Lit (-1); Lit 0; Lit 1; Lit max_int; Lit min_int] in
    let base_iter_vars = base_iter <+> (Iter.return X) in
    match e with
        | X ->
            base_iter
            <+> Iter.empty
        | Lit (-1 | 0 | 1) ->
            Iter.map (fun i' -> Lit i') (Shrink.int 0)
        | Lit i ->
            base_iter_vars
            <+> (Iter.map (fun i' -> Lit i') (Shrink.int i))
        | Plus (left, right) ->
            base_iter_vars
            <+> (Iter.of_list [left; right])
            <+> (Iter.map (fun left' -> Plus (left',right)) (tshrink left))
            <+> (Iter.map (fun right' -> Plus (left,right')) (tshrink right))
        | Times (left, right) ->
            base_iter_vars
            <+> (Iter.of_list [left; right])
            <+> (Iter.map (fun left' -> Times (left',right)) (tshrink left))
            <+> (Iter.map (fun right' -> Times (left,right')) (tshrink right))

(* Evaluating them with three sample tests *)
let test_base1 = Test.make ~name:"Base 1"          (pair int (set_shrink tshrink tree_gen_full))                   (fun (xval, e) -> interpret xval e = xval)
let test_aggressive1 = Test.make ~name:"Aggr 1"    (pair int (set_shrink aggressive_shrink tree_gen_full))         (fun (xval, e) -> interpret xval e = xval)

let test_base2 = Test.make ~name:"Base 2"          (pair int (set_shrink tshrink tree_gen_full))                   (fun (xval, e) -> interpret xval (Plus(e,e)) = interpret xval e)
let test_aggressive2 = Test.make ~name:"Aggr 2"    (pair int (set_shrink aggressive_shrink tree_gen_full))         (fun (xval, e) -> interpret xval (Plus(e,e)) = interpret xval e)

let test_base3 = Test.make ~name:"Base 3"          (triple int int (set_shrink tshrink tree_gen_full))             (fun (xval, xval', e) -> interpret xval e = interpret xval' e)
let test_aggressive3 = Test.make ~name:"Aggr 3"    (triple int int (set_shrink aggressive_shrink tree_gen_full))   (fun (xval, xval', e) -> interpret xval e = interpret xval' e)

let _ = QCheck_runner.set_seed 74684763757486
let _ = QCheck_runner.run_tests [
    test_base1; test_aggressive1;
    test_base2; test_aggressive2;
    test_base3; test_aggressive3;
]

(* Aggressive shrinker seems faster for case 1, and generates simpler counter examples for case 2 *)
(* The biggest difference is that the aggressive shrinker actually attempts to shrink variables *)
