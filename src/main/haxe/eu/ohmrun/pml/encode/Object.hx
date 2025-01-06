package eu.ohmrun.pml.encode;

class Object extends Clazz{
  public function apply(self:Dynamic):PExpr<Atom>{
    return PAssoc(Reflect.fields(self).map_filter(
      x -> {
        final field = Reflect.field(self,x);
        return Reflect.isFunction(field).if_else(
          () -> None,
          () -> Some(tuple2(PLabel(x),new eu.ohmrun.pml.encode.Dyn().apply(field)))
        );
      }
    ));
  }
}