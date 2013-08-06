
open Js
open Coord
open Anchor
open Range

class type selection = object
  method addRange : range t -> bool t -> unit meth (* UNSAFE can fail *)
  method clearSelection : unit meth
  method detach : unit meth
  method fromOrientedRange : range t -> unit meth
  method getAllRanges : range t js_array t meth (* UNSAFE can fail *)
  method getCursor : point t meth
  method getLineRange : int -> bool t -> range t meth 
  method getRange : range t meth
  method getSelectionAnchor : point t meth
  method getSelectionLead : point t meth
  method getWordRange : int -> int -> range t meth
  method isBackwards : bool t meth
  method isEmpty : bool t meth
  method isMultiLine : bool t meth
  method mergeOverlappingRanges : unit meth
  method moveCursorBy : int -> int -> unit meth
  method moveCursorDown : unit meth
  method moveCursorFileEnd : unit meth
  method moveCursorFileStart : unit meth
  method moveCursorLeft : unit meth
  method moveCursorLineEnd : unit meth
  method moveCursorLineStart : unit meth
  method moveCursorLongWordLeft : unit meth
  method moveCursorLongWordRight : unit meth
  method moveCursorRight : unit meth
  method moveCursorShortWordLeft : unit meth
  method moveCursorShortWordRight : unit meth
  method moveCursorTo : int -> int -> bool t -> unit meth
  method moveCursorToPosition : point t -> unit meth
  method moveCursorToScreen : int -> int -> bool t -> unit meth
  method moveCursorUp : unit meth
  method moveCursorWordLeft : unit meth
  method moveCursorWordRight : unit meth
  method on : js_string t -> ('a -> unit) -> unit meth
  method rectangularRangeBlock : point t -> anchor t -> bool t -> range t js_array t meth
  method selectAll : unit meth
  method selectAWord : unit meth
  method selectDown : unit meth
  method selectFileEnd : unit meth
  method selectFileStart : unit meth
  method selectLeft : unit meth
  method selectLine : unit meth
  method selectLineEnd : unit meth
  method selectLineStart : unit meth
  method selectRight : unit meth
  method selectTo : int -> int -> unit meth
  method selectToPosition : point t -> unit meth
  method selectUp : unit meth
  method selectWord : unit meth
  method selectWordLeft : unit meth
  method selectWordRight : unit meth
  method setSelectionAnchor : int -> int -> unit
  method setSelectionRange : range t -> bool t -> unit
  method shiftSelection : int -> unit meth
  method splitIntoLines : unit meth
  method substractPoint : point t -> unit meth
  method toggleBlockSelection : unit meth
  method toOrientedRange : range t -> range t meth
  method toSingleRange : range t -> unit meth
end
