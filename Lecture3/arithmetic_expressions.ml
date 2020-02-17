open QCheck

(* Exercise 1, a *)
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

let rec size ae = match ae with
    | (X | Lit _) -> 1
    | (Plus (ae1, ae2) | Times (ae1, ae2)) -> size ae1 + size ae2

(* A test expression to make life easier *)
let exp = Plus(Plus(Times(Lit 5, X), Plus(Lit 2, Lit 1)), Times(X, Lit 8))

(* Exercise 1, b *)
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

(* Test for observing tree sizes *)
let tree_gen_full = make ~stats:[("size", size)] tree_gen
let tree_size_test = Test.make ~count:1000 ~name:"Size stat" tree_gen_full (fun _ -> true)

let _ = QCheck_runner.run_tests ~verbose:true [
    tree_size_test
]

(* Exercise 2, a *)
(* Four simple instructions in a custom language for evaluating arithmetic expressions *)
type instruction =
    | Load
    | Push of int
    | Add
    | Mult

(* Convert an arithmetic expression into code in our custom language defined above *)
let rec compile ae = match ae with
    | X -> [Load]
    | Lit i -> [Push i]
    | Plus (ae1, ae2) -> (compile ae1) @ (compile ae2) @ [Add]
    | Times (ae1, ae2) -> (compile ae1) @ (compile ae2) @ [Mult]

(* A function for executing programs in our custom language to calculate the value of arithmetic expressions *)
(* The value of the variable X is initially stored in the register *)
(* At the end, the result will be on the top of the stack *)
exception Runtime_exception of string
let rec run register instructions stack = match instructions with
    | instr::rest -> (match instr with
        | Load -> run register rest (register::stack)
        | Push i -> run register rest (i::stack)
        | Add -> (match stack with
            | a::b::st -> run register rest ((a + b)::st)
            | _ -> raise (Runtime_exception "Not enough numbers on stack for Add"))
        | Mult -> (match stack with
            | a::b::st -> run register rest ((a * b)::st)
            | _ -> raise (Runtime_exception "Not enough numbers on stack for Mult")))
    | [] -> (match stack with
        | a::_ -> a
        | _ -> raise (Runtime_exception "Stack empty on program end"))

(* For instance, the expression below will return 29: *)
(* run 2 (compile exp) [] *)

(* Exercise 2, b *)
let compile_test = Test.make
    ~name:"Compile test"
    ~count:1000
    (pair small_signed_int tree_gen_full)
    (fun (xval, tree) -> run xval (compile tree) [] = interpret xval tree)

let _ = QCheck_runner.run_tests ~verbose:true [
    compile_test
]

(* Exercise 2, c + d *)
(* Skipped, trivial *)
