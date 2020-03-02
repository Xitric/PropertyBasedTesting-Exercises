(* Exercise 1 *)
module type DictSig = 
sig
    type key = string
    type value = int
    type dictionary (* Since we do not expose the type of dictionary, clients can only make them using the functions of this module *)
    val empty : dictionary
    val add : dictionary -> key -> value -> dictionary
    val find : dictionary -> key -> value
end

module Dict : DictSig = 
struct
    type key = string
    type value = int
    type dictionary = key -> value
    let empty key = 0
    let add dict key v =
        fun key' -> if key=key' then v else dict key'
    let find dict key = dict key
end
