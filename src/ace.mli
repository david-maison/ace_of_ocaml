
open Js
open Anchor
open BackgroundTokenizer
open Coord
open Delta
open Document
open Editor
open EditSession
open Mode
open Range
open ScrollBar
open Search
open Selection
open Tokenizer
open TokenIterator
open UndoManager
open VirtualRenderer


(* TODO : Object CommandManager (editor.commands) *)


(* UNSAFE *)
class type matchingBraceOutdent = object
  (* method autoOutdent : document t -> int -> unit meth *)
  (* method checkOutdent : js_string t -> js_string t -> bool t meth *)
end
(* END UNSAFE *)


(** CONSTRUCTORS **)

val anchor : (document t -> int -> int -> anchor t) constr
val backgroundTokenizer : (tokenizer t -> editor t -> backgroundTokenizer t) constr
(* TO COMPLETE (String|Array) *)
val document : (js_string t -> document t) constr

(* TO COMPLETE (String|Mode) ?*)
val editSession : (js_string t -> js_string t -> editSession t) constr

val editor : (virtualRenderer t -> editSession t -> editor t) constr
val matchingBraceOutdent : matchingBraceOutdent t constr
val range : (int -> int -> int -> int -> range t) constr
val scrollBar : (#Dom.element t -> scrollBar t) constr
val search : search t constr
val selection : (editSession t -> selection t) constr
(* REQUIRES RANGE *)val tokenIterator : (editSession t -> int -> int -> tokenIterator t) constr
(* TO COMPLETE : flags = enum ? *)val tokenizer : (tokenizerRules t -> js_string t -> tokenizer t) constr
val undoManager : undoManager t constr
val virtualRenderer : (#Dom.element t -> js_string t -> virtualRenderer t) constr



(** OTHER CONSTRUCTORS **)
val mode : tokenizer t -> matchingBraceOutdent t optdef -> mode t
val point : int -> int -> point t
val rangeFromPoints : point t -> point t -> range t
val searchOptions : ?backwards:bool t -> ?caseSensitive:bool t -> ?needle:js_string t -> ?range:range t -> ?regExp:bool t -> ?skipCurrent:bool t -> ?start:point t -> ?wholeWord:bool t -> ?wrap:bool t -> searchOptions t
val undoExecuteOptions : delta_array t -> editSession t -> undoExecuteOptions t
val delta : js_string t -> range t -> js_string t optdef -> js_string t optdef -> js_string t js_array t optdef -> delta t
val delta_array : delta t js_array t -> js_string t -> delta_array t 


(** ACE MAIN'S FUNCTIONS **)

(* TO COMPLETE *) val edit : #Dom.element t -> editor t
(* TO COMPLETE *) val createEditSession : js_string t -> js_string t -> editSession t

(* WARNINGS !!! *)val require : string -> unit

