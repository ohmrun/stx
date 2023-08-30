package eu.ohmrun.pml.term.glot.encode;

import EnumValue as TEnumValue;

final encode = __.pml().glot().encode;

class EnumValue extends Clazz{
  public function apply(self:TEnumValue){
    final enum_identity        = PLabel(std.Type.getEnumName(std.Type.getEnum(self)));
    final constructor_identity = PLabel(std.Type.enumConstructor(self));
    final identity             = PGroup(Cons(enum_identity,Cons(constructor_identity,Nil)));

    final constructor_params   = std.Type.enumParameters(self).map(
      (dyn) -> encode.Dyn.apply(dyn)
    ).rfold(
      (next:PExpr<Atom>,memo:LinkedList<PExpr<Atom>>) -> memo.cons(next),
      LinkedList.unit()
    );

    return PGroup(constructor_params.cons(identity));
  }
}