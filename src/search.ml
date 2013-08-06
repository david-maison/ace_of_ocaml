
open Js
open Range
open EditSession


class type searchOptions = object
  method backwards : bool t readonly_prop
  method caseSensitive : bool t optdef readonly_prop
  method needle : js_string t readonly_prop
  method range : range t optdef readonly_prop
  method re : regExp t optdef readonly_prop
  method regExp : bool t optdef readonly_prop
  method skipCurrent : bool t readonly_prop
  method start : range t readonly_prop
  method wholeWord : bool t optdef readonly_prop
  method wrap : bool t readonly_prop
end


class type search = object
  method find : editSession t -> range t opt meth (* UNSAFE can return "false" *)
  method findAll : editSession t -> range t js_array t meth
  method getOptions : searchOptions t meth
  method replace : js_string t -> js_string t -> js_string t
  method set : searchOptions t -> search t meth
  method setOptions : searchOptions t -> unit meth
end
