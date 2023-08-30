package eu.ohmrun.pml.term.glot.encode;

final encode = __.pml().glot().encode;

class Object extends Clazz{
  public function apply(self:Dynamic){
    return PAssoc(Reflect.fields(self).map(
      x -> tuple2(PLabel(x),encode.Dyn.apply(Reflect.field(self,x)))
    ).imm());
  }
}