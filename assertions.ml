exception Assert_true of string
let assert_true = function
| true -> ()
| false -> raise (Assert_true "false is not true")

exception Assert_false of string
let assert_false = function
| true -> raise (Assert_false "true is not false")
| false -> ()

exception Assert_greater of string
let assert_greater v1 v2 =
  match (v1 > v2) with
  | true -> ()
  | false -> 
    raise (Assert_greater (Printf.sprintf
      "%s is not greater than %s"
      (Serializer.truncate v1)
      (Serializer.truncate v2)))

exception Assert_less of string
let assert_less v1 v2 = 
  match (v1 < v2) with
  | true -> ()
  | false -> 
    raise (Assert_less (Printf.sprintf
      "%s is not less than %s"
      (Serializer.truncate v1)
      (Serializer.truncate v2)))

exception Assert_equal of string
let assert_equal v1 v2 = 
  match (v1 = v2) with
  | true -> ()
  | false -> 
    raise (Assert_equal (Printf.sprintf 
      "%s is not equal to %s"
      (Serializer.truncate v1)
      (Serializer.truncate v2)))

exception Almost_equal of string
let almost_equal v1 v2 =
  let epsilon = 0.0001 in
  match (v1 -. v2 <= epsilon) with
  | true -> ()
  | false -> 
    raise (Almost_equal (Printf.sprintf
      "%s is not almost equal to %s"
      (Serializer.truncate v1)
      (Serializer.truncate v2)))

exception Assert_not_equal of string
let assert_not_equal v1 v2 = 
  match (v1 <> v2) with
  | true -> ()
  | false -> 
    raise (Assert_not_equal (Printf.sprintf 
      "%s is equal to %s"
      (Serializer.truncate v1)
      (Serializer.truncate v2)))

exception Assert_is of string
let assert_is v1 v2 =
  match (v1 == v2) with
  | true -> ()
  | false -> 
    raise (Assert_is (Printf.sprintf
      "%s is not identical to %s"
      (Serializer.truncate v1)
      (Serializer.truncate v2)))

exception Assert_is_not of string
let assert_is_not v1 v2 =
  match (v1 != v2) with
  | true -> ()
  | false -> 
    raise (Assert_is_not (Printf.sprintf 
      "%s is the same as %s"
      (Serializer.truncate v1)
      (Serializer.truncate v2)))

exception Assert_is_none of string
let assert_is_none = function
| None -> ()
| Some x -> 
  raise (Assert_is_none (Printf.sprintf
    "Some %s is not None"
    (Serializer.truncate x)))

exception Assert_is_not_none of string
let assert_is_not_none = function
| None -> raise (Assert_is_not_none "expected Something, got None")
| Some _ -> ()

exception Assert_raises of string
let assert_raises ex_opt f arg : unit = 
  let error_str = match ex_opt with  
    | None -> "Forcing expression did not raise an exception"
    | Some ex -> (Printf.sprintf "Forcing expression did not raise %s" (Printexc.to_string ex))
  in
  try 
    begin
      let _ = f arg in raise (Assert_raises error_str)
    end 
  with 
    | Assert_raises _ as e -> raise e
    | e when ex_opt = None -> ()
    | e when ex_opt = Some e -> ()
    | e -> raise (Assert_raises (Printf.sprintf 
      "Forcing the expression raised unexpected exception %s" (Printexc.to_string e)))

(* http://caml.inria.fr/pub/docs/oreilly-book/html/book-ora168.html *)
exception Timeout
let sigalrm_handler = Sys.Signal_handle (fun _ -> raise Timeout)
let timeout (time : int) (f : 'a -> 'b) (arg : 'a) =
   let old_behavior = Sys.signal Sys.sigalrm sigalrm_handler in
   let reset_sigalrm () = Sys.set_signal Sys.sigalrm old_behavior in
   ignore (Unix.alarm time) ;
   let res = f arg in reset_sigalrm () ; res
