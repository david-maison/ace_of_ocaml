
open Js

class type ['a] event = object
  method data : 'a readonly_prop
end

let event data =
  Unsafe.obj [| "data" , Unsafe.inject data |]

