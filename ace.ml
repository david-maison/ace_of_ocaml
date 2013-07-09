
open Js

type searchOptions
type tokenarray

(* TO BE DELETED *)
let searchOptionsTEST : searchOptions = Unsafe.variable "null"

class type pos_w = object
  method row : int writeonly_prop
  method column : int writeonly_prop
end

let pos_w row column =
  Unsafe.obj 				(* TODO *)

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
  method focus : unit meth 		(* A TEST *)
  method getSelectionRange : range t meth
  method getSession : editSession t meth
  method getValue : js_string t meth
  method removeLines : unit meth
  method selectAll : unit meth
  method setReadOnly : bool t -> unit meth 
  method setSession : editSession t -> unit meth
  method setTheme : js_string t -> unit meth
  method setValue : js_string t -> unit meth
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
  
