open QCheck

(* Exercise 2, a *)
 let rec member xs y = match xs with
    | [] -> false
    | x::xs -> x=y || member xs y
(* This function should only require constant stack space and thus be tail-recursive. *)
(* This is because it can return directly without needing to unwrap the entire stack. *)
    (* This is called tail-call optimization. *)
(* Each recursive call does not rely on the local state of its caller. *)

(* Exercise 2, b *)
(* Create a list that should fail in a non-tail-recursive method: *)
let long_list = Gen.(generate1 (list_size (return 1_000_000) small_int));;

(* Running this indicates that the function is in fact tail-recursive because it goes well. *)
(* 45489745465 is just a number that is definitely not in the list that only includes small ints. *)
let _ = member long_list 45489745465

(* Exercise 2, c *)
(* Non-tail-recursive: *)
let rec fac n = match n with
    | 0 -> 1
    | _ -> n * fac (n-1)
(* Tail-recursive: *)
let fac_tail n = 
    let rec fac_tail_local n acc = match n with
        | 0 -> acc
        | _ -> fac_tail_local (n-1) (n * acc)
    in fac_tail_local n 1

(* Non-tail-recursive: *)
let rec reverse xs = match xs with
    | [] -> []
    | x::xs -> (reverse xs) @ [x]
(* Tail-recursive: *)
(* Can handle very long lists *)
let reverse_tail xs =
    let rec reverse_tail_local xs acc = match xs with
        | [] -> acc
        | x::xs -> reverse_tail_local xs ([x] @ acc)
    in reverse_tail_local xs []

(* For fun, tail-recursive function to find maximum value in list: *)
let max xs =
    let rec max_local xs m = match xs with
        | [] -> m
        | x::xs ->
            if x > m then
                max_local xs x
            else
                max_local xs m
    in max_local xs 0
