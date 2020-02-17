(* Exercise 5 *)
let my_int_of_string str = try Some (int_of_string str) with
    | Failure _ -> None

(* Exercise 6 *)
let my_list_find filter list = match List.find_opt filter list with
    | Some v -> v
    | None -> raise Not_found
