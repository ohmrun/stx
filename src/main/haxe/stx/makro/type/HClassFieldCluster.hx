package stx.makro.type;

typedef HClassFieldClusterDef = Cluster<HClassField>;

@:using(stx.makro.type.HClassFieldCluster.HClassFieldClusterLift)
@:forward @:transitive abstract HClassFieldCluster(HClassFieldClusterDef) from HClassFieldClusterDef to HClassFieldClusterDef{
  static public var _(default,never) = HClassFieldClusterLift;
  public inline function new(self:HClassFieldClusterDef) this = self;
  @:noUsing static inline public function lift(self:HClassFieldClusterDef):HClassFieldCluster return new HClassFieldCluster(self);

  public function prj():HClassFieldClusterDef return this;
  private var self(get,never):HClassFieldCluster;
  private function get_self():HClassFieldCluster return lift(this);

  @:to public function toIterable():Iterable<HClassField>{
    return this;
  }
  // public function pretty(){
  //   return this.map(x -> )
  // }
}
class HClassFieldClusterLift{
  static public inline function lift(self:HClassFieldClusterDef):HClassFieldCluster{
    return HClassFieldCluster.lift(self);
  }
}