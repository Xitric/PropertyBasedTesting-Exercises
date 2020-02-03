(* Exercise 5 *)
let cube a = a * a * a;;
print_endline "Cube:";;
Printf.printf "%d\n" (cube 2);;
Printf.printf "%d\n" (cube 3);;

let is_even a =
    if a mod 2 = 0 then
        true
    else
        false;;
print_endline "\nEven:";;
Printf.printf "%b\n" (is_even 3);;
Printf.printf "%b\n" (is_even 4);;

let quadroot a = sqrt (sqrt a);;
print_endline "\nQuadratic root:";;
Printf.printf "%f\n" (quadroot 16.0);;
Printf.printf "%f\n" (quadroot 4.0);;
