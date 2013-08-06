
open Js
open Coord

class type range = object
  method _end : point t readonly_prop
  method start : point t readonly_prop
  method id : int optdef readonly_prop
  method cursor : point t optdef readonly_prop
  method marker : int optdef readonly_prop

  method clipRows : int -> int -> range t meth
  method clone : range t meth
  method collapseRows : range t meth
  method compare : int -> int -> int meth
  method compareEnd : int -> int -> int meth
  method compareInside : int -> int -> int meth
  method comparePoint : point t -> int meth
  method compareRange : range t -> int meth
  method compareStart : int -> int -> int meth
  method contains : int -> int -> bool t meth
  method containsRange : range t -> bool t meth
  method extend : int -> int -> range t meth
  method inside : int -> int -> bool t meth
  method insideEnd : int -> int -> bool t meth
  method insideStart : int -> int -> bool t meth
  method intersects : range t -> bool t meth
  method isEmpty : bool t meth
  method isEnd : int -> int -> bool t meth
  method isEqual : range t -> bool t meth
  method isMultiLine : bool t meth
  method isStart : int -> int -> bool t meth
  method setEnd : int -> int -> unit meth
  method setStart : int -> int -> unit meth
  method toString : js_string t meth
end
