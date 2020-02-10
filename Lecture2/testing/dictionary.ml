let empty = []

(* TODO: Update existing vlaue on colliding keys *)
let add dict key value = (key, value) :: dict

let rec find dict key = match dict with
    | [] -> 0
    | (k, v) :: rest ->
        if k = key then
            v
        else
            find rest key
