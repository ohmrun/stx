package stx.makro.expr;

final Expr = __.makro().expr;

class HExprdefCtr extends Clazz{
  public inline function Const(c:CTR<HConstantCtr,HConstant>){
    return Constant(c);
  }
  public function Constant(c:CTR<HConstantCtr,HConstant>){
    return HExprdef.lift(EConst(c(Expr.HConstant)));
  } 
  public function Path(string:String,?pos:CTR<HPositionCtr,HPosition>){
    final pos = __.option(pos).map(x -> x.apply(Expr.HPosition)).defv(new HPositionCtr().Make());

    final parts = string.split(".");
    return parts.tail().lfold(
        (next:String,memo:Expr) -> this.Field(
          _ -> memo.toHExpr(),
          next        
        ).toHExpr(pos.prj()).prj(),
        this.Const(_ -> _.Ident(parts.head().fudge())).toHExpr(pos.prj()).prj()
      );
  }
  public function FieldPath(name:String,pack:Array<String>,?pos:CTR<HPositionCtr,HPosition>){
    final pos   = __.option(pos).map(x -> x.apply(Expr.HPosition)).defv(new HPositionCtr().Make());
    final head  = pack.head().defv(name);

    return pack.is_defined().if_else(
      () -> pack.tail().snoc(name).lfold(
        (next:String,memo:Expr) -> this.Field(
          _ -> memo.toHExpr(),
          next        
        ).toHExpr(pos).prj(),
        this.Const(_ -> _.Ident(head)).toHExpr(pos).prj()
      ),
      () -> this.Const(_ -> _.Ident(head)).toHExpr(pos).prj()
    );
  }
  public function Array(lhs:CTR<HExprCtr,HExpr>,rhs:CTR<HExprCtr,HExpr>){
    return HExprdef.lift(EArray(lhs(Expr.HExpr).prj(),rhs(Expr.HExpr).prj()));
  }
  public function Binop(op,l:CTR<HExprCtr,HExpr>,r:CTR<HExprCtr,HExpr>){
    return HExprdef.lift(EBinop(op,l(Expr.HExpr).prj(),r(Expr.HExpr).prj()));
  }
  #if (haxe_ver > 4.205)
  public function Field(e:CTR<HExprCtr,HExpr>,field:String,?kind){
    return HExprdef.lift(EField(e(Expr.HExpr).prj(),field,kind));
  }
  #else
  public function Field(e:CTR<HExprCtr,HExpr>,field:String){
    return HExprdef.lift(EField(e(Expr.HExpr).prj(),field));
  }
  #end
  public function Parenthesis(e:CTR<HExprCtr,HExpr>){
    return HExprdef.lift(EParenthesis(e(Expr.HExpr).prj()));
  }
  public function Parens(e:CTR<HExprCtr,HExpr>){
    return HExprdef.lift(EParenthesis(e(Expr.HExpr).prj()));
  }
  public function ObjectDecl(fields:CTR<HObjectFieldCtr,Array<HObjectField>>){
    return HExprdef.lift(EObjectDecl(fields(Expr.HObjectField)));
  }
  public function ArrayDecl(values:CTR<HExprCtr,HExprArray>){
    return HExprdef.lift(EArrayDecl(values(Expr.HExpr).toExprArray()));
  }
  public function Call(e:CTR<HExprCtr,HExpr>,params:CTR<HExprCtr,HExprArray>){
    return HExprdef.lift(ECall(e(Expr.HExpr).prj(),params(Expr.HExpr).toExprArray()));
  }
  public function Nu(t:CTR<HTypePathCtr,HTypePath>,params:CTR<HExprCtr,HExprArray>){
    return HExprdef.lift(ENew(t(Expr.HTypePath).prj(),params(Expr.HExpr).toExprArray()));
  }
  public function Unop(op,postFix,e:CTR<HExprCtr,HExpr>){
    return HExprdef.lift(EUnop(op,postFix,e(Expr.HExpr).prj()));
  }
  public function Vars(vars:CTR<HVarCtr,Array<HVar>>){
    return HExprdef.lift(EVars(vars(Expr.HVar)));
  }
  public function Function(f:CTR<HFunctionCtr,HFunction>,?kind){
    return HExprdef.lift(EFunction(kind,f(Expr.HFunction)));
  }
  public function Block(exprs:CTR<HExprCtr,HExprArray>){
    return HExprdef.lift(haxe.macro.Expr.ExprDef.EBlock(exprs.apply(Expr.HExpr).toExprArray()));
  }
  public function For(it:CTR<HExprCtr,HExpr>,expr:CTR<HExprCtr,HExpr>){
    return HExprdef.lift(EFor(it(Expr.HExpr).prj(),expr(Expr.HExpr).prj()));
  }
  public function If(it:CTR<HExprCtr,HExpr>,expr:CTR<HExprCtr,HExpr>,?eelse:CTR<HExprCtr,HExpr>){
    return HExprdef.lift(EIf(it(Expr.HExpr).prj(),expr(Expr.HExpr).prj(),__.option(eelse).map(f -> f(Expr.HExpr).prj()).defv(null)));
  }
  public function While(econd:CTR<HExprCtr,HExpr>,expr:CTR<HExprCtr,HExpr>,normalWhile){
    return HExprdef.lift(EWhile(econd(Expr.HExpr).prj(),expr(Expr.HExpr).prj(),normalWhile));
  }
  public function Switch(e:CTR<HExprCtr,HExpr>,cases:CTR<HCaseCtr,Array<HCase>>,?edef:CTR<HExprCtr,HExpr>){
    return HExprdef.lift(
      ESwitch(
        e(Expr.HExpr).prj(),
        cases(Expr.HCase).map(x -> x.prj()),
        __.option(edef).map( f -> f.apply(Expr.HExpr).prj()).defv(null)
      )
    );
  }
  public function Try(e:CTR<HExprCtr,HExpr>,catches:CTR<HCatchCtr,Array<HCatch>>){
    return HExprdef.lift(ETry(e(Expr.HExpr).prj(),catches(Expr.HCatch).map(x -> x.prj())));
  }
  public function Return(?e:CTR<HExprCtr,HExpr>){
    return HExprdef.lift(EReturn(__.option(e).map(f -> f(Expr.HExpr).prj()).defv(null)));
  }
  public function Break(){
    return HExprdef.lift(haxe.macro.Expr.ExprDef.EBreak);
  }
  public function Continue(){
    return HExprdef.lift(haxe.macro.Expr.ExprDef.EContinue);
  }
  public function Untyped(e:CTR<HExprCtr,HExpr>){
    return HExprdef.lift(EUntyped(e(Expr.HExpr).prj()));
  }
  public function Throw(e:CTR<HExprCtr,HExpr>){
    return HExprdef.lift(EThrow(e(Expr.HExpr).prj()));
  }
  public function Cast(e:CTR<HExprCtr,HExpr>,t:CTR<HComplexTypeCtr,HComplexType>){
    return HExprdef.lift(
      ECast(
        e(Expr.HExpr).prj(),
        __.option(t).map(f -> f(Expr.HComplexType)).defv(null))
    );
  }
  public function Ternary(cond:CTR<HExprCtr,HExpr>,eif:CTR<HExprCtr,HExpr>,eelse:CTR<HExprCtr,HExpr>){
    return HExprdef.lift(
      ETernary(
        cond(Expr.HExpr).prj(),
        eif(Expr.HExpr).prj(),
        eelse(Expr.HExpr).prj()
      )
    );
  }
  public function CheckType(e:CTR<HExprCtr,HExpr>,t:CTR<HComplexTypeCtr,HComplexType>){
    return HExprdef.lift(ECheckType(e(Expr.HExpr).prj(),t(Expr.HComplexType).prj()));
  }
  public function Meta(s:CTR<HMetadataEntryCtr,HMetadataEntry>,e:CTR<HExprCtr,HExpr>){
    return HExprdef.lift(EMeta(s(Expr.HMetadataEntry).prj(),e(Expr.HExpr).prj()));
  }
  public function Is(e:CTR<HExprCtr,HExpr>,t:CTR<HComplexTypeCtr,HComplexType>){
    return HExprdef.lift(EIs(e(Expr.HExpr).prj(),t(Expr.HComplexType).prj()));
  }
}
typedef HExprdefDef = StdExprDef;
//@:using(stx.makro.expr.HExprdef.HExprdefLift)
@:forward abstract HExprdef(StdExprDef){
  static public var _(default,never) = HExprdefLift;
  static public var MARK(default,null) = mark();
  static public var ZERO(default,null) = unit();
  
  @:noUsing static public function lift(self:StdExprDef):HExprdef{
    return new HExprdef(self);
  }
  static public function unit():HExprdef{
    return lift(StdExprDef.EConst(CIdent('null')));
  }
  static public function mark():HExprdef{
    return lift(StdExprDef.EConst(CIdent('$')));
  }
  
  @:noUsing static public function EField(e:HExpr,f:String):HExprdef{
    return lift(StdExprDef.EField(e.toExpr(),f));
  }
  @:noUsing static public function EBlock(arr:HExprArray):HExprdef{
    return lift(StdExprDef.EBlock(arr.toExprArray()));
  }
  @:noUsing static public function EFunction(f:HFunction,?kind:FunctionKind){
    return lift(StdExprDef.EFunction(kind, f.prj()));
  }
  @:noUsing static public function EReturn(?e:HExpr){
    return lift(StdExprDef.EReturn(__.option(e).map(e -> e.prj()).defv(null)));
  }
  // @:noUsing static public function ENew(t:HTypePath,?params:Array<Expr>){
  //   return lift(StdExprDef.ENew(t.prj(),__.option(params).map(x -> x.prj()).def([]));)
  // }

  public function new(self) this = self;
  public function toHExpr(pos:Position):HExpr{
    return HExpr.make(lift(this),pos);
  }
  public function to_macro_at(pos){
    return toHExpr(pos);
  }
  public function prj(){
    return this;
  }
  public function toExprdef():HExprdefDef{
    return this;
  }
}
class HExprdefLift{

}