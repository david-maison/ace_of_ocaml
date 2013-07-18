
open Js

(* Create object Mode ? *)

(* TO BE DELETED *)
type rulesOBJ
type stateTokenOBJ
type stateAndTokenOBJ
type offsetOBJ
type coordOBJ
type undoOptionsOBJ
type searchOptions
type searchOptionsOBJ
type selectOBJ
type cursorOBJ
type anchorOBJ
type selectAnchorOBJ
type selectLeadOBJ
type markerOBJ
type markerResOBJ
type typeMarkerOBJ
type annotOBJ
type stateUnknownOBJ
type tokenOBJ
type tokenarrayOBJ
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

val pos_w : int -> int -> pos_w

class type pos_r = object
  method row : int readonly_prop
  method column : int readonly_prop
end

(* TO COMPLETE *)type tokenizerToken = Str of string | Arr of string array

type tokenizerState
val tokenizerState : string -> (tokenizerToken * string * string option ) list -> tokenizerState

type tokenizerRules
val tokenizerRules : tokenizerState list -> tokenizerRules t


(* TO COMPLETE (constr) *)class type tokenizer = object
  method getLineTokens : int -> stateTokenOBJ -> stateAndTokenOBJ meth (* A TEST line = int or string ? state = ? res = ? *)
end

(* TO COMPLETE (constr) *)class type tokenIterator = object
  method getCurrentToken : js_string t meth (* A TEST Res = string or token? *)
  method getCurrentTokenColumn : int meth
  method getCurrentTokenRow : int meth
  method stepBackward : js_string t meth 	(* A TEST *)
  method stepForward : js_string t meth		(* A TEST *)

end


(* TO COMPLETE (on() + constr)*)class type scrollBar = object
  method getWidth : int meth
  method onScroll : unit meth           (* A TEST (Undocumented)*)
  method setHeight : int -> unit meth
  method setInnerHeight : int -> unit meth
  method setScrollTop : int -> unit meth
end


(* TO TEST *) class type range = object
  method _end : pos_r t readonly_prop
  method start : pos_r t readonly_prop

  method clipRows : int -> int -> range t meth
  method clone : range t meth
  method collapseRows : range t meth
  method compare : int -> int -> int meth
  method compareEnd : int -> int -> int meth
  method compareInside : int -> int -> int meth
  method comparePoint : range t -> int meth (* A TEST range = point ? *)
  method compareRange : range t -> int meth
  method compareStart : int -> int -> int meth
  method contains : int -> int -> bool t meth
  method containsRange : range t -> bool t meth
  method extend : int -> int -> range t meth (* A TEST return new range or not? *)
  method fromPoints : range t -> range t -> range t meth (* A TEST range = point ? *)
  method inside : int -> int -> bool t meth
  method insideEnd : int -> int -> bool t meth
  method insideStart : int -> int -> bool t meth
  method intersects : range t -> bool t meth
  method isEmpty : unit meth            (* A TEST (Undocumented) *)
  method isEnd : int -> int -> bool t meth
  method isEqual : range t -> bool t meth
  method isMultiLine : bool t meth
  method isStart : int -> int -> bool t meth
  method setEnd : int -> int -> unit meth
  method setStart : int -> int -> unit meth
  method toScreenRange : editSession t -> range t meth (* A TEST effet = ? *)
  method toString : js_string t meth
end



(* TO COMPLETE constr *)and undoManager = object
  method execute : undoOptionsOBJ -> unit meth (* A TEST (voir doc) *)
  method hasRedo : bool t meth
  method hasUndo : bool t meth
  method redo : bool t -> unit meth     (* A TEST = res = unit ? *)
  method reset : unit meth
  method undo : bool t -> range t meth  (* A TEST = res = range ? *)
end


(* TO COMPLETE (on() + constr) *) and document = object
  method applyDeltas : deltasOBJ -> unit meth
  method createAnchor : int -> int -> unit meth (* A TEST Ret = unit or anchor *)
  method getAllLines : string_array t meth        (* A TEST comportement *)
  method getLength : int meth
  method getLine : int -> js_string t meth
  method getLines : int -> int -> string_array t meth (* A TEST comportement *)
  method getNewLineCharacter : js_string t meth
  method getNewLineMode : js_string t meth (* A TEST Res : enum or string ? *)
  method getTextRange : range t -> js_string t meth
  method getValue : js_string t meth
  method indexToPosition : int -> int -> pos_r t meth (* A VERIF *)
  method insert : pos_w t -> js_string t -> insertResOBJ meth (* A TEST *)
  method insertInLine : pos_w t -> js_string t -> insertResOBJ meth (* A TEST *)
  method insertLines : int -> string_array t -> insertResOBJ meth   (* A TEST array+res *)
  method insertNewLine : pos_w t -> insertResOBJ meth               (* A TEST *)
  method isNewLine : js_string t -> bool t meth
  method positionToIndex : pos_w t -> int -> int meth (* A TEST *)
  method remove : range t -> removeResOBJ meth        (* A TEST *)
  method removeInLine : int -> int -> int -> removeResOBJ meth (* A TEST *)
  method removeLines : int -> int -> js_string t meth          (* A TEST *)
  method removeNewLine : int -> removeResOBJ                   (* A TEST *)
  method replace : range t -> js_string t -> replaceResOBJ meth (* A TEST *)
  method revertDeltas : deltasOBJ -> unit meth                  (* A TEST *)
  method setNewLineMode : js_string t -> unit meth
  method setValue : js_string t -> unit meth
