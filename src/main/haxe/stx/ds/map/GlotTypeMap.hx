package stx.ds.map;

import haxe.macro.Expr;
using stx.Ds;
using eu.ohmrun.Glot;

typedef GlotTypeMapDef = RedBlackMap<GExpr,Type>;

@:using(stx.ds.map.GlotTypeMap.GlotTypeMapLift)
@:forward @:transitive abstract GlotTypeMap(GlotTypeMapDef) from GlotTypeMapDef to GlotTypeMapDef{
  
  // static public function unit(){
  //   return new GlotTypeMap(RedBlackMap.make())
  // }
  static public var _(default,never) = GlotTypeMapLift;
  public inline function new(self:GlotTypeMapDef) this = self;
  @:noUsing static inline public function lift(self:GlotTypeMapDef):GlotTypeMap return new GlotTypeMap(self);

  public function prj():GlotTypeMapDef return this;
  private var self(get,never):GlotTypeMap;
  private function get_self():GlotTypeMap return lift(this);
}
class GlotTypeMapLift{
  static public inline function lift(self:GlotTypeMapDef):GlotTypeMap{
    return GlotTypeMap.lift(self);
  }
}