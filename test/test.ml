open QCheck

let add a b = a + b;;
let increment = add 1;;
print_string (string_of_int (increment 5) ^ "\n");;
