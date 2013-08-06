
open Js
open Tokenizer
open Document


class type backgroundTokenizer = object
  method fireUpdateEvent : int -> int -> unit meth
  method getState : int -> js_string t meth
  method getTokens : int -> token t js_array t meth
  method on : js_string t -> ('a -> unit) -> unit meth
  method setDocument : document t -> unit meth
  method setTokenizer : tokenizer t -> unit meth
  method stop : unit meth
end
