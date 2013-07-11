
open Dom_html
open Ace
open Js

let debug o =
  Firebug.console##debug(o)

let setVarTest o =
  Js.Unsafe.set Dom_html.window "oobj" o

let _ =
  let editor : editor Js.t = Js.Unsafe.get Dom_html.window "editor" in
  editor##setValue(Js.string "let x = 10");
  require "Range";

  (* BEGIN TEST HERE *)
  let obj = pos_w 0 5 in
  editor##moveCursorToPosition(obj);
  
  (* END TEST HERE *)
  setVarTest obj

  

