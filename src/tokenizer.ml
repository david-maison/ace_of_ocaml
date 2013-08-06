
open Js

(* TO COMPLETE *)
type tokenizerToken =
    Comment | Comment_doc | Comment_doc_tag | Constant_language
  | Constant_language_boolean | Constant_language_delimiter
  | Constant_language_escape | Constant_numeric | Constant_other
  | Constant_other_multiline | Empty | Entity_name_function | Identifier
  | Invalid | Keyword | Keyword_control | Keyword_operator | Paren_lparen 
  | Paren_rparen | Punctuation_operator | Regexp_keyword_operator
  | Storage_modifier | Storage_type | String | Support_function | Text
  | Variable_language | Variable_parameter
    
let tokenizerToken_to_string = function
  | Comment -> "comment"
  | Comment_doc -> "comment.doc"
  | Comment_doc_tag -> "comment.doc.tag"
  | Constant_language -> "constant_language"
  | Constant_language_boolean -> "constant.language.boolean"
  | Constant_language_delimiter -> "constant.language.delimiter"
  | Constant_language_escape -> "constant.language.escape"
  | Constant_numeric -> "constant.numeric"
  | Constant_other -> "constant.other"
  | Constant_other_multiline -> "constant.other.multiline"
  | Empty -> "empty"
  | Entity_name_function -> "entity.name.function"
  | Identifier -> "identifier"
  | Invalid -> "invalid"
  | Keyword -> "keyword"
  | Keyword_control -> "keyword.control"
  | Keyword_operator -> "keyword.operator"
  | Paren_lparen  -> "paren.lparen "
  | Paren_rparen -> "paren.rparen"
  | Punctuation_operator -> "punctuation.operator"
  | Regexp_keyword_operator -> "regexp.keyword.operator"
  | Storage_modifier -> "storage.modifier"
  | Storage_type -> "storage.type"
  | String -> "string"
  | Support_function -> "support.function"
  | Text -> "text"
  | Variable_language  -> "variable.language "
  | Variable_parameter -> "variable.parameter"
  

type tokenizerTokenTypes =
    Tok of tokenizerToken | Arr of tokenizerToken array
  | Fun of (string -> tokenizerToken)
type tokenizerRegex = Js.regExp Js.t

(* CAN BE IMPROVED *)
type tokenizerStateItem
type tokenizerState = string * (tokenizerStateItem js_array t)
(* WARNING : Need a "start" rule *)
let tokenizerState nameState tokensItems =
  let state = jsnew array_empty() in
  let _ = List.fold_left (fun i (token, regex, next_opt) ->
    let unsafe_token = match token with
        Tok t -> Unsafe.inject (string (tokenizerToken_to_string t))
      | Arr a ->
          let a = Array.init (Array.length a)
            (fun i -> tokenizerToken_to_string a.(i)) in
          Unsafe.inject (Utils.to_js_string_array a)
      | Fun f ->
          let f s = tokenizerToken_to_string (f (to_string s)) in
          Unsafe.inject (fun s -> string (f s))
    in
    let obj = Unsafe.obj [| "token", unsafe_token ;
                            "regex", Unsafe.inject regex |] in
    begin match next_opt with
      | None -> obj
      | Some next -> Unsafe.set obj "next" (string next)
    end;
    array_set state i obj;
    i+1) 0 tokensItems in
  (nameState, state)

(* CAN BE IMPROVED *)   
type tokenizerRules
let tokenizerRules tokenizerStates =
  let rules = Unsafe.obj [||] in
  List.iter (fun (name, state) ->
    Unsafe.set rules name state) tokenizerStates;
  rules

class type token = object
  method _type : js_string t readonly_prop
  method value : js_string t readonly_prop
  method index : int optdef readonly_prop
  method start : int optdef readonly_prop
end

class type tokensInfo = object
  method state : js_string t readonly_prop
  method tokens : token t js_array t readonly_prop
end


class type tokenizer = object
  (* Signature : line -> state -> tokensInfo
     state = un des states du tokenizer
       si state n'est pas connu dans le tokenizer, ça échoue *)
  method getLineTokens : js_string t -> js_string t -> tokensInfo t meth
end
