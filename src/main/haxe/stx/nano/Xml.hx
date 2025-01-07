package stx.nano;

typedef XmlDef = std.Xml;

@:using(stx.nano.Xml.XmlLift)
@:forward abstract Xml(XmlDef) from XmlDef to XmlDef{
  static public var _(default,never) = XmlLift;
  public inline function new(self:XmlDef) this = self;
  @:noUsing static inline public function lift(self:XmlDef):Xml return new Xml(self);

  static public function parse(str:String){
    return lift(std.Xml.parse(str));
  }
  public function prj():XmlDef return this;
  private var self(get,never):Xml;
  private function get_self():Xml return lift(this);

  public function elements():Iter<stx.nano.Xml>{
    return this.elements();
  }
}
class XmlLift{
  static public inline function lift(self:XmlDef):Xml{
    return Xml.lift(self);
  }
}