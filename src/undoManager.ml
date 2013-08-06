
open Js
open Range

type undoExecuteOptions

class type undoManager = object
  method execute : undoExecuteOptions t -> unit meth
  method hasRedo : bool t meth
  method hasUndo : bool t meth
  method redo : bool t -> range t opt meth
  method reset : unit meth
  method undo : bool t -> range t opt meth
end

