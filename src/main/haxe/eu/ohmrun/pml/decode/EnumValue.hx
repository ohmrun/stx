package eu.ohmrun.pml.decode;

using stx.Show;

class EnumValue extends Clazz{
  public function apply(self : { path : String , name : String , args : Cluster<PExpr<Atom>> }):Upshot<Dynamic,PmlFailure>{
    final _enum         = std.Type.resolveEnum(self.path);
    final params        = Upshot.bind_fold(
      self.args,
      (next:PExpr<Atom>,memo:Cluster<Dynamic>) -> {
        trace("______________________________________________-----");
        trace(next.toString());
        return switch(next){
          case PEmpty | PGroup(Nil) : __.accept(memo);
          default : 
            final result = new eu.ohmrun.pml.decode.PExpr().apply(next);
            trace("====================================================");
            return result.map((x) -> {
              trace(x);
              return memo.snoc(x);   
            });
        }
      },
      Cluster.unit()
    );
    return params.map(
      params -> {
        trace('$_enum ${self.name} ${params.toString()}');
        final result = std.Type.createEnum(_enum,self.name,@:privateAccess params.prj());
        trace(result);
        return result;
      }
    );
  }
}