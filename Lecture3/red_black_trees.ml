(* Leaf color *)
type color =
    | Red
    | Black

(* Red-black tree *)
type 'a rbtree =
    | Leaf
    | Node of color * 'a * 'a rbtree * 'a rbtree

(*  empty : 'a set  *)
let empty = Leaf

(*  mem : 'a -> 'a set -> bool  *)
let rec mem x s = match s with
    | Leaf -> false
    | Node (_, y, left, right) ->
        x = y || (x < y && mem x left) || (x > y && mem x right)

(*  balance : color * 'a * ('a tree) * ('a tree) -> 'a tree  *)
let balance t = match t with
    | Black, z, Node(Red, y, Node(Red,x,a,b), c), d
    | Black, z, Node(Red, x, a, Node(Red,y,b,c)), d
    | Black, x, a, Node(Red, z, Node(Red,y,b,c), d)
    | Black, x, a, Node(Red, y, b, Node(Red,z,c,d)) ->
        Node(Red, y, Node(Black,x,a,b), Node(Black,z,c,d))
    | color, x, a, b -> Node(color,x,a,b)

(*  insert : 'a -> 'a set -> 'a set  *)
let insert x s =
    let rec ins s = match s with
        | Leaf -> Node (Red, x, Leaf, Leaf)
        | Node (color,y,a,b) -> if x < y then balance (color, y, ins a, b)
                                else if x > y then balance (color, y, a, ins b)
                                else s (* x = y *)
    in match ins s with (* guaranteed to be non-empty *)
        | Node (_,y,a,b) -> Node (Black, y, a, b)
        | Leaf -> raise (Invalid_argument "insert: cannot color empty tree")

(*  set_of_list : 'a list -> 'a set  *)
let rec set_of_list = function
    | [] -> empty
    | x :: l -> insert x (set_of_list l)

(* Exercise 7, a *)
(* Invariant 1: No red node has a red parent *)
let rec invariant_1 tree parent_color =
    match tree with
        | Leaf -> true
        | Node (color, _, l, r) ->
            (parent_color = Black || color = Black) && (invariant_1 l color) && (invariant_1 r color)

(* Exercise 7, b *)
(* Invariant 2: Every path from the root to an empty node contains the same number of black nodes *)
let invariant_2 tree =
    let rec invariant_2_rec tree = match tree with
        | Leaf -> (1, true)
        | Node (color, _, l, r) ->
            let (lb, l_inv) = invariant_2_rec l in
            let (rb, r_inv) = invariant_2_rec r in
            let satisfied = lb = rb && l_inv && r_inv in
            if color = Red then (lb, satisfied)
            else (lb + 1, satisfied)
    in let (_, satisfied) = invariant_2_rec tree in satisfied

(* Exercise 7, c *)
open QCheck

(* Generate random red-black trees *)
let tree_gen = Gen.map (fun elements -> set_of_list elements) (list small_signed_int).gen
(* This one will fail both invariants: *)
(* let tree_gen = Gen.return (Node(Black, 0, Node(Red, 0, Node(Red, 0, Leaf, Leaf), Leaf), Node(Black, 0, Leaf, Leaf))) *)
let tree_gen_full = make tree_gen

let red_black_test_1 = Test.make
    ~name:"Invariant 1"
    ~count:50
    tree_gen_full
    (fun tree -> invariant_1 tree Black)

let red_black_test_2 = Test.make
    ~name:"Invariant 2"
    ~count:50
    tree_gen_full
    (fun tree -> invariant_2 tree)

let _ = QCheck_runner.run_tests ~verbose:true [
    red_black_test_1;
    red_black_test_2
]
