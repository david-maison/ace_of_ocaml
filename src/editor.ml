
open Js
open Coord
open EditSession
open Search
open Range


(* TODO *)
class type hashHandler = object end

(* TO COMPLETE AND TEST *)
class type commandManager = object end


(* A TEST *)
class type editor = object
  method addSelectionMarker : range t -> range t meth
  method alignCursors : unit meth
  method blockOutdent : unit meth
  method blur : unit meth
  method centerSelection : unit meth
  method clearSelection : unit meth
  method copyLinesDown : unit meth
  method copyLinesUp : unit meth
  method destroy : unit meth
  method duplicateSelection : unit meth
  method execCommand : js_string t -> 'a -> unit meth (*js_string OR command t*)
  method exitMultiSelectMode : unit meth
  method find : js_string t -> searchOptions t opt -> bool t opt -> range t meth
  method findAll : js_string t -> searchOptions t opt -> bool t opt -> int meth
  method findNext : searchOptions t opt -> bool t opt -> unit meth
  method findPrevious : searchOptions t opt -> bool t opt -> unit meth
  method focus : unit meth
  method forEachSelection : js_string t -> js_string t -> unit meth
  method getAnimatedScroll : bool t meth
  method getBehavioursEnabled : bool t meth
  method getCopyText : js_string t meth
  method getCursorPosition : point t meth
  method getCursorPositionScreen : point t meth
  method getDisplayIndentGuides : bool t meth
  method getDragDelay : int meth
  method getFadeFoldWidgets : bool t meth
  method getFirstVisibleRow : int meth
  method getHighlightActiveLine : bool t meth
  method getHighlightGutterLine : bool t meth 
  method getHighlightSelectedWord : bool t meth
  method getKeyboardHandler : hashHandler t meth
  method getLastSearchOptions : searchOptions t meth
  method getLastVisibleRow : int meth
  method getNumberAt : int -> int -> numberLocated t opt meth
  method getOverwrite : bool t meth
  method getPrintMarginColumn : int meth
  method getReadOnly : bool t meth
  method getScrollSpeed : int meth
  method getSelectionRange : range t meth
  method getSelectionStyle : js_string t meth
  method getSession : editSession t meth
  method getShowFoldWidgets : bool t meth
  method getShowInvisibles : bool t meth
  method getShowPrintMargin : bool t meth
  method getTheme : js_string t meth
  method getValue : js_string t meth
  method getWrapBehavioursEnabled : bool t meth
  method gotoLine : int -> int -> bool t -> unit meth
  method gotoPageDown : unit meth
  method gotoPageUp : unit meth
  method indent : unit meth
  method insert : js_string t meth -> unit meth
  method isFocused : bool t meth
  method isRowFullyVisible : int -> bool t meth
  method isRowVisible : int -> bool t meth
  method jumpToMatching : bool t -> unit meth
  method modifyNumber : int -> unit meth
  method moveCursorTo : int -> int -> unit meth
  method moveCursorToPosition : point t -> unit meth
  method moveLinesDown : int meth
  method moveLinesUp : int meth
  method moveText : range t -> point t -> bool t -> range t meth
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
  method on : js_string t -> ('a -> unit) -> unit meth
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
  method onCopy : (unit -> unit) prop
  method onCursorChange : (unit -> unit) prop
  method onCut : (unit -> unit) prop
  method onDocumentChange : unit meth  (* A TEST (Undocumented) *)
  method onFocus : unit meth  (* A TEST (Undocumented) *)
  method onPaste : (js_string t -> unit) prop
  method onScrollLeftChange : unit meth  (* A TEST (Undocumented) *)
  method onScrollTopChange : unit meth  (* A TEST (Undocumented) *)
  method onSelectionChange : unit meth  (* A TEST (Undocumented) *)
  method onTextInput : unit meth  (* A TEST (Undocumented) *)
  method onTokenizerUpdate : unit meth  (* A TEST (Undocumented) *)
  method redo : unit meth
  method remove : js_string t -> unit meth
  method removeLines : unit meth
  method removeSelectionMarker : range t -> unit meth 
  method removeToLineEnd : unit meth
  method removeToLineStart : unit meth
  method removeWordLeft : unit meth
  method removeWordRight : unit meth
  method replace : js_string t -> searchOptions t opt -> int meth
  method replaceAll : js_string t -> searchOptions t opt -> int meth
  method resize : bool t -> unit meth
  method revealRange : range t -> bool t -> unit meth
  method scrollPageDown : unit meth
  method scrollPageUp : unit meth
  method scrollToLine : int -> bool t -> bool t -> (unit -> unit) -> unit meth
  method scrollToRow : int -> unit meth
  method selectAll : unit meth
  method selectMore : int -> bool t -> unit meth
  method selectMoreLines : int -> bool t -> unit meth
  method selectPageDown : unit meth
  method selectPageUp : unit meth
  method setAnimatedScroll : bool t -> unit meth
  method setBehavioursEnabled : bool t -> unit meth
  method setDisplayIndentGuides : bool t -> unit meth 
  method setDragDelay : int -> unit meth
  method setFadeFoldWidgets : bool t -> unit meth
  method setFontSize : int -> unit meth
  method setHighlightActiveLine : bool t -> unit meth
  method setHighlightGutterLine : bool t -> unit meth
  method setHighlightSelectedWord : bool t -> unit meth
  method setKeyboardHandler : hashHandler t -> unit meth
  method setOverwrite : bool t -> unit meth
  method setPrintMarginColumn : int -> unit meth
  method setReadOnly : bool t -> unit meth 
  method setScrollSpeed : int -> unit meth
  method setSelectionStyle : js_string t -> unit meth
  method setSession : editSession t -> unit meth
  method setShowFoldWidgets : bool t -> unit meth
  method setShowInvisibles : bool t -> unit meth
  method setShowPrintMargin : bool t -> unit meth
  method setStyle : js_string t -> unit meth 
  method setTheme : js_string t -> unit meth
  method setValue : js_string t -> int opt -> unit meth
  method setWrapBehavioursEnabled : bool t -> unit meth
  method sortLines : unit meth
  method splitLine : unit meth
  method toggleCommentLines : unit meth
  method toggleOverwrite : unit meth
  method toLowerCase : unit meth
  method toUpperCase : unit meth
  method transposeLetters : unit meth
  method transposeSelections : int -> unit meth
  method undo : unit meth
  method unsetStyle : js_string t -> unit meth
  method updateSelectionMarkers : unit meth
end
