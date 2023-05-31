package stx.om.spine.glot;

class FromGlot extends Clazz{
  public function apply(self:GExpr):Upshot<GlotSpine,OMFailure>{
    return switch(self){
      case GEObjectDecl(fields)       : 
        Upshot.bind_fold(
          fields,
          (next,memo:Cluster<Field<Void->GlotSpine>>) -> {
              return apply(next.expr).map(
                x -> Field.make(next.field,() -> x)
              ).map(memo.snoc);
          },
          [].imm()
        ).map(x -> Collate(x));
      case GEArrayDecl(values)        : 
          Upshot.bind_fold(
            values,
            (next,memo:Cluster<Void->GlotSpine>) -> apply(next).map(
              (x) -> () -> x
            ).map(memo.snoc),
            [].imm()
          ).map(Collect);
      case GEConst(GCInt(v, _))       : __.accept(Primate(PSprig(Byteal(NInt(Std.parseInt(v))))));
      case GEConst(GCFloat(v, _))     : __.accept(Primate(PSprig(Byteal(NFloat(Std.parseFloat(v))))));
	    case GEConst(GCString(v, _))    : __.accept(Primate(PSprig(Textal(v))));
      case GEConst(GCIdent('true'))   : __.accept(Primate(PBool(true)));
      case GEConst(GCIdent('false'))  : __.accept(Primate(PBool(false)));
      case GECall(e,args)             : 
        function rec(e:GExpr,memo:Array<String>):Upshot<Array<String>,OMFailure>{
          //trace(e);
          return switch(e){
            case GEField(GEConst(x),f)  : __.accept(memo.concat([x.canonical(),f]));
            case GEField(e1,f)          : rec(e1,memo).map(
              xs -> xs.concat(memo.snoc(f))
            );
            default : __.reject(f -> f.of(E_OM('can\'t decode ${new eu.ohmrun.glot.Printer().printExpr(e)}')));
          }
        }
        rec(e,[]).map(arr -> arr.join('.')).zip(
          Upshot.bind_fold(
            args,
            (next,memo:Array<GlotSpine>) -> {
              trace(next);
              // return switch(next){
              //   case 
              // }
              return apply(next).map(memo.snoc);
            },
            []
          )
        ).map((cp) -> Predate(tuple2(cp.fst(),cp.snd())));
      default                       : __.reject(f -> f.of(E_OM('can\'t decode ${new eu.ohmrun.glot.Printer().printExpr(self)} $self')));

    }
  }
}