package stx.assert.eq.term;

import stx.nano.Ident in IdentT;

class Ident extends EqCls<IdentT>{
  public function new(){}
  public function comply(lhs:IdentT,rhs:IdentT){
    var eq = Eq.String().comply(lhs.name,rhs.name);
    if(eq.is_ok()){
      eq = switch([lhs.pack,rhs.pack]){
        case [null,null]                    : AreEqual;
        case [null,x] if (!x.is_defined())  : AreEqual;
        case [x,null] if (!x.is_defined())  : AreEqual;
        default : Eq.NullOr(Eq.Cluster(Eq.String())).comply(lhs.pack,rhs.pack);
      }
    }
    return eq;
  }
}