end

(* TO COMPLETE ( on() + constr) *) and editSession = object
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
  method getUndoManager : undoManager meth
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


(* TO COMPLETE (on() + constr)*)class type backgroundTokenizer = object
  method fireUpdateEvent : int -> int -> unit meth
  method getState : int -> stateTokenOBJ meth	(* A TEST Res *)
  method getTokens : int -> tokenOBJ js_array t meth (* A TEST Res *)
  method setDocument : document t -> unit meth
  method setTokenizer : tokenizer t -> unit meth
  method stop : unit meth
end

(* TO COMPLETE (constr + on()  *)class type anchor = object
  method detach : unit meth
  method getDocument : document t meth
  method getPosition : pos_r t meth     (* A TEST *)
  method onChange : unit meth           (* A TEST (Undocumented) *)
  method setPosition : int -> int -> bool t -> unit meth
end


(* TO COMPLETE constr *)class type search = object
  method find : editSession t -> range t meth
  method findAll : editSession t -> range t meth (* A TEST Res = range or array *)
  method getOptions : searchOptionsOBJ meth      (* A TEST *)
  method replace : js_string t -> js_string t -> js_string t (* A TEST Res = ? *)
  method set : searchOptionsOBJ meth                         (* A TEST *)
  method setOptions : unit meth                              (* A TEST (Undocumented) *)
end


class type orientedRange = object
  inherit range
  method cursor : pos_r t readonly_prop
  method marker : int readonly_prop
end


(* TO COMPLETE (on() and constr) *)class type selection = object
  method addRange : range t -> bool t -> unit meth (* A TEST *)
  method clearSelection : unit meth
  method detach : unit meth             (* A TEST (Undocumented) *)
  method fromOrientedRange : unit meth  (* A TEST (Undocumented) *)
  method getAllRanges : range t js_array t meth (* A TEST Res *)
  method getCursor : int meth           (* A TEST Res *)
  method getLineRange : unit meth       (* A TEST (Undocumented) *)
  method getRange : range t meth
  method getSelectionAnchor : selectAnchorOBJ meth (* A TEST *)
  method getSelectionLead : selectLeadOBJ meth     (* A TEST *)
  method getWordRange : int -> int -> unit meth    (* A TEST row and column = object ?? res = unit ?? *)
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
  method moveCursorShortWordLeft : unit meth (* A TEST (Undocumented) *)
  method moveCursorShortWordRight : unit meth (* A TEST (Undocumented) *)
  method moveCursorTo : int -> int -> bool t -> unit meth
  method moveCursorToPosition : pos_w t -> unit meth (* A TEST pos_w *)
  method moveCursorToScreen : int -> int -> bool t -> unit meth
  method moveCursorUp : unit meth
  method moveCursorWordLeft : unit meth (* A TEST (Undocumented) *)
  method moveCursorWordRight : unit meth (* A TEST (Undocumented) *)
  method rectangularRangeBlock : cursorOBJ -> anchorOBJ -> bool t -> range t meth (* A CHANGER *)
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
  method selectToPosition : pos_w t -> unit meth (* A TEST pos_w *)
  method selectUp : unit meth
  method selectWord : unit meth
  method selectWordLeft : unit meth
  method selectWordRight : unit meth
  method setSelectionAnchor : int -> int -> unit
  method setSelectionRange : range t -> bool t -> unit
  method shiftSelection : int -> unit meth
  method splitIntoLines : unit meth
  method substractPoint : range t -> unit meth (* A TEST range or point or pos ? *)
  method toggleBlockSelection : unit meth      (* A TEST (Undocumented) *)
  method toOrientedRange : unit meth (* A TEST (Undocumented) *)
  method toSingleRange : unit meth (* A TEST (Undocumented) *)
end


(* TO COMPLETE constr *)class type virtualRenderer = object
  method _loadTheme : unit meth  (* A TEST (Undocumented) *)
  method addGutterDecoration : int -> js_string t -> unit meth (* DEPRECATED *)
  method adjustWrapLimit : unit meth
  method alignCursor : unit meth  (* A TEST (Undocumented) *)
  method animateScrolling : unit meth  (* A TEST (Undocumented) *)
  method destroy : unit meth
  method getAnimatedScroll : bool t meth
  method getContainerElement : Dom.element t meth (* A TEST Dom.element *)
  method getDisplayIndentGuides : unit meth (* A TEST (Undocumented) *)
  method getFadeFoldWigdets : unit meth (* A TEST (Undocumented) *)
  method getFirstFullyVisibleRow : int meth
  method getFirstVisibleRow : int meth 
  method getHighlightGutterLine : unit meth (* A TEST (Undocumented) *)
  method getHScrollBarAlwaysVisible : bool t meth
  method getLastFullyVisibleRow : int meth
  method getLastVisibleRow : int meth
  method getMouseEventTarget : Dom.element t meth (* A TEST Dom.element *)
  method getPrintMarginColumn : bool t meth
  method getScrollBottomRow : int meth
  method getScrollLeft : int meth
  method getScrollTop : int meth
  method getScrollTopRow : int meth
  method getShowGutter : bool t meth
  method getShowInvisibles : bool t meth
  method getShowPrintMargin : bool t meth
  method getTextAreaContainer : Dom.element t meth (* A TEST Dom.element *)
  method getTheme : js_string t meth
  method hideComposition : unit meth
  method hideCursor : unit meth
  method isScrollableBy : int -> int -> bool t meth
  method onChangeTabSize : unit meth    (* A TEST (Undocumented) *)
  method onGutterResize : unit meth    (* A TEST (Undocumented) *)
  method onResize : bool t -> int -> int -> int -> unit meth
  method pixelToScreenCoordinates : unit meth    (* A TEST (Undocumented) *)
  method removeGutterDecoration : int -> js_string t -> unit meth (* DEPRECATED *)
  method screenToTextCoordinates : unit meth (* A TEST (Undocumented) *)
  method scrollBy : int -> int -> unit meth
  method scrollCursorIntoView : cursorOBJ -> offsetOBJ -> unit meth (* A TEST *)
  method scrollSelectionIntoView : unit meth (* A TEST (Undocumented) *)
  method scrollToLine: int -> bool t -> bool t -> callbackOBJ -> unit meth (* A TEST callback *)
  method scrollToRow : int -> unit meth
  method scrollToX : int -> int meth    (* A TEST Res = int ? *)
  method scrollToY : int -> int meth    (* A TEST Res = int ? *)
  method setAnimatedScroll : bool t -> unit meth
  method setAnnontations : annotOBJ js_array t -> unit meth (* A TEST *)
  method setCompositionText : js_string t -> unit meth (* A TEST (Undocumented) *)
  method setDisplayIndentGuides : unit meth (* A TEST (Undocumented) *)
  method setFadeFoldWidgets : unit meth (* A TEST (Undocumented) *)
  method setHighlightGutterLine : unit meth (* A TEST (Undocumented) *)
  method setHScrollBarAlwaysVisible : bool t -> unit meth
  method setPadding : int -> unit meth
  method setPrintMarginColumn : bool t -> unit meth
  method setSession : editSession t -> unit meth
  method setShowGutter : bool t -> unit meth
  method setShowInvisibles : bool t -> unit meth
  method setShowPrintMargin : bool t -> unit meth
  method setStyle : unit meth (* A TEST (Undocumented) *)
  method setTheme : js_string t -> unit meth
  method showCursor : unit meth
  method textToScreenCoordinates : int -> int -> coordOBJ meth
  method unsetStyle : js_string t -> unit meth
  method updateBackMarkers : unit meth
  method updateBreakpoints : int -> unit meth (* A TEST rows = obj ? array ? *)
  method updateCharacterSize : unit meth      (* A TEST (Undocumented) *)
  method updateCursor : unit meth
  method updateFontSize : unit meth
  method updateFrontMarkers : unit meth
  method updateFull : bool t -> unit meth
  method updateLines : int -> int -> unit meth
  method updateText : unit meth
  method visualizeBlur : unit meth
  method visualizeFocus : unit meth
end


(* TO COMPLETE (on()) + constr *)class type editor = object
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



(** CONSTRUCTORS **)
(* No need to call requires ?? *)

val anchor : (document t -> int -> int -> anchor t) constr
val backgroundTokenizer : (tokenizer t -> editor t -> backgroundTokenizer t) constr
(* TO COMPLETE (String|Array) *)val document : (js_string t -> document t) constr
(* TO COMPLETE (TextMode = Mode or String?) *)val editSession : (js_string t -> js_string t -> editSession t) constr
val editor : (virtualRenderer t -> editSession t -> editor t) constr
val range : (int -> int -> int -> int -> range t) constr
val scrollBar : (#Dom.element t -> scrollBar t) constr
val search : search t constr
val selection : (editSession t -> selection t) constr
(* REQUIRES RANGE *)val tokenIterator : (editSession t -> int -> int -> tokenIterator t) constr
(* TO COMPLETE : flags = enum ? *)val tokenizer : (tokenizerRules t -> js_string t -> tokenizer t) constr
val undoManager : undoManager t constr
val virtualRenderer : (#Dom.element t -> js_string t -> virtualRenderer t) constr


(** ACE MAIN'S FUNCTIONS **)

(* TO COMPLETE *) val edit : Dom.element t -> editor t (* A TEST Dom.element ? *)
(* TO COMPLETE *) val createEditSession : string -> string -> editSession t

(* WARNINGS !!! *)val require : string -> unit
