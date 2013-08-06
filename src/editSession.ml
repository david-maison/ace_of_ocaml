
open Js
open Annotation
open Coord
open Delta
open Document
open Event
open Marker
open Mode
open Range
open Selection
open Tokenizer
open UndoManager

(* TO BE DELETED *)
type objectEOBJ
(* END TO BE DELETED *)

(* A TEST *) 
class type editSession = object
  method addDynamicMarker : marker t -> bool t -> marker t meth (* MARKER A TEST *)
  method addGutterDecoration : int -> js_string t -> unit meth
  method addMarker : range t -> js_string t -> typeMarker -> bool t -> int meth (* TYPEMARKER A TEST (d'apres highlightLines typeMarker = js_string t *)
  method clearAnnotations : unit meth
  method clearBreakpoint : int -> unit meth
  method clearBreakpoints : unit meth
  method documentToScreenColumn : int -> int -> int meth
  method documentToScreenPosition : int -> int -> point t meth
  method documentToScreenRow : int -> int -> int meth
  method duplicateLines : int -> int -> int meth
  method getAnnotations : annotation t js_array t meth (* UNSAFE *)
  method getAWordRange : int -> int -> range t meth
  method getBreakpoints : int js_array t meth
  method getDocument : document t meth
  method getDocumentLastRowColumn : int -> int -> int meth
  method getDocumentLastRowColumnPosition : int -> int -> point t meth
  method getLength : int meth
  method getLine : int -> js_string t meth
  method getLines : int -> int -> string_array t meth
  method getMarkers : bool t -> marker t optdef js_array t meth (* UNSAFE : Return an object with field "1" "2" ... like an array with offset 1 to n (0 = undefined, length = undefined) *)
  method getMode : mode t meth
  method getNewLineMode : js_string t meth
  method getOverwrite : bool t meth
  method getRowLength : int -> int meth
  method getRowSplitData : int -> js_string t js_array t optdef meth (* A TEST *)
  method getScreenLastRowColumn : int -> int meth
  method getScreenLength : int meth
  method getScreenTabSize : int -> int meth
  method getScreenWidth : int meth
  method getScrollLeft : int meth
  method getScrollTop : int meth
  method getSelection : selection t meth
  method getState : int -> js_string t meth
  method getTabSize : int meth
  method getTabString : js_string t meth
  method getTextRange : range t -> js_string t meth
  method getTokenAt : int -> int -> token t meth
  method getTokens : int -> token t js_array t meth
  method getUndoManager : undoManager meth
  method getUseSoftTabs : bool t meth
  method getUseWorker : bool t meth
  method getUseWrapMode : bool t meth
  method getValue : js_string t meth
  method getWordRange : int -> int -> range t meth
  method getWrapLimit : int meth
  method getWrapLimitRange : limit t meth
  method highlight : unit meth (* A TEST (Undocumented) *)(* $searchHighlight  = addDynamicMarker ! *)
  method highlightLines : int -> int -> js_string t opt -> bool t -> range t meth
  method indentRows : int -> int -> js_string t -> unit meth
  method insert : point t -> js_string t -> point t meth
  method isTabStop : point t -> bool t meth
  method moveLinesDown : int -> int -> int meth
  method moveLinesUp : int -> int -> int meth
  method moveText : range t -> point t -> bool t -> range t meth
  method on : js_string t -> ('a -> unit) -> unit meth
  method onChange : (delta t event t -> unit) prop
  method onChangeFold : (range t event t -> unit ) prop 
  method onReloadTokenizer : objectEOBJ -> unit meth (* A TEST *)
  method outdentRows : range t -> unit meth
  method redoChanges : delta t js_array t -> bool t -> range t meth
  method remove : range t -> point t meth
  method removeGutterDecoration : int -> js_string t -> unit meth
  method removeMarker : int -> unit meth
  method replace : range t -> js_string t -> point t meth
  method resetCaches : unit meth
  method screenToDocumentColumn : int -> int -> int meth
  method screenToDocumentPosition : int -> int -> point t meth
  method screenToDocumentRow : int -> int -> int meth
  method setAnnotations : annotation t js_array t -> unit meth (* UNSAFE *)
  method setBreakpoint : int -> js_string t -> unit meth
  method setBreakpoints : int js_array t -> unit meth
  method setDocument : document t -> unit meth
  method setMode : mode t -> unit meth
  method setNewLineMode : js_string t -> unit meth
  method setOverwrite : bool t -> unit meth
  method setScrollLeft : int -> unit meth
  method setScrollTop : int -> unit meth
  method setTabSize : int -> unit meth
  method setUndoManager : undoManager t -> unit meth
  method setUndoSelect : bool t -> unit meth
  method setUseSoftTabs : bool t -> unit meth
  method setUseWorker : bool t -> unit meth
  method setUseWrapMode : bool t -> unit meth
  method setValue : js_string t -> unit meth
  method setWrapLimitRange : int -> int -> unit meth
  method toggleOverwrite : unit meth
  method toString : js_string t meth
  method undoChanges : delta t js_array t -> bool t -> range t meth
end
