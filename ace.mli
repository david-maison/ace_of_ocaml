
open Js

type searchOptions
type tokenarray
type selectOBJ

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


class type editor = object
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
  method find : js_string t opt -> searchOptions -> bool t -> range t meth (* SEARCHOPTIONS = ??? *) (* opt = default ? *)
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
  method moveLinesDown : int meth
  method moveLinesUp : int meth
  method moveText : unit meth (* A TEST (Undocumented) *)
  method navigateDown : int -> unit meth
  method navigateFileEnd : unit meth
  method navigateFileStart : unit meth
  method navigateLeft : int -> unit meth
  method navigateLineEnd : unit meth
  method navigateLineStart : unit meth
  method navigateRight : int -> unit meth
  method navigateTo : int -> int -> unit meth
  method navigateUp : int -> unit meth
  method navigateWordLeft : unit meth
  method navigateWordRight : unit meth
  method onBlur : unit meth  (* A TEST (Undocumented) *)
  method onChangeAnnotation : unit meth  (* A TEST (Undocumented) *)
  method onChangeBackMarker : unit meth  (* A TEST (Undocumented) *)
  method onChangeBreakpoint : unit meth  (* A TEST (Undocumented) *)
  method onChangeFold : unit meth  (* A TEST (Undocumented) *)
  method onChangeFrontMarker : unit meth  (* A TEST (Undocumented) *)
  method onChangeMode : unit meth  (* A TEST (Undocumented) *)
  method onChangeWrapLimit : unit meth  (* A TEST (Undocumented) *)
  method onChangeWrapMode : unit meth  (* A TEST (Undocumented) *)
  method onCommandKey : unit meth  (* A TEST (Undocumented) *)
  method onCompositionEnd : unit meth  (* A TEST (Undocumented) *)
  method onCompositionStart : unit meth  (* A TEST (Undocumented) *)
  method onCompositionUpdate : unit meth  (* A TEST (Undocumented) *)
  method onCopy : unit meth  (* A TEST *)
  method onCursorChange : unit meth  (* A TEST *)
  method onCut : unit meth  (* A TEST *)
  method onDocumentChange : unit meth  (* A TEST (Undocumented) *)
  method onFocus : unit meth  (* A TEST (Undocumented) *)
  method onPaste : js_string t -> unit meth  (* A TEST *)
  method onScrollLeftChange : unit meth  (* A TEST (Undocumented) *)
  method onScrollTopChange : unit meth  (* A TEST (Undocumented) *)
  method onSelectionChange : unit meth  (* A TEST (Undocumented) *)
  method onTextInput : unit meth  (* A TEST (Undocumented) *)
  method onTokenizerUpdate : unit meth  (* A TEST (Undocumented) *)
  method redo : unit meth
  method remove : js_string t -> unit meth (* A TEST (String dir?) *)
  method removeLines : unit meth
  method removeSelectionMarker : range t -> unit meth (* A TEST *)
  method removeToLineEnd : unit meth
  method removeToLineStart : unit meth
  method removeWordLeft : unit meth
  method removeWordRight : unit meth
  method replace : js_string t -> replaceOptions -> unit meth (* A TEST *)
  method replaceAll : js_string t -> replaceOptions -> unit meth (* A TEST *)
  method resize : bool t -> unit meth
  method revealRange : unit meth (* A TEST (Undocumented) *)
  method scrollPageDown : unit meth
  method scrollPageUp : unit meth
  method scrollToLine : int -> bool t -> bool t -> callback -> unit meth (* A TEST (callback !) *)
  method scrollToRow : int -> unit meth (* A TEST (doc : Object row?) *)
  method selectAll : unit meth
  method selectMore : int -> bool t -> unit meth (* A TEST : doc : Number dir *)
  method selectMoreLines : int -> bool t -> unit meth (* A TEST : idem *)
  method selectPageDown : unit meth
  method selectPageUp : unit meth
  method setAnimatedScroll : unit meth (* A TEST (Undocumented) *)
  method setBehavioursEnabled : bool t -> unit meth
  method setDisplayIndentGuides : unit meth (* A TEST (Undocumented) *)
  method setDragDelay : int -> unit meth    (* A TEST : int or float *)
  method setFadeFoldWidgets : unit meth (* A TEST (Undocumented) *)
  method setFontSize : int -> unit meth
  method setHighlightActiveLine : bool t -> unit meth
  method setHighlightGutterLine : unit meth (* A TEST (Undocumented) *)
  method setHighlightSelectedWord : bool t -> unit meth
  method setKeyboardHandler : js_string t -> unit meth (* A TEST : keyboardHandler = ? *)
  method setOverwrite : bool t -> unit meth
  method setPrintMarginColumn : int -> unit meth
  method setReadOnly : bool t -> unit meth 
  method setScrollSpeed : int -> unit meth (* A TEST : int or float *)
  method setSelectionStyle : js_string t -> unit meth (* A TEST : style = ?? enum  or class css ? *)
  method setSession : editSession t -> unit meth
  method setShowFoldWidgets : bool t -> unit meth
  method setShowInvisibles : bool t -> unit meth
  method setShowPrintMargin : bool t -> unit meth
  method setStyle : js_string t -> unit meth (* A TEST : style = ?? enum or class css ? *)
  method setTheme : js_string t -> unit meth
  method setValue : js_string t -> cursorPos -> unit meth (* A TEST : doc : return String ? *) (* cursorPos : optionnel/default ? *)
  method setWrapBehavioursEnabled : bool t -> unit meth
  method sortLines : unit meth (* A TEST (Undocumented) *)
  method splitLine : unit meth
  method toggleCommentLines : unit meth
  method toggleOverwrite : unit meth
  method toLowerCase : unit meth
  method toUpperCase : unit meth
  method transposeLetters : unit meth
  method transposeSelections : int -> unit meth (* A TEST : doc : Number dir *)
  method undo : unit meth
  method unsetStyle : style -> unit meth (* A TEST : Object style ? *)
  method updateSelectionMarkers : unit meth
end

(* TO COMPLETE *) val edit : Dom_html.element t -> editor t
(* TO COMPLETE *) val createEditSession : string -> string -> editSession t

val require : string -> unit
