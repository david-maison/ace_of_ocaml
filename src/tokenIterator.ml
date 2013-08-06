
open Js
open Tokenizer

class type tokenIterator = object
  method getCurrentToken : token t optdef meth
  method getCurrentTokenColumn : int meth
  method getCurrentTokenRow : int meth
  method stepBackward : token t opt meth
  method stepForward : token t opt meth
end
