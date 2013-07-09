
type tokenarray

class type pos_r = object
  method row : int Js.readonly_prop
  method column : int Js.readonly_prop
end


(* TO COMPLETE *) class type range = object
  method _end : pos_r Js.t Js.readonly_prop
  method start : pos_r Js.t Js.readonly_prop
end

let range = Js.Unsafe.variable "ace.require(\"./range\").Range"

(* TO COMPLETE *) class type orientedRange = object
  inherit range
  method cursor : pos_r Js.t Js.readonly_prop
  method marker : int Js.readonly_prop
end

(* TO COMPLETE *) class type document = object
  method getLine : int -> Js.js_string Js.t Js.meth
  method getLines : int -> int -> Js.string_array Js.t Js.meth
  method getTextRange : range Js.t -> Js.js_string Js.t Js.meth
  method getValue : Js.js_string Js.t Js.meth
  method replace : range Js.t -> Js.js_string Js.t -> unit Js.meth
  method setValue : Js.js_string Js.t -> unit Js.meth
end

(* TO COMPLETE *) class type editSession = object
  method getDocument : document Js.t Js.meth
  method getTabSize : int Js.meth
  (* method getTokens : int -> tokenarray *)
end

(* TO COMPLETE *) class type editor = object
  method addSelectionMarker : #range Js.t -> orientedRange Js.t Js.meth
  method destroy : unit Js.meth
  method getSelectionRange : range Js.t Js.meth
  method getSession : editSession Js.t Js.meth
  method getValue : Js.js_string Js.t Js.meth
  method removeLines : unit Js.meth
  method selectAll : unit Js.meth
  method setReadOnly : bool Js.t -> unit Js.meth 
  method setSession : editSession Js.t -> unit Js.meth
  method setTheme : Js.js_string Js.t -> unit Js.meth
  method setValue : Js.js_string Js.t -> unit Js.meth
end

let edit el = 
  Js.Unsafe.fun_call
    (Js.Unsafe.variable "ace.edit") [| Js.Unsafe.inject el |]

let createEditSession text mode =
  Js.Unsafe.fun_call
    (Js.Unsafe.variable "ace.createEditSession")
    [| Js.Unsafe.inject (Js.string text) ;
       Js.Unsafe.inject (Js.string mode) |]


(*  WARNING
    Ace's object are in native code, so in objects's constructor,
    we have to do ace.requires("./obj").Obj again to construct the object
*)
let require moduleName =
  let arg = Format.sprintf "require(\"ace/%s\").%s"
    (String.uncapitalize moduleName) moduleName in
  let _module = Js.Unsafe.variable arg in
  Js.Unsafe.set Dom_html.window (Js.Unsafe.variable moduleName) _module
  
