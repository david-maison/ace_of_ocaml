
open Js

let to_js_string_array arr =
  let js_arr = jsnew array_length(Array.length arr) in
  ignore (Array.fold_left (fun i str ->
    array_set js_arr i (Js.string str); i+1) 0 arr);
  js_arr


let from_js_string_array js_arr =
  let len = js_arr##length in
  let arr = Array.make len "" in
  for i=0 to len-1 do
    let js_str = Optdef.get (array_get js_arr i) (fun () -> assert false) in
    Array.set arr i (Js.to_string js_str)
  done;
  arr
  
