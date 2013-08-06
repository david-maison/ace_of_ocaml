
open Js
open Range

class type delta = object
  (* (action : prop defined)
     insertText : text
     insertLines : lines
     removeText : text
     removeLines : nl lines *)
  method action : js_string t readonly_prop
  method lines : js_string t js_array t optdef readonly_prop
  method nl : js_string t optdef readonly_prop
  method range : range t readonly_prop
  method text : js_string t optdef readonly_prop
end

class type delta_array = object
  method deltas : delta t js_array t readonly_prop
  method group : js_string t readonly_prop
end
