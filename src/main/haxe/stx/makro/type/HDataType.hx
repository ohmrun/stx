package stx.makro.type;

class HDataTypeCls{
  public final type   : HType;
  public function new(type:HType){
    this.type   = type;
  }
  // public var constructors(get,null):Cluster<HConstructor>;
  // public function get_constructors():Cluster<HConstructor>{
  //   return switch(type){
  //     case TInst(t,_)                     : [HConstructor.make(type,Some('new'))];
  //     case TType(t,_)                     : new HDataTypeCls(type.get_nearest_newable().get_constructors();
  //     case TEnum(t,_)                     : Iter.fromIterator(t.get().constructs).toCluster().map(
  //       x -> {
  //         return HConstructor.make(x.type,Some(x.name));
  //       }
  //     );
  //     case TAbstract(t,_)                 : [HConstructor.make(type,Some('new'))];
  //     default                             : [HConstructor.make(type,None)];
  //   }
  // }
}
@:using(stx.makro.type.HDataType.HDataTypeLift)
@:forward abstract HDataType(HDataTypeCls) from HDataTypeCls to HDataTypeCls{
  static public var _(default,never) = HDataTypeLift;
  public inline function new(self:HDataTypeCls) this = self;
  @:noUsing static inline public function lift(self:HDataTypeCls):HDataType return new HDataType(self);

  public function prj():HDataTypeCls return this;
  private var self(get,never):HDataType;
  private function get_self():HDataType return lift(this);
}
class HDataTypeLift{
  static public inline function lift(self:HDataTypeCls):HDataType{
    return HDataType.lift(self);
  }
}

