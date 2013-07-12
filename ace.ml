
open Js

(* TO BE DELETED *)
type searchOptions
type selectOBJ
type markerOBJ
type markerResOBJ
type typeMarkerOBJ
type annotOBJ
type stateUnknownOBJ
type tokenOBJ
type tokenarrayOBJ
type undoManagerOBJ
type limitOBJ
type insertResOBJ
type toPositionOBJ
type objectEOBJ
type deltaOBJ
type removeResOBJ
type replaceResOBJ
type posResOBJ
type scrollLeftOBJ
type scrollTopIBJ
type undoManager
type deltasOBJ
type replaceOptions
type callbackOBJ
type cursorPos
type style
(* END TO BE DELETED *)

class type pos_w = object
  method row : int writeonly_prop
  method column : int writeonly_prop
end

let pos_w row column =
  Unsafe.obj [| "row", Unsafe.inject row ;
		"column", Unsafe.inject column |]

class type pos_r = object
  method row : int readonly_prop
  method column : int readonly_prop
end


(* TO COMPLETE *) class type range = object
  method _end : pos_r t readonly_prop
  method start : pos_r t readonly_prop
end

let range = Unsafe.variable "ace.require(\"./range\").Range"

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

(* TO COMPLETE ( on() + constr) *) class type editSession = object
  method addDynamicMarker : markerOBJ -> bool t -> markerResOBJ (* A TEST *)
  method addGutterDecoration : int -> js_string t -> unit meth
  method addMarker : range t -> js_string t -> typeMarkerOBJ -> bool t -> int meth (* A TEST *)
  method clearAnnotations : unit meth
  method clearBreakpoint : int -> unit meth
  method clearBreakpoints : unit meth
  method documentToScreenColumn : int -> int -> int meth (* A TEST *)
  method documentToScreenPosition : int -> int -> pos_r t meth (* A TEST *)
  method documentToScreenRow : int -> int -> int meth  (* A TEST *)
  method duplicateLines : int -> int -> int meth       (* A TEST *)
  method getAnnotations : annotOBJ meth		       (* A TEST *)
  method getAWordRange : int -> int -> range t meth
  method getBreakpoints : int js_array t meth (* A TEST *)
  method getDocument : document t meth
  method getDocumentLastRowColumn : int -> int -> int meth (* A TEST *)
  method getDocumentLastRowColumnPosition : int -> int -> pos_r t meth (* A TEST *)
  method getLength : int meth
  method getLine : int -> js_string t meth
  method getLines : int -> int -> string_array t meth
  method getMarkers : bool t -> markerOBJ js_array meth (* A TEST *)
  method getMode : js_string t meth			(* A TEST *)
  method getNewLineMode : js_string t meth
  method getOverwrite : bool t meth
  method getRowLength : int -> int meth
  method getRowSplitData : int -> js_string t meth (* A TEST (object row et res ? *)
  method getScreenLastRowColumn : int -> int meth  (* A TEST : int or pos? *)
  method getScreenLength : int meth
  method getScreenTabSize : int -> int meth
  method getScreenWidth : int meth
  method getScrollLeft : int meth
  method getScrollTop : int meth
  method getSelection : js_string t meth
  method getState : int -> stateUnknownOBJ meth (* A TEST *)
  method getTabSize : int meth
  method getTabString : js_string t meth (* A TEST *)
  method getTextRange : range t -> js_string t meth
  method getTokenAt : int -> int -> tokenOBJ meth (* A TEST *)
  method getTokens : int -> tokenarrayOBJ meth	  (* A TEST *)
  method getUndoManager : undoManagerOBJ meth	  (* A TEST *)
  method getUseSoftTabs : bool t meth
  method getUseWorker : bool t meth
  method getUseWrapMode : bool t meth
  method getValue : js_string t meth
  method getWordRange : int -> int -> range t meth
  method getWrapLimit : int meth
  method getWrapLimitRange : limitOBJ meth (* A TEST { min: wrapLimitRange_min, max: wrapLimitRange_max } *)
  method highlight : unit meth (* A TEST (Undocumented) *)
  method highlightLines : unit meth (* A TEST (Undocumented) *)
  method indentRows : int -> int -> js_string t -> unit meth
  method insert : pos_w t -> js_string t -> insertResOBJ meth (* A TEST *)
  method isTabStop : pos_w t -> bool t meth		      (* A TEST *)
  method moveLinesDown : int -> int -> int meth		      (* A TEST *)
  method moveLinesUp : int -> int -> int meth		      (* A TEST *)
  method moveText : range t -> toPositionOBJ -> range t meth  (* A TEST *)
  method onChange : unit meth (* A TEST (Undocumented) *)
  method onChangeFold : unit meth (* A TEST (Undocumented) *)
  method onReloadTokenizer : objectEOBJ -> unit meth (* A TEST *)
  method outdentRows : range t -> unit meth
  method redo : unit meth (* A TEST (Undocumented) *)
  method redoChanges : deltaOBJ js_array t -> bool t -> range t meth (* A TEST *)
  method remove : range t -> removeResOBJ meth (* A TEST *)
  method removeGutterDecoration : int -> js_string t -> unit meth
  method removeMarker : int -> unit 	(* A TEST : markerId *)
  method replace : range t -> js_string t -> replaceResOBJ meth (* A TEST *)
  method reset : unit meth (* A TEST (Undocumented) *)
  method resetCaches : unit meth (* A TEST (Undocumented) *)
  method screenToDocumentColumn : unit meth (* A TEST (Undocumented) *)
  method screenToDocumentPosition : int -> int -> posResOBJ meth (* A TEST *)
  method screenToDocumentRow : unit meth (* A TEST (Undocumented) *)
  method setAnnotations : annotOBJ js_array t -> unit meth (* A TEST *)
  method setBreakpoint : int -> js_string t -> unit meth
  method setBreakpoints : int js_array t -> unit meth
  method setDocument : document t -> unit meth
  method setMode : unit meth (* A TEST (Undocumented) *)
  method setNewLineMode : js_string t -> unit meth
  method setOverwrite : bool t -> unit meth
  method setScrollLeft : scrollLeftOBJ -> unit meth (* A TEST *)
  method setScrollTop : scrollTopIBJ -> unit meth   (* A TEST *)
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
  method undo : unit meth (* A TEST (Undocumented) *)
  method undoChanges : deltasOBJ -> bool t -> range t meth (* A TEST *)
end

(* TO COMPLETE (on())  + constr*)class type editor = object
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
  method scrollToLine : int -> bool t -> bool t -> callbackOBJ -> unit meth (* A TEST (callback !) *)
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



let edit el = 
  Unsafe.fun_call
    (Unsafe.variable "ace.edit") [| Unsafe.inject el |]

let createEditSession text mode =
  Unsafe.fun_call
    (Unsafe.variable "ace.createEditSession")
    [| Unsafe.inject (string text) ;
       Unsafe.inject (string mode) |]


(*  WARNING
    Ace's object are in native code, so in objects's constructor,
    we have to do ace.requires("./obj").Obj again to construct the object
*)
let require moduleName =
  let arg = Format.sprintf "require(\"ace/%s\").%s"
    (String.uncapitalize moduleName) moduleName in
  let _module = Unsafe.variable arg in
  Unsafe.set Dom_html.window (Unsafe.variable moduleName) _module
  
