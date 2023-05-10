package eu.ohmrun.pml.term.xml;

enum XmlDataSum{
  XPCData(str:String);
  XProcessingInstruction(str:String);
  XComment(str:String);
  XCData(str:String);
  XDocType(str:String);
}

@:using(eu.ohmrun.pml.term.xml.XmlData.XmlDataLift)
abstract XmlData(XmlDataSum) from XmlDataSum to XmlDataSum{
  static public var _(default,never) = XmlDataLift;
  public function new(self) this = self;
  @:noUsing static public function lift(self:XmlDataSum):XmlData return new XmlData(self);

  public function prj():XmlDataSum return this;
  private var self(get,never):XmlData;
  private function get_self():XmlData return lift(this);
  public function toString(){
    return _.toString(this);
  }
}
class XmlDataLift{
  static public function toString(self:XmlData){
    return switch(self){
      case XPCData(str)                 : '"$str"';
      case XProcessingInstruction(str)  : '"$str"';
      case XComment(str)                : '"$str"';
      case XCData(str)                  : '"$str"';
      case XDocType(str)                : '"$str"';
    }
  }
}