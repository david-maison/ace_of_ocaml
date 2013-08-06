
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

(* UNSAFE *)
class type matchingBraceOutdent = object
(* method autoOutdent : document t -> int -> unit meth *)
(* method checkOutdent : js_string t -> js_string t -> bool t meth *)
end
(* END UNSAFE *)






(** CONSTRUCTORS **)
(* No need to call requires ?? *)

let anchor = Unsafe.variable "ace.require(\"./anchor\").Anchor"
let backgroundTokenizer = Unsafe.variable "ace.require(\"./background_tokenizer\").BackgroundTokenizer"
(* TO COMPLETE (String|Array) *)
let document = Unsafe.variable "ace.require(\"./document\").Document"
(* TO COMPLETE (String|Mode) *)
let editSession = Unsafe.variable "ace.require(\"./edit_session\").EditSession"
let editor = Unsafe.variable "ace.require(\"./editor\").Editor"
let matchingBraceOutdent = Unsafe.variable "ace.require(\"./matching_brace_outdent\").MatchingBraceOutdent"
let range = Unsafe.variable "ace.require(\"./range\").Range"
let scrollBar = Unsafe.variable "ace.require(\"./scrollbar\").ScrollBar"
let search = Unsafe.variable "ace.require(\"./search\").Search"
let selection = Unsafe.variable "ace.require(\"./selection\").Selection"
(* REQUIRES RANGE *)
let tokenIterator = Unsafe.variable "ace.require(\"./token_iterator\").TokenIterator"
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
  Unsafe.obj [| "row", Unsafe.inject row ; "column", Unsafe.inject column |]

(* TODO *)
(*Range*)  (* method toScreenRange : editSession t -> range t meth  *)(*Ne modifie pas l'objet*)
(*Document*)  (* method createAnchor : int -> int -> anchor t meth  *)

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
    
