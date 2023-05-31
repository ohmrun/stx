package stx.makro.expr;

final Expr = __.makro().expr;

class HTypePathCtr extends Clazz{
  public function Make(name:String,?pack,?sub:String,?params:CTR<HTypeParamCtr,Array<HTypeParam>>){
    return HTypePath.make(
      name,
      __.option(pack).defv([]),
      __.option(params).map(f -> f(Expr.HTypeParam)).defv(null),
      sub
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

typedef HTypePathDef = StdTypePath;

@:forward abstract HTypePath(StdTypePath) from StdTypePath to StdTypePath{
  public function new(self) this = self;
  @:noUsing static public function lift(self:StdTypePath):HTypePath return new HTypePath(self);

  public function prj():StdTypePath return this;
  private var self(get,never):TypePath;
  private function get_self():TypePath return lift(this);

  @:noUsing static public function make(name,pack,?params,?sub){
    return lift({
      name    : name,
      pack    : pack,
      params  : params,
      sub     : sub
    });
  }
}