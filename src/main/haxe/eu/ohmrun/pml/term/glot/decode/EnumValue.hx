package eu.ohmrun.pml.term.glot.decode;

final decode = __.pml().glot().decode;

class EnumValue extends Clazz{
  public function apply(self:PExpr<Atom>):Upshot<Dynamic,GlotFailure>{
    return switch(self){
      case PGroup(Cons(PGroup(Cons(PLabel(path),Cons(PLabel(name),Nil))),xs)) : 
        final _enum         = std.Type.resolveEnum(path);
        final params        = Upshot.bind_fold(
          xs,
          (next:PExpr<Atom>,memo:Cluster<Dynamic>) -> {
            return decode.PExpr.apply(next).map(memo.snoc);
          },
          [].imm()
        );
        return params.map(
          params -> std.Type.createEnum(_enum,name,@:privateAccess params.prj())
        );
      default : __.reject(f -> f.of(E_Glot('incorrect pattern for EnumValue decode')));
    }
  }
}