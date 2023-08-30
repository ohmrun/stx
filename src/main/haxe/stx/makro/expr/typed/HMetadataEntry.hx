package stx.makro.expr.typed;

import haxe.macro.ExprTools;

final Expr = __.makro().expr;

class HMetadataEntryCtr extends Clazz{
  public function Make(name:String,params:CTR<HExprCtr,HExprArray>,?pos:CTR<HPositionCtr,HPosition>){
    pos = __.option(pos).map(x -> pos.apply(Expr.HPosition)).defv(new HPositionCtr().Make()); 
    return HMetadataEntry.make(name,params.apply(Expr.HExpr),pos.apply(Expr.HPosition));
  }
}
typedef HMetadataEntryDef = StdMetadataEntry;

@:forward abstract HMetadataEntry(StdMetadataEntry) from StdMetadataEntry{
  public function new(self){
    this = self;
  }
  @:noUsing static public function lift(self:HMetadataEntryDef):HMetadataEntry{
    return new HMetadataEntry(self);
  }
  @:noUsing static public function make(name:String,params:HExprArray,pos:HPosition){
    return lift({name : name, params : params.toExprArray(), pos : pos });
  }
  #if macro
  public function toObject():Dynamic{
    return {
      name    : this.name,
      params  : this.params.map(ExprTools.getValue)
    };
  }
  #end
  public function prj(){
    return this;
  }
}