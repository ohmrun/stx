package stx.show;

class Lift{
  static public function show<A>(_:Wildcard,v:A):String{
    return Show.show(_,v);
  }
}