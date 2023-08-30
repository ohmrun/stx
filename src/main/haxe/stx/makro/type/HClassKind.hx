package stx.makro.type;

final __expr = __.makro().expr;
final __type = __.makro().type;

class HClassKindCtr extends Clazz{
  public function Normal(){
    return HClassKind.lift(ClassKind.KNormal);
  }
  public function TypeParameter(constraints:CTR<HTypeCtr,Cluster<HType>>){
    return HClassKind.lift(ClassKind.KTypeParameter(constraints.apply(__type.HType).prj()));
  }
  public function ModuleFields(module){
    return HClassKind.lift(ClassKind.KModuleFields(module));
  }
  public function Expr(expr:CTR<stx.makro.expr.HExpr.HExprCtr,stx.makro.expr.HExpr>){
    return HClassKind.lift(KExpr(expr.apply(__expr.HExpr).prj()));
  }
  public function Generic(){
    return HClassKind.lift(ClassKind.KGeneric);
  }
  public function GenericInstance(cl:CTR<HRefCtr,HRef<HClassType>>,params:CTR<HTypeCtr,Cluster<HType>>){
    return HClassKind.lift(KGenericInstance(cl.apply(__type.HRef),params.apply(__type.HType).prj()));
  }
  public function MacroType(){
    return HClassKind.lift(ClassKind.KMacroType);
  }
  public function AbstractImpl(a:CTR<HRefCtr,HRef<HAbstractType>>){
    return KAbstractImpl(a.apply(__type.HRef));
  }
	public function GenericBuild(){
    return HClassKind.lift(ClassKind.KGenericBuild);
  }
}
@:using(stx.makro.type.HClassKind.HClassKindLift)
@:forward abstract HClassKind(StdClassKind) from StdClassKind to StdClassKind{
  static public var _(default,never) = HClassKindLift;
  public inline function new(self:StdClassKind) this = self;
  static inline public function lift(self:StdClassKind):HClassKind return new HClassKind(self);

  public function prj():StdClassKind return this;
  private var self(get,never):HClassKind;
  private function get_self():HClassKind return lift(this);
}
class HClassKindLift{
  static public inline function lift(self:StdClassKind):HClassKind{
    return HClassKind.lift(self);
  }
}