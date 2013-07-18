
open Dom_html
open Ace
open Js

let debug o =
  Firebug.console##debug(o)

let setVarTest o =
  Js.Unsafe.set Dom_html.window "oobj" o

let _ =
  let editor : editor Js.t = Js.Unsafe.get Dom_html.window "editor" in
  let obj = Js.string "no test running" in
  let _es = createEditSession "let x = 10" "ace/mode/ocaml" in
  editor##setSession(_es);
  let _doc = _es##getDocument() in
  require "Range";
  (* BEGIN TEST HERE *)

  (* TEST FOR RANGE *)
  let obj = jsnew range(0,1,2,3) in
  let p1 = point_w 0 0 in
  let p2 = point_w 5 5 in
  let obj = rangeFromPoints p1 p2 in

  
  (* TEST FOR TOKENIZER *)
  (* let state1 = tokenizerState "pouet" *)
  (*   [Str ("keyword.operator"), "let", None] in *)
  (* let rules = tokenizerRules [state1] in *)
  (* let obj = jsnew tokenizer(rules, Js.string "") in *)

  (* let obj = obj##getLineTokens(Js.string "let a = 10", Js.string "pouet")##tokens in *)
  (* let obj = to_array obj in *)
  (* let obj = (obj.(0))##value in *)

  (* TEST FOR BACKGROUNDTOKENIZER (REQUIRES TOKENIZER) *)
  (* let obj = jsnew backgroundTokenizer(obj, editor) in *)

  (* TEST FOR TOKENITERATOR *)
  (* let obj = jsnew tokenIterator(_es, 0, 0) in *)
  (* let obj = Optdef.get obj##getCurrentToken() (fun _ -> assert false) in *)

  (* TEST FOR VIRTUALRENDERER *)
  (* let container = createDiv Dom_html.document in *)
  (* container##style##width <- Js.string "200"; *)
  (* container##style##height <- Js.string "200"; *)
  (* Dom.appendChild Dom_html.document##body container; *)
  (* let obj = jsnew virtualRenderer(container, Js.string "ace/theme/chaos") in *)

  (* TEST FOR EDITOR (REQUIRES VIRTUALRENDERER) *)
  (* let es = jsnew editSession(Js.string "class m { }", Js.string "ace/mode/java") in *)
  (* let obj = jsnew Ace.editor(obj, es) in *)

  (* TEST FOR SCROLLBAR *)
  (* let container = createDiv Dom_html.document in *)
  (* container##style##width <- Js.string "200"; *)
  (* container##style##height <- Js.string "200"; *)
  (* Dom.appendChild Dom_html.document##body container; *)
  (* let obj = jsnew scrollBar(container) in *)

  (* TEST FOR SEARCH *)
  (* let obj = jsnew search() in *)

  (* TEST FOR SELECTION *)
  (* let obj = jsnew selection(_es) in *)

  (* TEST FOR UNDOMANAGER *)
  (* let obj = jsnew undoManager() in *)


  (* END TEST HERE *)
  setVarTest obj

  

