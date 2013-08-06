
open Js

class type limit = object
  method max : int readonly_prop
  method min : int readonly_prop
end

class type point = object
  method row : int readonly_prop
  method column : int readonly_prop
end

class type screenPoint = object
  inherit point
  method side : int readonly_prop
end

class type screenCoord = object
  method pageX : int readonly_prop
  method pageY : int readonly_prop
end


class type numberLocated = object
  method _end : int readonly_prop
  method start : int readonly_prop
  method value : js_string t readonly_prop
end
