
open Js
open Range


(* UNSAFE *)
type typeMarker = Unsafe.any
let typeMarker_of_string str = Unsafe.inject str
let typeMarker_of_function f = Unsafe.inject f
(* END UNSAFE *)


(* SO CLOUDY (to do : constr) *)
class type marker = object
  (* method cache : ??? js_array t optdef readonly_prop *) (* ??? *)
  method clazz : js_string t readonly_prop
  method id : int readonly_prop
  method inFront : bool t readonly_prop
  method range : range t optdef readonly_prop
  method regExp : js_string t optdef readonly_prop
  (* method renderer : ??? opt optdef readonly_prop *) (* ??? *)
  method _type : typeMarker readonly_prop
  (* method update : ??? optdef readonly_prop *) (* ??? *)
end
