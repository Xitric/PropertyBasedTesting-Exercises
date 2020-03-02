(* Exercise 1 *)
module H1 =
struct
type cmd =
    | Add of string * int
    | Remove of string
    | Find of string
    | Mem of string [@@deriving show]
end

module H2 =
struct
type cmd =
    | Add of string * int
    | Remove of string
    | Find of string
    | Mem of string [@@deriving show { with_path = false }]
end

(* The first *)
(* H1.show_cmd : H1.cmd -> string *)
(* Returns string = "(Derivers.H1.Find \"Hey\")" *)

(* The second *)
(* H2.show_cmd : H2.cmd -> string *)
(* Returns string = "(Find \"Hey\")" *)
(* So the second option does not show the nested module names but only the raw type names *)
