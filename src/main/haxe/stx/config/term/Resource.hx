package stx.config.term;

typedef ResourceDef = Produce<Ensemble<String>,ConfigFailure>;
@:forward abstract Resource(ResourceDef) to ResourceDef{
  static public function unit(){
    return new Resource();
  }
  public function new(){
    final bake      = __.bake();
    //__.log().debug(_ -> _.pure(bake.defines));
    final resource  = Ensemble.fromClusterCouple(bake.defines.map_filter(
      x -> x.key == 'stx.config.Resource' ? Some(__.tracer()(x.val)) : None
    ).map(
      (x:String) -> __.couple(x,__.resource(x,__.here()).string())//TODO handle error
    ));
    this = Produce.pure(resource);
  }
}