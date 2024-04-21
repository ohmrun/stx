package eu.ohmrun.pml.pspec;

import haxe.rtti.Meta;

using stx.Show;

class Util{
  // static public function collect(self:PExpr<Atom>,match:EnumValue){
  //   return spec_lookup(match).resolve(f -> f.of(E_Pml_Invalid(self)))
  //     .flat_map(
  //       spec -> {
  //         return switch(self){
  //           case PGroup(Cons(x,Cons(PLabel(x),Nil))) if (x == spec) :

  //         }
  //       }
  //     );
  // }
  static public function spec_reverse_lookup(self:Enum<Dynamic>,key:String):Upshot<EnumValue,PmlFailure>{
    final result = Upshot.bind_fold(
      Ensemble.lift(Meta.getFields(self)).toCluster(),
      (next:Field<Dynamic<Array<Dynamic>>>,memo:Cluster<Field<String>>) -> {
        ///trace(next);
        final result = spec_val(next.val).map(
          v -> Field.make(next.key,v)
        );
        return result.resolve(
          f -> f.of(E_Pml('cannot find $key in ${self.name()}'))
        ).map(memo.snoc);
      },
      []
    ).flat_map(
      arr -> arr.search(x -> x.val == key).resolve(
        f -> f.of(E_Pml('cannot find $key in ${self.name()}'))
      )
    ).map(
      x -> {
      return Ident.make(x.key,self.name().split("."));
      }
    ).flat_map(
      x -> enum_from_ident(x).resolve(f -> f.of(E_Pml('cannot resolve $x')))
    );
    return result;
  }
  static public function enum_from_ident(self:Ident){
    final _enum : stx.Enum<Dynamic> = std.Type.resolveEnum(self.pack.join("."));
    final _val = _enum.construct(Right(self.name),[]);
    return _val;
  }
  static function spec_key(x){
    return __.option(Reflect.field(x,"eu.ohmrun.pml.spec"));
  }
  static public function spec_val(x:Dynamic<Array<Dynamic>>){
    return spec_key(x).flat_map(x -> __.option(x[0]));
  }
  static public function spec_lookup(self:EnumValue):Option<String>{
    final _enum   = std.Type.getEnum(self);
    final result  = __.option(Meta.getFields(_enum)).flat_map(
      x -> __.option(Reflect.field(x,self.ctr()))
    ).flat_map(x -> spec_val(x));
    __.log().trace('$result');
    return result;
  }
  static public function enum_path(self:EnumValue){
    final _enum : stx.Enum<Dynamic>  = std.Type.getEnum(self);
    trace(_enum.name());
    //TODO move moniker
    final result = Ident.make(self.ctr(),_enum.name().split("."));
    //__.log().trace('$result');
    return __.option(result);
  }
  static public function enum_form(self:EnumValue,rest:LinkedList<PExpr<Atom>>):Option<LinkedList<PExpr<Atom>>>{
    return enum_path(self).map(
      x -> Cons(
        PGroup(
          Cons(PLabel(x.pack.join(".")),Cons(PLabel(x.name),Nil))
        ),
        rest
      )
    );
  }
  static public function enum_make(self:EnumValue,rest:LinkedList<PExpr<Atom>>){
    return enum_form(self,rest).map(PGroup);
  }
  static public function args_two_group(x,y){
    return PGroup(Cons(x,Cons(y,Nil)));
  }
  static public function args_two(x,y){
    return Cons(x,Cons(y,Nil));
  }
  static public function args_one(x){
    return Cons(x,Nil);
  }
  static public function tuple2_make(l:PExpr<Atom>,r:PExpr<Atom>){
    return enum_make(tuple2(null,null),args_two(l,r));
  }
  // static public function makePItemKind(self,?args:PExpr<Atom>){
  //   return enum_path(self).map(
  //     ident -> 
  //   )
  // }
}