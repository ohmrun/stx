package eu.ohmrun.pml.term.glot.encode;

final encode = __.pml().glot().encode;

class Object extends Clazz{
  public function apply(self:Dynamic){
    return PAssoc(Reflect.fields(self).map_filter(
      x -> {
        final field = Reflect.field(self,x);
        return Reflect.isFunction(field).if_else(
          () -> None,
          () -> (x == "pos").if_else(
            () -> None,
            () -> Some(tuple2(PLabel(x),encode.Dyn.apply(field)))
          )
        );
      }
    ).imm());
  }
}