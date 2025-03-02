package eu.ohmrun.glot;

typedef EnumAbstractArgsDef = {
  final name          : String;
  final pack          : Way;
  final constructors  : Cluster<{ name : String, data : GConstant }>;
  final type          : GComplexType; 
}
class EnumAbstract{
  @:noUsing static public function make(self:EnumAbstractArgsDef){
    final clazz_ident  = Ident.make(
      '${self.name}_Impl_',
       self.pack.snoc('_${self.name}') 
    );
    __.log().debug(_ -> _.pure(clazz_ident));

    final abstract_ident = Ident.make(
      self.name,
      self.pack
    );
    __.log().debug(_ -> _.pure(abstract_ident));

    final abstract_declaration = __.glot().Expr.GTypeDefinition.Make(
      abstract_ident.name,
      abstract_ident.pack,
      tkind -> tkind.Abstract(
        _ -> self.type,
        _ -> Cluster.pure(self.type),
        _ -> Cluster.pure(self.type)
      ),
      field -> self.constructors.map(
        ctr -> field.Make(
          ctr.name,
          ftype -> ftype.Var(
            _ -> null,
            expr -> expr.Const(
              _ -> ctr.data
            )
          )
        )
      ),
      _ -> [],
      meta -> Cluster.make([
        meta.Make(
          'enum'
        )
      ])
    );
    __.log().debug(_ -> _.pure(abstract_declaration));

  //   final clazz_declaration = __.glot().TypeDefinition.Make(
  //     clazz_ident.name,
  //     clazz_ident.pack,
  //     tkind -> tkind.Class(null,null,null,true,true),
  //     field -> self.constructors.map(
  //       ctr -> field.Make(
  //         ctr.name,
  //         ftype -> ftype.Var(
  //           ctype -> ctype.Path(
  //             path -> path.fromIdent(abstract_ident) 
  //           ),
  //           expr -> expr.Cast(
  //             expr -> expr.Const(
  //               _ -> ctr.data
  //             ),
  //             _ -> self.type
  //           ) 
  //         ),
  //         access -> [
  //           access.Static(),
  //           access.Public()
  //         ]
  //       )    
  //     )
  //   ); 
  // __.log().debug(_ -> _.pure(abstract_declaration));
    return abstract_declaration;
  }
}