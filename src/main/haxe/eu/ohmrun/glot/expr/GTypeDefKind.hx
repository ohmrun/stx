package eu.ohmrun.glot.expr;

final Expr = __.glot().Expr;

class GTypeDefKindCtr extends Clazz{
  public function Enum(){
    return GTypeDefKind.lift(GTDEnum);
  }
  public function Structure(){
    return GTypeDefKind.lift(GTDStructure);
  }
  public function Class(?superClass : CTR<GTypePathCtr,GTypePath>, ?interfaces : CTR<GTypePathCtr,Cluster<GTypePath>>, ?isInterface, ?isFinal, ?isAbstract ){
    return GTypeDefKind.lift(GTDClass(
      __.option(superClass).map(f -> f(Expr.GTypePath)).defv(null),
      __.option(interfaces).map(f -> f(Expr.GTypePath)).defv(null),
      isInterface,
      isFinal,
      isAbstract
    ));
  }
  public function Alias(t:CTR<GComplexTypeCtr,GComplexType>){
    return GTypeDefKind.lift(GTDAlias(t(Expr.GComplexType)));
  }
  public function Abstract(tthis:CTR<GComplexTypeCtr,GComplexType>,?from:CTR<GComplexTypeCtr,Cluster<GComplexType>>,?to:CTR<GComplexTypeCtr,Cluster<GComplexType>>){
    return GTypeDefKind.lift(GTDAbstract(
      __.option(tthis).map(f -> f(Expr.GComplexType)).defv(null),
      __.option(from).map(f -> f(Expr.GComplexType)).defv(null),
      __.option(to).map(f -> f(Expr.GComplexType)).defv(null)
    ));
  }
  public function Field(kind:CTR<GFieldTypeCtr,GFieldType>,access:CTR<GAccessCtr,Cluster<GAccess>>){
    return GTypeDefKind.lift(GTDField(
      kind(Expr.GFieldType),
      access(Expr.GAccess)
    ));
  }
}
enum GTypeDefKindSum {
	GTDEnum;
	GTDStructure;
	GTDClass( ?superClass : GTypePath, ?interfaces : Cluster<GTypePath>, ?isInterface : Bool, ?isFinal : Bool, ?isAbstract:Bool );
	GTDAlias( t : GComplexType ); // ignore TypeDefinition.fields
	GTDAbstract( tthis : Null<GComplexType>, ?from : Cluster<GComplexType>, ?to: Cluster<GComplexType> );
  GTDField(kind:GFieldType, ?access:Cluster<GAccess>);
}
@:using(eu.ohmrun.glot.expr.GTypeDefKind.GTypeDefKindLift)
abstract GTypeDefKind(GTypeDefKindSum) from GTypeDefKindSum to GTypeDefKindSum{
    public function new(self) this = self;
  @:noUsing static public function lift(self:GTypeDefKindSum):GTypeDefKind return new GTypeDefKind(self);

  public function prj():GTypeDefKindSum return this;
  private var self(get,never):GTypeDefKind;
  private function get_self():GTypeDefKind return lift(this);
  
  // public function toSource():GSource{
	// 	return Printer.ZERO.printTypeDefKind(this);
	// }
}
class GTypeDefKindLift{
  #if macro
  static public function to_macro_at(self:GTypeDefKind,pos:Position):TypeDefKind{
    return @:privateAccess switch(self){
      case GTDEnum               : TDEnum;
      case GTDStructure          : TDStructure;
      case GTDClass( superClass , interfaces , isInterface , isFinal , isAbstract ) : 
        TDClass(
          __.option(superClass).map(x -> x.to_macro_at(pos)).defv(null),
          __.option(interfaces).map(x -> x.map(y -> y.to_macro_at(pos)).prj()).defv([]),
          isInterface,
          isFinal,
          isAbstract
        );
      case GTDAlias( t ) : TDAlias(t.to_macro_at(pos));
      case GTDAbstract( tthis , from , to ) :
          TDAbstract(
            __.option(tthis).map(x -> x.to_macro_at(pos)).defv(null),
            __.option(from).map(x -> x.map(y -> y.to_macro_at(pos)).prj()).defv([]),
            __.option(to).map(x -> x.map(y -> y.to_macro_at(pos)).prj()).defv([])
          );
      case GTDField(kind, access) : 
          TDField(kind.to_macro_at(pos),access.map(x -> x.to_macro_at(pos)).prj());
    }
  }
  #end
}
