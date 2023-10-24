package stx.makro.type.class_type;

//using stx.makro.type.class_type.Fabricator.Logging;

// class Logging{
//   static public function log(wildcard:Wildcard){
//     return stx.Log.empty();
//   }
// }

final e = __.makro().expr;

#if macro

@:using(stx.makro.type.class_type.Fabricator.FabricatorLift)
class Fabricator extends Clazz{
  public final type    : HType;

  public function new(type){
    super();
    this.type   = type;
  }
  public function reply(){
    return switch(false/*this.vars_are_addressable_through_constructor()*/){
      case true  : throw UNIMPLEMENTED; 
      case false : 
        switch(type){
          case TInst(t,ps) : 
            final var_fields            = this.type.get_vars().map(
              x -> {
                x.type = (x.type:HType).std_type();
                return x;
              }
            );
            __.log().trace('${var_fields}');
            final var_assignment_exprs  = var_fields.map(
              f -> {
                return e.HExpr.Make(
                  ed -> ed.Binop(
                    b -> b.Assign(),
                    e -> e.Make(ed -> ed.Field(e-> e.Make(ed -> ed.Constant(c -> c.Ident('value'))),f.name)),
                    e -> e.Make(ed -> ed.Constant(c -> c.Ident(f.name)))
                  )
                );
              }
            );
            final constructor_expr  = macro $b{var_assignment_exprs.map(e -> e.toExpr()).prj()};
            //String to look up via std.Reflect
            final class_path        = 
              e.HExpr.Make(
                ed -> ed.Constant(
                  c -> c.String(
                    Ident.make(type.name.fudge(),type.pack).canonical()
                  )
                )
              );
            final wayward_initialisation_expr = HExpr.lift(macro {
              final class_name = ${class_path.prj()};
              final clazz      = std.Type.resolveClass(class_name);
              final value      = std.Type.createEmptyInstance(clazz);
              ${constructor_expr}
              return value;
            });
            __.log().trace(__.makro().printer.printExpr(wayward_initialisation_expr.prj()));
            final wayward_function_args = var_fields.map(
              f -> e.HFunctionArg.Make(
                f.name,
                ct -> (f.type:HType).toComplexTypeRuntime()
              )
            );
            __.log().trace('${wayward_function_args}');
            final type_parameters  = this.type.get_type_parameters();

            final wayward_function = e.HFunction.Make(
              _ -> wayward_function_args.prj(),
              _ -> HType.lift(type).eatMonos().toComplexTypeRuntime(),
              wayward_initialisation_expr,
              tp -> type_parameters.map(
                t -> tp.Make((t:HType).name.fudge())
              ).prj()
            );
            wayward_function;
          default : throw 'not a ClassType';
        }
    }
  }
}
class FabricatorLift{
  /**
   * TODO: This is largely policy because eeking out constructor side effects is an undertaking.
   * Are the named vars covered by the constructor?
   * @param self 
   */
  static public function vars_are_addressable_through_constructor(self:Fabricator){
    final num_vars = self.type.get_vars().length;
    return false;
    // return self.type.get_constructor_field().map(
    //   (f:HClassField) -> {
    //     return switch(f.type){
    //       case TFun(args,_) : args.length == num_vars;
    //       default           : false;
    //     }
    //   }
    // ).defv(false);
  }
}
#end