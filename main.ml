
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
  let obj = editor##find(some (string " "), searchOptionsTEST, Js._true) in
  editor##findNext(searchOptionsTEST, Js._true);
  (* editor##findNext(searchOptionsTEST, Js._true); *)
  editor##findPrevious(searchOptionsTEST, Js._true);

  
  (* END TEST HERE *)
  setVarTest obj

  

