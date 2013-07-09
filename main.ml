
open Dom_html
open Ace

let debug o =
  Firebug.console##debug(o)

let setVarTest o =
  Js.Unsafe.set Dom_html.window "oobj" o

let _ =
  let editor : editor Js.t = Js.Unsafe.get Dom_html.window "editor" in
  require "Range";

  (* BEGIN TEST HERE *)
  let r = jsnew range(0,1,2,3) in
  let obj = editor##addSelectionMarker(r) in

  (* END TEST HERE *)
  setVarTest obj

  

