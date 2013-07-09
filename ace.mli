
type tokenarray

class type pos_r = object
  method row : int Js.readonly_prop
  method column : int Js.readonly_prop
end

(* TO COMPLETE *) class type range = object
  method _end : pos_r Js.t Js.readonly_prop
  method start : pos_r Js.t Js.readonly_prop
end

val range : (int -> int -> int -> int -> range Js.t) Js.constr

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

(* TO COMPLETE *) val edit : Dom_html.element Js.t -> editor Js.t
(* TO COMPLETE *) val createEditSession : string -> string -> editSession Js.t

val require : string -> unit
