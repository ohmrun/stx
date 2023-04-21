package stx.show.term;

class Indented<T> extends Clazz{
  public function show(v:T,indent:String):String{
    return '${indent}${v}';
  }
}