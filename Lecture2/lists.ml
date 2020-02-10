(* A non-tail-recursive recursive sum function *)
let rec sum = function
    | [] -> 0
    | i::rest -> i + sum rest

(* A recursive member function that returns as soon as the value is found *)
let rec member list a = match list with
    | [] -> false
    | i::rest ->
        if i = a then
            true
        else
            member rest a
