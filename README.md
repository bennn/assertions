assertions
==========

Simple assertions library for OCaml.

Assertions are unary or binary operations that return unit on success and raise an exception on failure.
Each assertion defines a custom exception; for example `assert_is_none` will raise an exception `Assert_is_none` on failure.
Where possible, the assertions will try to print their argument values using the `dump` function from `BatPervasives` (included in `serializer.ml`).


API
---

- `assert_true : bool -> unit`
- `assert_false : bool -> unit`
- `assert_greater : 'a -> 'a -> unit`
- `assert_less : 'a -> 'a -> unit`
- `assert_equal : ('a -> 'a -> bool) -> 'a -> 'a -> unit`
- `(===) : 'a -> 'a -> unit`
- `almost_equal : ?epsilon:float -> float -> float -> unit`
- `assert_not_equal : 'a -> 'a -> unit`
- `assert_is : 'a -> 'a -> unit`
- `assert_is_not : 'a -> 'a -> unit`
- `assert_is_none : 'a option -> unit`
- `assert_is_not_none : 'a option -> unit`
- `assert_raises : exn option -> ('a -> 'b) -> 'a -> unit`
- `timeout : int -> ('a -> 'b) -> 'a -> 'b`

Notes:
- `assert_greater` and `assert_less` are defined using the built-in `(>)` and `(<)` functions
- `(===)` is just `assert_equal (=)`
- `almost_equal` uses a hard-coded floating point tolerance
- `assert_raises None` will catch any exception
- To call `assert_raises` on a function of more than one argument, use partial application (i.e. `assert_raises None (List.filter (fun x -> failwith "error")) []`). Alternatively, wrap the entire computation in a thunk.
- `timeout` is an assertion by itself, but is often useful combined with `(===)` or `assert_raises`.


Install
-------

Via OPAM:
```
opam install assertions
```




