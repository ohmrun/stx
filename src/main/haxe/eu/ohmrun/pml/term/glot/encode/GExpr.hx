package eu.ohmrun.pml.term.glot.encode;

import eu.ohmrun.glot.expr.GExpr in TGExpr;

final encode = __.pml().glot().encode;

class GExpr extends Clazz{ 
  private function one(label:String,value:PExpr<Atom>){
    return PAssoc([tuple2(PLabel(label),value)]);
  }
  private function labelled_group1(label:String,value:PExpr<Atom>){
    return PGroup(Cons(PLabel(label),Cons(value,Nil)));
  }
  private function labelled_group2(label:String,valueI:PExpr<Atom>,valueII:PExpr<Atom>){
    return PGroup(Cons(PLabel(label),Cons(valueI,Cons(valueII,Nil))));
  }
  private function labelled_group3(label:String,valueI:PExpr<Atom>,valueII:PExpr<Atom>,valueIII:PExpr<Atom>){
    return PGroup(Cons(PLabel(label),Cons(valueI,Cons(valueII,Cons(valueIII,Nil)))));
  }
  public function apply(self:TGExpr):PExpr<Atom>{
    return switch(self){
      default                             : encode.EnumValue.apply(self);
      // case GEVars(vars)                   :
      // case GEFunction(kind, f)            :
      // case GEBlock(exprs)                 :
      // case GEFor(it, eexpr)               :
      // case GEIf(econd, eif, eelse)        :
      // case GEWhile(econd, e, normalWhile) :
      // case GESwitch(e, cases, edef)       :
      // case GETry(e, catches)              :
      // case GEReturn(e)                    :
      // case GEBreak                        :
      // case GEContinue                     :
      // case GEUntyped(e)                   :
      // case GEThrow(e)                     :
      // case GECast(e, t)                   :
      // case GETernary(econd, eif, eelse)   :
      // case GECheckType(e, t)              :
      // case GEMeta(s, e)                   :
      // case GEIs(e, t)                     :
    }
  }
}