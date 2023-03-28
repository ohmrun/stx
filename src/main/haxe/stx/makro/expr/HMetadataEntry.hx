package stx.makro.expr;

import haxe.macro.ExprTools;

abstract HMetadataEntry(StdMetadataEntry) from StdMetadataEntry{
  public function new(self){
    this = self;
  }
  #if macro
  public function toObject():Dynamic{
    return {
      name    : this.name,
      params  : this.params.map(ExprTools.getValue)
    };
  }
  #end
}