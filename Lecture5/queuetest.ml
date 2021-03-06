open QCheck

(* Exercise 4 *)
(* The test fails when we push 98 and then call the length function *)

(* This code requires the opam package qcstm:
      opam install qcstm

   To run it in utop/toplevel: 
     #require "qcheck";; 
     #require "qcstm";;
*)
module QConf =
struct
  type state = int list
  type sut = int Queue.t
  type cmd =
    | Pop (* may throw exception *)
    | Top (* may throw exception *)
    | Push of int
    | Length [@@deriving show { with_path = false }]

  let gen_cmd s =
    let int_gen = Gen.small_nat in
    if s = []
    then Gen.oneof (* don't generate pop/tops from empty *)
           [Gen.map (fun i -> Push i) int_gen;
           Gen.return Length]
    else Gen.oneof
           [Gen.return Pop;
            Gen.return Top;
            Gen.map (fun i -> Push i) int_gen;
            Gen.return Length]

  let arb_cmd s = QCheck.make ~print:show_cmd (gen_cmd s)

  let init_state = []
  let next_state c s = match c with
    | Pop ->
      (match s with
        | []    -> []
        | _::s' -> s')
    | (Top | Length) -> s
    | Push i -> (*s@[i]*)
      if i<>98 then s@[i] else s  (* an artificial fault in the model *)

  let init_sut () = Queue.create ()
  let cleanup _   = ()
  let run_cmd c s q = match c with
    | Pop -> (try Queue.pop q = List.hd s with _ -> false)
    | Top -> (try Queue.top q = List.hd s with _ -> false)
    | Push n -> Queue.push n q; true
    | Length -> Queue.length q = List.length s

  let precond c s = match c with
    | Pop    -> s<>[]
    | Top    -> s<>[]
    | (Push _ | Length) -> true
end

module QT = QCSTM.Make(QConf)
;;
QCheck_runner.run_tests ~verbose:true
  [QT.consistency_test ~count:10_000 ~name:"queue gen-precond agreement";
   QT.agree_test       ~count:10_000 ~name:"queue-model agreement"]
