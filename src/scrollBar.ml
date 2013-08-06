
open Js


class type scrollBar = object
  method getWidth : int meth
  method on : js_string t -> ('a -> unit) -> unit meth
  method onScroll : unit meth
  method setHeight : int -> unit meth
  method setInnerHeight : int -> unit meth
  method setScrollTop : int -> unit meth
end
