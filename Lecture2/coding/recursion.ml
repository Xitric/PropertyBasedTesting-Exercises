(* Exercise 1 *)
(* A tail-recursive function using an accumulator *)
(* Using optionals so that we do not need to pass the accumulator the first time we call the function *)
let rec msb_acc ?(n=0) x = if x = 0 then
        n
    else
        msb_acc ~n:(n + 1) (x lsr 1)

(* A non-tail-recursive function that simply accumulates the value as the call stack unwraps *)
let rec msb x = if x = 0 then
        0
    else
        msb (x lsr 1) + 1
