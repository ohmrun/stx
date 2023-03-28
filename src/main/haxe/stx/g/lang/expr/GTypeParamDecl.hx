package stx.g.lang.expr;

class GTypeParamDeclCtr extends Clazz{
  static public function unit(){
    return new GTypeParamDeclCtr();
  }
  public function Make(name:String,?constraints:CTR<GComplexTypeCtr,Cluster<GComplexType>>,?params:CTR<GTypeParamDeclCtr,Cluster<GTypeParamDecl>>,meta:CTR<GMetadataEntryCtr,GMetadata>,?defaultType:CTR<GComplexTypeCtr,GComplexType>){
    return GTypeParamDecl.make(
      name,
      __.option(constraints).map(f -> f(GComplexType.__)).defv(null),
      __.option(params).map(f -> f(GTypeParamDecl.__)).defv(null),   
      __.option(meta).map(f -> f(GMetadataEntry.__)).defv(null),
      __.option(defaultType).map(f -> f(GComplexType.__)).defv(null)    
    );
  }
}
typedef GTypeParamDeclDef = {
	final name          : String;
	final ?constraints  : Cluster<GComplexType>;
	final ?params       : Cluster<GTypeParamDecl>;
	final ?meta         : GMetadata;
  var   ?defaultType  : Null<GComplexType>;
}
@:using(stx.g.lang.expr.GTypeParamDecl.GTypeParamDeclLift)
@:forward abstract GTypeParamDecl(GTypeParamDeclDef) from GTypeParamDeclDef to GTypeParamDeclDef{
  static public var __(default,never) = new GTypeParamDeclCtr();
  public function new(self) this = self;
  @:noUsing static public function lift(self:GTypeParamDeclDef):GTypeParamDecl return new GTypeParamDecl(self);
  @:noUsing static public function make(name:String,?constraints:Cluster<GComplexType>,?params:Cluster<GTypeParamDecl>,?meta,defaultType){
    return lift({
      name        : name,
      constraints : constraints,
      params      : params,
      meta        : meta,
      defaultType : defaultType 
    });
  }
  public function prj():GTypeParamDeclDef return this;
  private var self(get,never):GTypeParamDecl;
  private function get_self():GTypeParamDecl return lift(this);

  public function toSource():GSource{
		return Printer.ZERO.printTypeParamDecl(this);
	}
}
class GTypeParamDeclLift{
  static public function to_macro_at(self:GTypeParamDecl,pos:Position):TypeParamDecl{
    return {
      name        : self.name,
      constraints : __.option(self.constraints).map(x -> x.map(y -> y.to_macro_at(pos)).prj()).defv([]),
      params      : __.option(self.params).map(x -> x.map(y -> y.to_macro_at(pos)).prj()).defv([]),
      meta        : __.option(self.meta).map(x -> x.map(y -> y.to_macro_at(pos)).prj()).defv([]),
      #if (haxe_ver > 4.205) 
      defaultType : __.option(self.defaultType).map(x -> x.to_macro_at(pos)).defv(null)
      #end
    };
  }
}