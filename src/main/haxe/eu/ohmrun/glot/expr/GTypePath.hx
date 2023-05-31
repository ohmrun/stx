package eu.ohmrun.glot.expr;

final Expr = __.glot().Expr;

class GTypePathCtr extends Clazz{
  public function Make(name:String,?pack,?sub:String,?params:CTR<GTypeParamCtr,Cluster<GTypeParam>>){
    return GTypePath.make(
      name,
      __.option(pack).defv([].imm()),
      sub,
      __.option(params).map(f -> f(Expr.GTypeParam)).defv(null)
    );
  }
  public function Ident(ident:Ident){
    return Make(ident.name,ident.pack);
  }
  public function fromIdent(ident:Ident){
    return Make(ident.name,ident.pack);
  }
  public function fromString(str:String){
    var arr   = str.split(".");
    var name  = arr.pop();
    return Make(name,arr);
  }
}
typedef GTypePathDef = {
  final name      : String;
	final pack      : Cluster<String>;
	final ?sub      : Null<String>;
  final ?params   : Cluster<GTypeParam>;
}
@:using(eu.ohmrun.glot.expr.GTypePath.GTypePathLift)
@:forward abstract GTypePath(GTypePathDef) from GTypePathDef to GTypePathDef{
    public function new(self) this = self;
  @:noUsing static public function lift(self:GTypePathDef):GTypePath return new GTypePath(self);
  @:noUsing static public function make(name,?pack,?sub,?params){
    return lift({
      name      : name,
      pack      : Wildcard.__.option(pack).defv([].imm()),
      params    : params,
      sub       : sub
    });
  }
  public function prj():GTypePathDef return this;
  private var self(get,never):GTypePath;
  private function get_self():GTypePath return lift(this);

  @:from static public function fromString(self){
    return Expr.GTypePath.fromString(self);
  }
  public function toSource():GSource{
		return Printer.ZERO.printTypePath(this);
	}
  @:to public function toComplexType(){
    return Wildcard.__.glot().Expr.GComplexType.Path(this);
  }
  @:to public function toTypeParam(){
    return toComplexType().toTypeParam();
  }
}
class GTypePathLift{
  #if macro
  static public function to_macro_at(self:GTypePath,pos:Position):TypePath{
    return @:privateAccess {
      name    : self.name,
      pack    : __.option(self.pack).map(x -> x.prj()).defv([]),
      params  : __.option(self.params).map(x -> x.map(y -> y.to_macro_at(pos)).prj()).defv([]),
      sub     : self.sub
    }
  } 
  #end
}
