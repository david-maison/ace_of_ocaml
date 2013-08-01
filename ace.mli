
open Js

(* Create object Mode ? *)
(* For method on("blur", function()) for example
     -> do method addEventBlur(function()) *)

(* TO BE DELETED *)
type stateTokenOBJ
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
type typeMarkerOBJ
type stateUnknownOBJ
type limitOBJ
type insertResOBJ
type toPositionOBJ
type objectEOBJ
type scrollLeftOBJ
type scrollTopIBJ
type replaceOptions
type callbackOBJ
type cursorPos
type style
(* END TO BE DELETED *)


(* UNSAFE *)
type typeMarker
val typeMarker_of_string : js_string t -> typeMarker
val typeMarker_of_function : ('a -> 'b) -> typeMarker
(* END UNSAFE *)

(* UNSAFE *)
class type annotation = object
end
(* END UNSAFE *)

class type ['a] event = object
  method data : 'a readonly_prop
end

val event : 'a -> 'a event t

class type point = object
  method row : int readonly_prop
  method column : int readonly_prop
end


(* TO COMPLETE *)type tokenizerToken = Str of string | Arr of string array

type tokenizerState
val tokenizerState : string -> (tokenizerToken * string * string option ) list -> tokenizerState

type tokenizerRules
(* WARNING : Need a "start" rule *)
val tokenizerRules : tokenizerState list -> tokenizerRules t

class type token = object
  method _type : js_string t readonly_prop
  method value : js_string t readonly_prop 
  method index : int optdef readonly_prop
  method start : int optdef readonly_prop
end

class type tokensInfo = object
  method state : js_string t readonly_prop
  method tokens : token t js_array t readonly_prop
end


class type tokenizer = object
  method getLineTokens : js_string t -> js_string t -> tokensInfo t meth
end

class type tokenIterator = object
  method getCurrentToken : token t optdef meth
  method getCurrentTokenColumn : int meth
  method getCurrentTokenRow : int meth
  method stepBackward : token t opt meth
  method stepForward : token t opt meth
end


class type scrollBar = object
  method getWidth : int meth
  method on : js_string t -> ('a -> unit) -> unit meth
  method onScroll : unit meth
  method setHeight : int -> unit meth
  method setInnerHeight : int -> unit meth
  method setScrollTop : int -> unit meth
end


type undoExecuteOptions


class type delta = object
  method action : js_string t readonly_prop
  method lines : js_string t js_array t optdef readonly_prop
  method nl : js_string t optdef readonly_prop
  method range : range t readonly_prop
  method text : js_string t optdef readonly_prop
end

and delta_array = object
  method deltas : delta t js_array t readonly_prop
  method group : js_string t readonly_prop
end

and anchor = object
  method detach : unit meth
  method getDocument : document t meth
  method getPosition : point t meth
  method on : js_string t -> ('a -> unit) -> unit meth
  method onChange : delta t event t -> unit meth
  method setPosition : int -> int -> bool t -> unit meth
end


and range = object
  method _end : point t readonly_prop
  method start : point t readonly_prop

  method clipRows : int -> int -> range t meth
  method clone : range t meth
  method collapseRows : range t meth
  method compare : int -> int -> int meth
  method compareEnd : int -> int -> int meth
  method compareInside : int -> int -> int meth
  method comparePoint : point t -> int meth
  method compareRange : range t -> int meth
  method compareStart : int -> int -> int meth
  method contains : int -> int -> bool t meth
  method containsRange : range t -> bool t meth
  method extend : int -> int -> range t meth
  method inside : int -> int -> bool t meth
  method insideEnd : int -> int -> bool t meth
  method insideStart : int -> int -> bool t meth
  method intersects : range t -> bool t meth
  method isEmpty : bool t meth
  method isEnd : int -> int -> bool t meth
  method isEqual : range t -> bool t meth
  method isMultiLine : bool t meth
  method isStart : int -> int -> bool t meth
  method setEnd : int -> int -> unit meth
  method setStart : int -> int -> unit meth
  method toScreenRange : editSession t -> range t meth
  method toString : js_string t meth
end


(* SO CLOUDY (to do : constr) *)and marker = object
  (* method cache : ??? js_array t optdef readonly_prop *) (* ??? *)
  method clazz : js_string t readonly_prop
  method id : int readonly_prop
  method inFront : bool t readonly_prop
  method range : range t optdef readonly_prop
  method regExp : js_string t optdef readonly_prop
  (* method renderer : ??? opt optdef readonly_prop *) (* ??? *)
  method _type : typeMarker readonly_prop
end

and undoManager = object
  (* method dirtyCounter : int readonly_prop *)
  (* method doc : editSession t optdef readonly_prop *)

  method execute : undoExecuteOptions t -> unit meth
  method hasRedo : bool t meth
  method hasUndo : bool t meth
  method redo : bool t -> range t opt meth
  method reset : unit meth
  method undo : bool t -> range t opt meth
end

(* UNSAFE *)
and matchingBraceOutdent = object
  (* method autoOutdent : document t -> int -> unit meth *)
  (* method checkOutdent : js_string t -> js_string t -> bool t meth *)
end
(* END UNSAFE *)

(* TO COMPLETE *)and mode = object
  method autoOutdent : (js_string t -> document t -> int -> unit) prop
  method checkOutdent : (js_string t -> js_string t -> js_string t -> bool t) prop
  method getNextLineIndent : (js_string t -> js_string t -> js_string t -> js_string t) prop
  method toggleCommentLines : (js_string t -> document t -> int -> int -> unit) prop
end

and document = object
  method applyDeltas : delta t js_array t -> unit meth
  method createAnchor : int -> int -> anchor t meth
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

(* A TEST *) and editSession = object
  method addDynamicMarker : marker t -> bool t -> marker t meth (* UNSAFE *)
  method addGutterDecoration : int -> js_string t -> unit meth
  method addMarker : range t -> js_string t -> typeMarker -> bool t -> int meth (* UNSAFE *)
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
  method getMarkers : bool t -> marker t optdef js_array t meth (* UNSAFE *)
  method getMode : mode t meth	(* UNSAFE *)
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
  method getSelection : js_string t meth
  method getState : int -> js_string t meth
  method getTabSize : int meth
  method getTabString : js_string t meth
  method getTextRange : range t -> js_string t meth
  method getTokenAt : int -> int -> token t meth
  method getTokens : int -> token t js_array t meth (* ou tokenPos s'ils ont été vu par le getTokenAt *)
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
  method insert : point t -> js_string t -> insertResOBJ meth (* A TEST *)
  method isTabStop : point t -> bool t meth		      (* A TEST *)
  method moveLinesDown : int -> int -> int meth		      (* A TEST *)
  method moveLinesUp : int -> int -> int meth		      (* A TEST *)
  method moveText : range t -> toPositionOBJ -> range t meth  (* A TEST *)
  method on : js_string t -> ('a -> unit) -> unit meth
  method onChange : unit meth (* A TEST (Undocumented) *)
  method onChangeFold : unit meth (* A TEST (Undocumented) *)
  method onReloadTokenizer : objectEOBJ -> unit meth (* A TEST *)
  method outdentRows : range t -> unit meth
  method redo : unit meth (* A TEST (Undocumented) *)
  method redoChanges : delta t js_array t -> bool t -> range t meth (* A TEST *)
  method remove : range t -> point t meth (* A TEST *)
  method removeGutterDecoration : int -> js_string t -> unit meth
  method removeMarker : int -> unit 	(* A TEST : markerId *)
  method replace : range t -> js_string t -> point t meth
  method reset : unit meth (* A TEST (Undocumented) *)
  method resetCaches : unit meth (* A TEST (Undocumented) *)
  method screenToDocumentColumn : unit meth (* A TEST (Undocumented) *)
  method screenToDocumentPosition : int -> int -> point t meth
  method screenToDocumentRow : unit meth (* A TEST (Undocumented) *)
  method setAnnotations : annotation t js_array t -> unit meth (* A TEST *)
  method setBreakpoint : int -> js_string t -> unit meth
  method setBreakpoints : int js_array t -> unit meth
  method setDocument : document t -> unit meth
  method setMode : mode t -> unit meth (* A TEST (Undocumented) *)
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
  method undoChanges : delta t js_array t -> bool t -> range t meth (* A TEST *)
end


(* A TEST *)class type backgroundTokenizer = object
  method fireUpdateEvent : int -> int -> unit meth
  method getState : int -> stateTokenOBJ meth	(* A TEST Res *)
  method getTokens : int -> token t js_array t meth (* A TEST Res *)
  method on : js_string t -> ('a -> unit) -> unit meth
  method setDocument : document t -> unit meth
  method setTokenizer : tokenizer t -> unit meth
  method stop : unit meth
end


(* A TEST *)class type search = object
  method find : editSession t -> range t meth
  method findAll : editSession t -> range t meth (* A TEST Res = range or array *)
  method getOptions : searchOptionsOBJ meth      (* A TEST *)
  method replace : js_string t -> js_string t -> js_string t (* A TEST Res = ? *)
  method set : searchOptionsOBJ meth                         (* A TEST *)
  method setOptions : unit meth                              (* A TEST (Undocumented) *)
end


class type orientedRange = object
  inherit range
  method cursor : point t readonly_prop
  method marker : int readonly_prop
end


(* A TEST *)class type selection = object
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
  method moveCursorToPosition : point t -> unit meth (* A TEST pos_w *)
  method moveCursorToScreen : int -> int -> bool t -> unit meth
  method moveCursorUp : unit meth
  method moveCursorWordLeft : unit meth (* A TEST (Undocumented) *)
  method moveCursorWordRight : unit meth (* A TEST (Undocumented) *)
  method on : js_string t -> ('a -> unit) -> unit meth
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
  method selectToPosition : point t -> unit meth (* A TEST pos_w *)
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


(* A TEST *)class type virtualRenderer = object
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
  method setAnnotations : annotation t js_array t -> unit meth (* A TEST *)
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


(* A TEST *)class type editor = object
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
  method getCursorPosition : point t meth (* A TEST *)
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
  method moveCursorToPosition : point t -> unit meth
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
  method on : js_string t -> ('a -> unit) -> unit meth (* A TEST *)
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

val anchor : (document t -> int -> int -> anchor t) constr
val backgroundTokenizer : (tokenizer t -> editor t -> backgroundTokenizer t) constr
(* TO COMPLETE (String|Array) *)val document : (js_string t -> document t) constr

(* TO COMPLETE (String|Mode) ?*)val editSession : (js_string t -> js_string t -> editSession t) constr

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
val undoExecuteOptions : delta_array t -> editSession t -> undoExecuteOptions t
val delta : js_string t -> range t -> js_string t optdef -> js_string t optdef -> js_string t js_array t optdef -> delta t
val delta_array : delta t js_array t -> js_string t -> delta_array t 


(** ACE MAIN'S FUNCTIONS **)

(* TO COMPLETE *) val edit : Dom.element t -> editor t (* A TEST Dom.element ? *)
(* TO COMPLETE *) val createEditSession : js_string t -> js_string t -> editSession t

(* WARNINGS !!! *)val require : string -> unit

