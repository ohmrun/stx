package stx.makro.expr;

final __type = __.makro().type;
final __expr = __.makro().expr;


/**
 * Constructor Class for HTypeDefKind
 */
class HTypeDefKindCtr extends Clazz{
  public function Structure(){
    return HTypeDefKind.lift(TDStructure);
  }
  public function Enum(){
    return HTypeDefKind.lift(TDEnum);
  }
  public function Class(?super_class:CTR<HTypePathCtr,HTypePath>,?interfaces:CTR<HTypePathCtr,Cluster<HTypePath>>,?is_interface:Bool,?is_final:Bool,?is_abstract:Bool){
    final interfaces  = __.option(interfaces).map(x -> x.apply(__expr.HTypePath)).defv(null);
    final super_class = __.option(super_class).map(x -> x.apply(__expr.HTypePath)).defv(null);
    return HTypeDefKind.lift(TDClass(super_class,__.option(interfaces).defv([].imm()).prj(),is_interface,is_final,is_abstract));
  }
  public function Alias(ct:stx.makro.expr.HComplexType):HTypeDefKind{
    return HTypeDefKind.lift(TDAlias(ct));
  }
  static public function Abstract(?thiz:stx.makro.expr.HComplexType,?from:Cluster<stx.makro.expr.HComplexType>,?to:Cluster<stx.makro.expr.HComplexType>):HTypeDefKind{
    return HTypeDefKind.lift(TDAbstract(thiz,from.prj(),to.prj()));
  }

}
typedef HTypeDefKindDef = StdTypeDefKind;
/**
  enum TypeDefKind {
    TDEnum;
    TDStructure;
    TDClass( ?superClass : TypePath, ?interfaces : Array<TypePath>, ?isInterface : Bool, ?isFinal : Bool );
    TDAlias( t : ComplexType ); // ignore TypeDefinition.fields
    TDAbstract( tthis : Null<ComplexType>, ?from : Array<ComplexType>, ?to: Array<ComplexType> );
  }
**/
@:forward abstract HTypeDefKind(StdTypeDefKind) from StdTypeDefKind to StdTypeDefKind{
  public function new(self) this = self;
  @:noUsing static public function lift(self:StdTypeDefKind):TypeDefKind return new HTypeDefKind(self);
  @:from static public function fromHComplexType(self:stx.makro.expr.HComplexType):HTypeDefKind{
    return TDAlias(self);
  }
  public function prj():StdTypeDefKind return this;
  private var self(get,never):TypeDefKind;
  private function get_self():TypeDefKind return lift(this);
}