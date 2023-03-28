package stx.g.lang.expr;

class GTypeDefKindCtr extends Clazz{
  static public function unit(){
    return new GTypeDefKindCtr();
  }
  private function lift(self:GTypeDefKindSum):GTypeDefKind{
    return GTypeDefKind.lift(self);
  }
  public function Enum(){
    return lift(GTDEnum);
  }
  public function Structure(){
    return lift(GTDStructure);
  }
  public function Class(?superClass : CTR<GTypePathCtr,GTypePath>, ?interfaces : CTR<GTypePathCtr,Cluster<GTypePath>>, ?isInterface, ?isFinal, ?isAbstract ){
    return lift(GTDClass(
      __.option(superClass).map(f -> f(GTypePath.__)).defv(null),
      __.option(interfaces).map(f -> f(GTypePath.__)).defv(null),
      isInterface,
      isFinal,
      isAbstract
    ));
  }
  public function Alias(t:CTR<GComplexTypeCtr,GComplexType>){
    return lift(GTDAlias(t(GComplexType.__)));
  }
  public function Abstract(tthis:CTR<GComplexTypeCtr,GComplexType>,?from:CTR<GComplexTypeCtr,Cluster<GComplexType>>,?to:CTR<GComplexTypeCtr,Cluster<GComplexType>>){
    return lift(GTDAbstract(
      __.option(tthis).map(f -> f(GComplexType.__)).defv(null),
      __.option(from).map(f -> f(GComplexType.__)).defv(null),
      __.option(to).map(f -> f(GComplexType.__)).defv(null)
    ));
  }
  public function Field(kind:CTR<GFieldTypeCtr,GFieldType>,access:CTR<GAccessCtr,Cluster<GAccess>>){
    return lift(GTDField(
      kind(GFieldType.__),
      access(GAccess.__)
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
@:using(stx.g.lang.expr.GTypeDefKind.GTypeDefKindLift)
abstract GTypeDefKind(GTypeDefKindSum) from GTypeDefKindSum to GTypeDefKindSum{
  static public var __(default,never) = new GTypeDefKindCtr();
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
  static public function to_macro_at(self:GTypeDefKind,pos:Position):TypeDefKind{
    return switch(self){
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
}
