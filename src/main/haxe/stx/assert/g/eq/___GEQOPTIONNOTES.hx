package stx.assert.g.eq;

typedef OPTIONS = {
  final literals_ignore_postfix : Bool;  
  final ignore_casts : Bool;
  final ignore_untyped : Bool;
  final ignore_non_math_parentheses : Bool;
  final ignore_expression_metadata : Bool;
  final ignore_doc : Bool;
  final ignore_var_default_value : Bool;
  final ignore_function_kind : Bool;
}