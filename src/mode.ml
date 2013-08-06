
open Js
open Document

(* TO COMPLETE *)
class type mode = object
  method autoOutdent : (js_string t -> document t -> int -> unit) prop
  method checkOutdent : (js_string t -> js_string t -> js_string t -> bool t) prop
  method getNextLineIndent : (js_string t -> js_string t -> js_string t -> js_string t) prop
  method toggleCommentLines : (js_string t -> document t -> int -> int -> unit) prop
end

