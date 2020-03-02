(* Exercise 5 *)
(* Creating an imperative queue *)
module Queue : sig
    type queue
    type value = int
    
    val create : unit -> queue (* Very important to take unit as a parameter. Otherwise the same reference cell is reused! *)
    val pop : queue -> int
    val top : queue -> int
    val push : int -> queue -> unit
    val string_of_queue : queue -> string
end = struct
    type queue = (int list * int list) ref
    type value = int

    exception Empty of string

    let create () = ref ([], []) (* A new reference cell with a pair tuple of empty lists *)

    let rec pop q = match !q with
        | ([], []) ->
            raise (Empty "Popping empty queue")
        | ([], back) ->
            q := (List.rev back, []);
            pop q
        | (v::front, back) ->
            q := (front, back);
            v
    
    let rec top q = match !q with
        | ([], []) ->
            raise (Empty "Top of empty queue")
        | ([], back) ->
            q := (List.rev back, []);
            top q
        | (v::_, _) ->
            v
    
    let push v q = match !q with
        | (front, back) ->
            q := (front, v::back) (* This already returns unit *)
    
    let string_of_queue q = match !q with
        | (front, back) ->
            let realQueue = front @ (List.rev back) in
            "[" ^ (String.concat ", " (List.map string_of_int realQueue)) ^ "]"
end

(* Testing it *)
open QCheck

module QConf =
struct
  type state = int list
  type sut = Queue.queue (* This was all I had to change for this exercise *)
  type cmd =
    | Pop (* may throw exception *)
    | Top (* may throw exception *)
    | Push of int [@@deriving show { with_path = false }]

  let gen_cmd s =
    let int_gen = Gen.small_nat in
    if s = []
    then Gen.map (fun i -> Push i) int_gen (* don't generate pop/tops from empty *)
    else Gen.oneof
           [Gen.return Pop;
            Gen.return Top;
            Gen.map (fun i -> Push i) int_gen]

  let arb_cmd s = QCheck.make ~print:show_cmd (gen_cmd s)

  let init_state = []
  let next_state c s = match c with
    | Pop ->
      (match s with
        | []    -> []
        | _::s' -> s')
    | Top -> s
    | Push i -> s@[i]

  let init_sut () = Queue.create ()
  let cleanup _   = ()
  let run_cmd c s q = match c with
    | Pop -> (try Queue.pop q = List.hd s with _ -> false)
    | Top -> (try Queue.top q = List.hd s with _ -> false)
    | Push n -> Queue.push n q; true

  let precond c s = match c with
    | Pop    -> s<>[]
    | Top    -> s<>[]
    | Push _ -> true
end

module QT = QCSTM.Make(QConf)
;;
QCheck_runner.run_tests ~verbose:true
  [QT.consistency_test ~count:10_000 ~name:"queue gen-precond agreement";
   QT.agree_test       ~count:10_000 ~name:"queue-model agreement"]
