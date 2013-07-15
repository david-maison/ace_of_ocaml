
open Dom_html
open Ace
open Js

let debug o =
  Firebug.console##debug(o)

let setVarTest o =
  Js.Unsafe.set Dom_html.window "oobj" o

let _ =
  let editor : editor Js.t = Js.Unsafe.get Dom_html.window "editor" in
  editor##setValue(Js.string "let x = 10", Obj.magic 5);
  require "Range";

  (* BEGIN TEST HERE *)
  let doc = editor##getSession()##getDocument() in
  let obj = jsnew anchor(doc, 0, 5) in
  
  (* END TEST HERE *)
  setVarTest obj

  

