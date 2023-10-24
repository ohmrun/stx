package stx.makro.type;

class HConstructorCls{
  private final face        : HFace;
  public  final name        : Option<String>;

  public function new(face,name){
    this.face = face;
    this.name = name;
  }
  // public var convention(get,null):HConstructorConvention;
  // private function get_convention():HConstructorConvention{
  //   return face.get_convention();
  // }
  // public function get_members(){
    
  // }
  // public var members(get,never) : Cluster<ClassField>;
}
@:using(stx.makro.type.HConstructor.HConstructorLift)
abstract HConstructor(HConstructorCls) from HConstructorCls to HConstructorCls{
  static public var _(default,never) = HConstructorLift;
  public inline function new(self:HConstructorCls) this = self;
  @:noUsing static inline public function lift(self:HConstructorCls):HConstructor return new HConstructor(self);
  @:noUsing static inline public function make(face:HFace,name:Option<String>):HConstructor return new HConstructor(new HConstructorCls(face,name));

  public function prj():HConstructorCls return this;
  private var self(get,never):HConstructor;
  private function get_self():HConstructor return lift(this);
}
class HConstructorLift{
  static public inline function lift(self:HConstructorCls):HConstructor{
    return HConstructor.lift(self);
  }
}

