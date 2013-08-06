
open Js
open Coord
open Document
open Delta
open Event
open Range


class type anchor = object
  method detach : unit meth
  method getDocument : document t meth
  method getPosition : point t meth
  method on : js_string t -> ('a -> unit) -> unit meth
  method onChange : delta t event t -> unit meth
  method setPosition : int -> int -> bool t -> unit meth
end
