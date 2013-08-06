
open Js
open Coord
open Delta
open Range

class type document = object
  method applyDeltas : delta t js_array t -> unit meth
  method getAllLines : js_string t js_array t meth
  method getLength : int meth
  method getLine : int -> js_string t meth
  method getLines : int -> int -> js_string t js_array t meth
  method getNewLineCharacter : js_string t meth
  method getNewLineMode : js_string t meth
  method getTextRange : range t -> js_string t meth
  method getValue : js_string t meth
  method indexToPosition : int -> int -> point t meth
  method insert : point t -> js_string t -> point t meth
  method insertInLine : point t -> js_string t -> point t meth
  method insertLines : int -> js_string t js_array t -> point t meth
  method insertNewLine : point t -> point t meth
  method isNewLine : js_string t -> bool t meth
  method on : js_string t -> ('a -> unit) -> unit meth
  method positionToIndex : point t -> int -> int meth
  method remove : range t -> point t meth
  method removeInLine : int -> int -> int -> point t meth
  method removeLines : int -> int -> js_string t js_array t meth
  method removeNewLine : int -> unit meth
  method replace : range t -> js_string t -> point t meth
  method revertDeltas : delta t js_array t -> unit meth
  method setNewLineMode : js_string t -> unit meth
  method setValue : js_string t -> unit meth
end
