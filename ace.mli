
open Js

type searchOptions
type tokenarray

(* TO BE DELETED *)
val searchOptionsTEST : searchOptions

class type pos_w = object
  method row : int writeonly_prop
  method column : int writeonly_prop
end

val pos_w : int -> int -> pos_w

class type pos_r = object
  method row : int readonly_prop
  method column : int readonly_prop
end

(* TO COMPLETE *) class type range = object
  method _end : pos_r t readonly_prop
  method start : pos_r t readonly_prop
end

val range : (int -> int -> int -> int -> range t) constr

(* TO COMPLETE *) class type orientedRange = object
  inherit range
  method cursor : pos_r t readonly_prop
  method marker : int readonly_prop
end

(* TO COMPLETE *) class type document = object
  method getLine : int -> js_string t meth
  method getLines : int -> int -> string_array t meth
  method getTextRange : range t -> js_string t meth
  method getValue : js_string t meth
  method replace : range t -> js_string t -> unit meth
  method setValue : js_string t -> unit meth
end

(* TO COMPLETE *) class type editSession = object
  method getDocument : document t meth
  method getTabSize : int meth
  (* method getTokens : int -> tokenarray *)
end

(* TO COMPLETE *) class type editor = object
  method addSelectionMarker : #range t -> orientedRange t meth
  method alignCursors : unit meth
  method blockOutdent : unit meth
  method blur : unit meth
  method centerSelection : unit meth
  method clearSelection : unit meth
  method copyLinesDown : int meth	(* A TEST *)
  method copyLinesUp : int meth	(* A TEST *)
  method destroy : unit meth
  method duplicateSelection : unit meth (* A TEST (Undocumented) *)
  method execCommand : unit meth	   (* A TEST (Undocumented) *)
  method exitMultiSelectMode : unit meth (* A TEST *)
  method find : js_string t opt -> searchOptions -> bool t -> range t meth (* SEARCHOPTIONS = ??? *)
  method findAll : js_string t -> searchOptions -> bool t -> int meth
  method findNext : searchOptions -> bool t -> unit meth
  method findPrevious : searchOptions -> bool t -> unit meth
  method focus : unit meth		(* A TEST *)
  method forEachSelection : js_string t -> js_string t -> unit meth
  method getAnimatedScroll : unit meth (* A TEST (Undocumented) *)
  method getBehavioursEnabled : bool t meth
  method getCopyText : js_string t meth
  method getCursorPosition : pos_r t meth (* A TEST *)
  method getCursorPositionScreen : int meth (* A TEST *)
  method getDisplayIndentGuides : unit meth (* A TEST (Undocumented) *)
  method getDragDelay : int meth	    (* A TEST (int or float) *)
  method getFadeFoldWidgets : unit meth	    (* A TEST (Undocumented) *)
  method getFirstVisibleRow : int meth
  method getHighlightActiveLine : bool t meth
  method getHighlightGutterLine : unit meth (* A TEST (Undocumented) *)
  method getHighlightSelectedWord : bool t meth
  method getKeyboardHandler : js_string t meth (* A TEST *)
  method getLastSearchOptions : searchOptions meth (* SEARCHOPTION ??? *)
  method getLastVisibleRow : int meth
  method getNumberAt : int -> int -> int meth (* A TEST (row & colum = object or int ? *)
  method getOverwrite : bool t meth
  method getPrintMarginColumn : int meth
  method getReadOnly : bool t meth
  method getScrollSpeed : int meth	(* A TEST (int or float) *)
  method getSelectionRange : range t meth
  method getSelectionStyle : js_string t meth
  method getSession : editSession t meth
  method getShowFoldWidgets : bool t meth
  method getShowInvisibles : bool t meth
  method getShowPrintMargin : bool t meth
  method getTheme : js_string t meth
  method getValue : js_string t meth
  method getWrapBehavioursEnabled : bool t meth (* A TEST *)
  method gotoLine : int -> int -> bool t -> unit meth
  method gotoPageDown : unit meth
  method gotoPageUp : unit meth
  method indent : unit meth
  method insert : js_string t meth -> unit meth
  method isFocused : bool t meth 	(* A TEST (doc parle de textInput) *)
  method isRowFullyVisible : int -> bool t meth
  method isRowVisible : int -> bool t meth
  method jumpToMatching : selectOBJ -> unit meth (* A TEST (selectOBJ) *)
  method modifyNumber : int -> unit meth
  method moveCursorTo : int -> int -> unit meth
  method moveCursorToPosition : pos_w -> unit meth


  method removeLines : unit meth
  method selectAll : unit meth
  method setReadOnly : bool t -> unit meth 
  method setSession : editSession t -> unit meth
  method setTheme : js_string t -> unit meth
  method setValue : js_string t -> unit meth
end

(* TO COMPLETE *) val edit : Dom_html.element t -> editor t
(* TO COMPLETE *) val createEditSession : string -> string -> editSession t

val require : string -> unit
