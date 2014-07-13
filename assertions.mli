exception Assert_true of string
val assert_true : bool -> unit

exception Assert_false of string
val assert_false : bool -> unit

exception Assert_greater of string
val assert_greater : 'a -> 'a -> unit

exception Assert_less of string
val assert_less : 'a -> 'a -> unit

exception Assert_equal of string
val assert_equal : ('a -> 'a -> bool) -> 'a -> 'a -> unit
val (===) : 'a -> 'a -> unit

exception Almost_equal of string
val almost_equal : float -> float -> unit

exception Assert_not_equal of string
val assert_not_equal : 'a -> 'a -> unit

exception Assert_is of string
val assert_is : 'a -> 'a -> unit

exception Assert_is_not of string
val assert_is_not : 'a -> 'a -> unit

exception Assert_is_none of string
val assert_is_none : 'a option -> unit

exception Assert_is_not_none of string
val assert_is_not_none : 'a option -> unit

exception Assert_raises of string
(** [assert_raises e_opt f x] returns [unit] if [f x] raises
 * the exception within [e_opt], or any exception if [e_opt] is [None] *)
val assert_raises : exn option -> ('a -> 'b) -> 'a -> unit

exception Timeout
(** [timeout i f x] executes [f x], terminating in at most [i]
 * seconds. Raises [Timeout] if [f x] was killed early. *)
val timeout : int -> ('a -> 'b) -> 'a -> 'b
