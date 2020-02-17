(* Exercise 9 *)
let empty k = 0

(* We represent our dictionary as a function, that can fall back on a previous dictionary function, etc. until we reach the base case *)
let add d k v =
    fun k' ->
        if k = k' then
            v
        else
            d k'

let find d k = d k
