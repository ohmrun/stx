package stx.makro.type;

@:forward abstract HSimpleTypeIdentifier(Moniker){
  private function new(s){
    this = s;
  }
  @:from static public function fromType(type:HType):HSimpleTypeIdentifier{
    return new HSimpleTypeIdentifier(switch(type){
      case TInst(t, [])             : type.getMoniker().fudge(); 
      default                       : throw __.fault().of(E_Makro_UnexpectedMacroCondition);
    });
  }
}