
open Js

(* TO BE DELETED *)
type objectEOBJ
(* END TO BE DELETED *)

(* UNSAFE *)
type typeMarker = Unsafe.any
let typeMarker_of_string str = Unsafe.inject str
let typeMarker_of_function f = Unsafe.inject f
(* END UNSAFE *)

(* UNSAFE *)
class type annotation = object
end
(* END UNSAFE *)

(* TODO *)
class type hashHandler = object end

(* TO COMPLETE AND TEST *)
class type commandManager = object
    
end

class type ['a] event = object
  method data : 'a readonly_prop
end

let event data =
  Unsafe.obj [| "data" , Unsafe.inject data |]


class type limit = object
  method max : int readonly_prop
  method min : int readonly_prop
end

class type point = object
  method row : int readonly_prop
  method column : int readonly_prop
end

class type screenPoint = object
  inherit point
  method side : int readonly_prop
end

class type screenCoord = object
  method pageX : int readonly_prop
  method pageY : int readonly_prop
end

(* TO COMPLETE *)
type tokenizerToken =
    Comment | Comment_doc | Comment_doc_tag | Constant_language
  | Constant_language_boolean | Constant_language_delimiter
  | Constant_language_escape | Constant_numeric | Constant_other
  | Constant_other_multiline | Empty | Entity_name_function | Identifier
  | Invalid | Keyword | Keyword_control | Keyword_operator | Paren_lparen 
  | Paren_rparen | Punctuation_operator | Regexp_keyword_operator
  | Storage_modifier | Storage_type | String | Support_function | Text
  | Variable_language | Variable_parameter
    
let tokenizerToken_to_string = function
  | Comment -> "comment"
  | Comment_doc -> "comment.doc"
  | Comment_doc_tag -> "comment.doc.tag"
  | Constant_language -> "constant_language"
  | Constant_language_boolean -> "constant.language.boolean"
  | Constant_language_delimiter -> "constant.language.delimiter"
  | Constant_language_escape -> "constant.language.escape"
  | Constant_numeric -> "constant.numeric"
  | Constant_other -> "constant.other"
  | Constant_other_multiline -> "constant.other.multiline"
  | Empty -> "empty"
  | Entity_name_function -> "entity.name.function"
  | Identifier -> "identifier"
  | Invalid -> "invalid"
  | Keyword -> "keyword"
  | Keyword_control -> "keyword.control"
  | Keyword_operator -> "keyword.operator"
  | Paren_lparen  -> "paren.lparen "
  | Paren_rparen -> "paren.rparen"
  | Punctuation_operator -> "punctuation.operator"
  | Regexp_keyword_operator -> "regexp.keyword.operator"
  | Storage_modifier -> "storage.modifier"
  | Storage_type -> "storage.type"
  | String -> "string"
  | Support_function -> "support.function"
  | Text -> "text"
  | Variable_language  -> "variable.language "
  | Variable_parameter -> "variable.parameter"
  

type tokenizerTokenTypes =
    Tok of tokenizerToken | Arr of tokenizerToken array
  | Fun of (string -> tokenizerToken)
type tokenizerRegex = Js.regExp Js.t

(* CAN BE IMPROVED *)
type tokenizerStateItem
type tokenizerState = string * (tokenizerStateItem js_array t)
(* WARNING : Need a "start" rule *)
let tokenizerState nameState tokensItems =
  let state = jsnew array_empty() in
  let _ = List.fold_left (fun i (token, regex, next_opt) ->
    let unsafe_token = match token with
        Tok t -> Unsafe.inject (Js.string (tokenizerToken_to_string t))
      | Arr a ->
          let a = Array.init (Array.length a)
            (fun i -> tokenizerToken_to_string a.(i)) in
          Unsafe.inject (Utils.to_js_string_array a)
      | Fun f ->
          let f s = tokenizerToken_to_string (f (Js.to_string s)) in
          Unsafe.inject (fun s -> Js.string (f s))
    in
    let obj = Unsafe.obj [| "token", unsafe_token ;
                            "regex", Unsafe.inject regex |] in
    begin match next_opt with
      | None -> obj
      | Some next -> Unsafe.set obj "next" (Js.string next)
    end;
    array_set state i obj;
    i+1) 0 tokensItems in
  (nameState, state)

(* CAN BE IMPROVED *)   
type tokenizerRules
let tokenizerRules tokenizerStates =
  let rules = Unsafe.obj [||] in
  List.iter (fun (name, state) ->
    Unsafe.set rules name state) tokenizerStates;
  rules

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
  (* Signature : line -> state -> tokensInfo
     state = un des states du tokenizer
       si state n'est pas connu dans le tokenizer, ça échoue *)
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
  (* (action : prop defined)
     insertText : text
     insertLines : lines
     removeText : text
     removeLines : nl lines *)
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
  method id : int optdef readonly_prop
  method cursor : point t optdef readonly_prop
  method marker : int optdef readonly_prop

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
  method extend : int -> int -> range t meth (* Ne modifie pas l'objet *)
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
  method toScreenRange : editSession t -> range t meth (*Ne modifie pas l'objet*)
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
  (* method update : ??? optdef readonly_prop *) (* ??? *)
end

and undoManager = object
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

(* TO COMPLETE *) and mode = object
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


and selection = object
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


(* A TEST *) and editSession = object
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


class type backgroundTokenizer = object
  method fireUpdateEvent : int -> int -> unit meth
  method getState : int -> js_string t meth
  method getTokens : int -> token t js_array t meth
  method on : js_string t -> ('a -> unit) -> unit meth
  method setDocument : document t -> unit meth
  method setTokenizer : tokenizer t -> unit meth
  method stop : unit meth
end


class type searchOptions = object
  method backwards : bool t readonly_prop
  method caseSensitive : bool t optdef readonly_prop
  method needle : js_string t readonly_prop
  method range : range t optdef readonly_prop
  method re : regExp t optdef readonly_prop
  method regExp : bool t optdef readonly_prop
  method skipCurrent : bool t readonly_prop
  method start : range t readonly_prop
  method wholeWord : bool t optdef readonly_prop
  method wrap : bool t readonly_prop
end


class type search = object
  method find : editSession t -> range t opt meth (* UNSAFE can return "false" *)
  method findAll : editSession t -> range t js_array t meth
  method getOptions : searchOptions t meth
  method replace : js_string t -> js_string t -> js_string t
  method set : searchOptions t -> search t meth
  method setOptions : searchOptions t -> unit meth
end



class type virtualRenderer = object
  method addGutterDecoration : int -> js_string t -> unit meth (* DEPRECATED *)
  method adjustWrapLimit : unit meth
  method alignCursor : point t -> int -> int meth
  method animateScrolling : int -> (unit -> unit) -> unit meth
  method destroy : unit meth
  method getAnimatedScroll : bool t meth
  method getContainerElement : #Dom.element t meth
  method getDisplayIndentGuides : bool t meth
  method getFadeFoldWigdets : bool t meth
  method getFirstFullyVisibleRow : int meth
  method getFirstVisibleRow : int meth 
  method getHighlightGutterLine : bool t meth
  method getHScrollBarAlwaysVisible : bool t meth
  method getLastFullyVisibleRow : int meth
  method getLastVisibleRow : int meth
  method getMouseEventTarget : #Dom.element t meth
  method getPrintMarginColumn : bool t meth
  method getScrollBottomRow : int meth
  method getScrollLeft : int meth
  method getScrollTop : int meth
  method getScrollTopRow : int meth
  method getShowGutter : bool t meth
  method getShowInvisibles : bool t meth
  method getShowPrintMargin : bool t meth
  method getTextAreaContainer : #Dom.element t meth
  method getTheme : js_string t meth
  method hideComposition : unit meth
  method hideCursor : unit meth
  method isScrollableBy : int -> int -> bool t meth
  method onChangeTabSize : (unit -> unit) prop
  method onGutterResize : (unit -> unit) prop
  method onResize : bool t -> int -> int -> int -> unit meth
  method pixelToScreenCoordinates : int -> int -> screenPoint t meth
  method removeGutterDecoration : int -> js_string t -> unit meth(* DEPRECATED *)
  method screenToTextCoordinates : int -> int -> point t meth
  method scrollBy : int -> int -> unit meth
  method scrollCursorIntoView : point t -> int -> unit meth
  method scrollSelectionIntoView : anchor t -> point t -> int -> unit meth
  method scrollToLine: int -> bool t -> bool t -> (unit -> unit) -> unit meth
  method scrollToRow : int -> unit meth
  method scrollToX : int -> unit meth
  method scrollToY : int -> unit meth
  method setAnimatedScroll : bool t -> unit meth
  method setAnnotations : annotation t js_array t -> unit meth (* UNSAFE *)
  method setCompositionText : js_string t -> unit meth
  method setDisplayIndentGuides : bool t -> unit meth
  method setFadeFoldWidgets : bool t -> unit meth
  method setHighlightGutterLine : bool t -> unit meth
  method setHScrollBarAlwaysVisible : bool t -> unit meth
  method setPadding : int -> unit meth
  method setPrintMarginColumn : bool t -> unit meth
  method setSession : editSession t -> unit meth
  method setShowGutter : bool t -> unit meth
  method setShowInvisibles : bool t -> unit meth
  method setShowPrintMargin : bool t -> unit meth
  method setStyle : js_string t -> bool t -> unit meth
  method setTheme : js_string t -> unit meth
  method showCursor : unit meth
  method textToScreenCoordinates : int -> int -> screenCoord t meth
  method unsetStyle : js_string t -> unit meth
  method updateBackMarkers : unit meth
  method updateBreakpoints : int -> unit meth
  method updateCharacterSize : unit meth
  method updateCursor : unit meth
  method updateFontSize : unit meth
  method updateFrontMarkers : unit meth
  method updateFull : bool t -> unit meth
  method updateLines : int -> int -> unit meth
  method updateText : unit meth
  method visualizeBlur : unit meth
  method visualizeFocus : unit meth
end

class type numberLocated = object
  method _end : int readonly_prop
  method start : int readonly_prop
  method value : js_string t readonly_prop
end

(* A TEST *)class type editor = object
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


(** CONSTRUCTORS **)
(* No need to call requires ?? *)

let anchor = Unsafe.variable "ace.require(\"./anchor\").Anchor"
let backgroundTokenizer = Unsafe.variable "ace.require(\"./background_tokenizer\").BackgroundTokenizer"
(* TO COMPLETE (String|Array) *)let document = Unsafe.variable "ace.require(\"./document\").Document"
(* TO COMPLETE (String|Mode) *)let editSession = Unsafe.variable "ace.require(\"./edit_session\").EditSession"
let editor = Unsafe.variable "ace.require(\"./editor\").Editor"
let matchingBraceOutdent = Unsafe.variable "ace.require(\"./matching_brace_outdent\").MatchingBraceOutdent"
let range = Unsafe.variable "ace.require(\"./range\").Range"
let scrollBar = Unsafe.variable "ace.require(\"./scrollbar\").ScrollBar"
let search = Unsafe.variable "ace.require(\"./search\").Search"
let selection = Unsafe.variable "ace.require(\"./selection\").Selection"
(* REQUIRES RANGE *)let tokenIterator = Unsafe.variable "ace.require(\"./token_iterator\").TokenIterator"
let tokenizer = Unsafe.variable "ace.require(\"./tokenizer\").Tokenizer"
let undoManager = Unsafe.variable "ace.require(\"./undomanager\").UndoManager"
let virtualRenderer = Unsafe.variable "ace.require(\"./virtual_renderer\").VirtualRenderer"



(** OTHER CONSTRUCTORS **)
let mode tokenizer outdent =
  let _Mode = Unsafe.variable "ace.require(\"./mode/text\").Mode" in
  ignore (Unsafe.meth_call (fun () -> ()) "call"
            [| Unsafe.inject (Unsafe.get _Mode "prototype") |]);
  let mode = jsnew _Mode() in
  Unsafe.set mode "$tokenizer" tokenizer;
  Optdef.iter outdent (fun outdent -> Unsafe.set mode "$outdent" outdent);
  mode

let point row column =
  Unsafe.obj [| "row", Unsafe.inject row ;
		"column", Unsafe.inject column |]


let rangeFromPoints pStart pEnd = (* No need to requires "Range" ? *)
  Unsafe.meth_call (Unsafe.variable "ace.require(\"./range\").Range")
    "fromPoints"
    [| Unsafe.inject pStart ; Unsafe.inject pEnd |]

let searchOptions ?(backwards=_false) ?(caseSensitive=_false) ?(needle=string "")
    ?(range=jsnew range(0,0,0,0)) ?(regExp=_false) ?(skipCurrent=_false)
    ?(start=point 0 0) ?(wholeWord=_false) ?(wrap=_false) = 
  Unsafe.obj [| "needle", Unsafe.inject needle ;
                "backwards", Unsafe.inject backwards ;
                "caseSensitive", Unsafe.inject caseSensitive ;
                "range", Unsafe.inject range ;
                "regExp", Unsafe.inject regExp ;
                "skipCurrent", Unsafe.inject skipCurrent ;
                "start", Unsafe.inject start ; 
                "wholeWord", Unsafe.inject wholeWord ;
                "wrap", Unsafe.inject wrap |]


let undoExecuteOptions deltas document =
  let arr = jsnew array_empty() in
  array_set arr 0 (Unsafe.inject deltas);
  array_set arr 1 (Unsafe.inject document);
  Unsafe.obj [| "args", Unsafe.inject arr |]


let delta action range text nl lines =
  let obj = Unsafe.obj [| "action", Unsafe.inject action ;
                "range", Unsafe.inject range |] in
  if Optdef.test text then Unsafe.set obj "text" text;
  if Optdef.test nl then Unsafe.set obj "nl" nl;
  if Optdef.test lines then Unsafe.set obj "lines" lines;
  obj

let delta_array deltas group =
  Unsafe.obj [| "deltas", (Unsafe.inject deltas) ;
                "group", (Unsafe.inject group) |]


(** ACE MAIN'S FUNCTIONS **)

let edit el = 
  Unsafe.fun_call
    (Unsafe.variable "ace.edit") [| Unsafe.inject el |]

let createEditSession text mode =
  Unsafe.fun_call
    (Unsafe.variable "ace.createEditSession")
    [| Unsafe.inject text ;
       Unsafe.inject mode |]


(*  WARNING
    Ace's object are in native code, so in objects's constructor,
    we have to do ace.requires("./obj").Obj again to construct the object

    WARNING 2
    Some module's path aren't just uncapitalize moduleName, like
    TokenIterator, the path is" ace/token_iterator"
      -> create enum for moduleName ?

    WARNING 3 require(...) and not ace.require(...) ?
*)
let require moduleName =
  let arg = Format.sprintf "require(\"ace/%s\").%s"
    (String.uncapitalize moduleName) moduleName in
  let _module = Unsafe.variable arg in
  Unsafe.set Dom_html.window (Unsafe.variable moduleName) _module
 
