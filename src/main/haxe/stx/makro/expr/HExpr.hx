package stx.makro.expr;

@:using(stx.makro.expr.HExpr.HExprLift)
@:forward abstract HExpr(StdExpr) from StdExpr{
  static public var ZERO(default,never) : HExpr  = lift( {expr : EBlock([]), pos : null } );
  static public var _(default,never) = HExprLift;
  public function new(self) this = self;
  @:noUsing static public function lift(self:StdExpr):HExpr return new HExpr(self);
  @:noUsing static public function make(expr:HExprDef,pos:Position){
    return lift({
      expr  : expr.prj(),
      pos   : pos 
    });
  }
  public function prj():StdExpr return this;
  private var self(get,never):HExpr;
  private function get_self():HExpr return lift(this);

  // @:noUsing static public function lift(self:haxe.macro.Expr):HExpr{
  //   return fromExpr(self);
  // }
  @:noUsing static public function fromExpr(self:haxe.macro.Expr):HExpr{
    return self;
  }
  @:noUsing static public function mark(pos:Position):HExpr{
    return HExprDef.MARK.to_macro_at(pos);
  }
  @:noUsing static public function unit(pos:Position):HExpr{
    return HExprDef.ZERO.to_macro_at(pos);
  }  
  #if macro
  @:noUsing static public function getType(self:HExpr):HType{
    return HType.lift(Context.typeof(self.toExpr()));
  }
  #end
  static public function ref(str:String,pos:Position):HExpr{
    return lift(
      {
        pos : pos,
        expr : EConst(CIdent(str))
      }
    );
  }
  public inline function toExpr() return this;

  public function show(){
    var printer = new haxe.macro.Printer();
    return printer.printExpr(this);
  }
  public var to_macro_at(get,never):HExprDef;
  public function get_to_macro_at():HExprDef{
    return HExprDef.lift(this.expr);
  }
}

class HExprLift{
  //static public var _(default,never) = new LiftHExpr();

  @:noUsing static function lift(self:haxe.macro.Expr):HExpr return HExpr.lift(self);

  static public function toFunction(self:HExpr):Option<Function>{
    return switch(self.prj().expr){
      case EFunction(_,f) : __.option(f);
      default             : None;
    }
  }
  /**
    Creates getter only properties of the underlying type for Abstracts.
  **/
  static public function shim(self:Type,pos:Position):Upshot<Cluster<StdField>,MakroTypeFailure>{
    return switch(self){
      case TMono(t)               : __.reject(__.fault().of(E_MakroType_UnexpectedMono));
      case TEnum(t,params)        : __.reject(__.fault().of(E_MakroType_UnexpectedEnum));
      case TType(t,params)        : __.reject(__.fault().of(E_MakroType_UnexpectedTDef(t.get())));
      case TInst(_,_) | TAnonymous(_) | TAbstract(_)             :
       final fields = HType.lift(self).fields;
       final result = fields.map_filter(
          (f:ClassField) -> f.isPublic.if_else(
            () -> switch(f.kind){
              case StdFieldKind.FVar(get,_)   : switch(get){
                case AccNo | AccNever : None;
                default : 
                  Some(HField.make(
                    f.name,
                    HFieldType.FProp(
                      PAccFn,
                      PAccNever,
                      HComplexType.lift(haxe.macro.TypeTools.toComplexType(f.type)),
                      HExprDef.EFunction(
                        HFunction.make([],null,
                          HExprDef.EReturn(
                              HExprDef.EField(
                                HConstant.CIdent('this').to_macro_at(pos).prj(),
                                f.name
                              ).to_macro_at(pos)
                          ).to_macro_at(pos)
                        ).prj()
                      ).to_macro_at(pos)
                    ),
                    pos,
                    [HAccess.Public()]
                  ));
              }
              default                         : None;
            },
            () -> None
          )
      );
      //final p = new Printer();
      // for(x in result){
      //   trace(p.printField(x.prj()));
      // }
      __.accept(result);
      case TFun(args, ret)        : __.reject(__.fault().of(E_MakroType_UnexpectedTFun));
      case TDynamic(t)            : __.reject(__.fault().of(E_MakroType_DynamicUnsupported));
      case TLazy(f)               : __.reject(__.fault().of(E_MakroType_UnexpectedLazy));
    }
    //return throw UNIMPLEMENTED; 
  }
}
class LiftHExpr extends Clazz{
  static public function makro(e:haxe.macro.Expr):HExpr{
    return HExpr.lift(e);
  }
  static public var Constant = {
    toHExpr : (self:Constant,?p:Position) -> stx.makro.expr.lift.LiftConstantToHExpr.toHExpr(self,p)
  }
  static public var MethodRef = {
    toHExpr : (self:MethodRef,?p:Position) -> stx.makro.expr.lift.LiftMethodRefToHExpr.toHExpr(self,p)
  }
  static public var Module = {
    toHExpr : (self:Module,?p:Position) -> stx.makro.expr.lift.LiftModuleToHExpr.toHExpr(self,p)
  }
}