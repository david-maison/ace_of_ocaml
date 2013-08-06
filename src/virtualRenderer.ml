
open Js
open Annotation
open Coord
open EditSession
open Anchor


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
