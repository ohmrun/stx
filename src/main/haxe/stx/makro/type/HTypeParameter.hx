package stx.makro.type;

@:forward abstract HTypeParameter(Module){
  private function new(s){
    this = s;
  }
  @:from static public function fromType(type:HType):HTypeParameter{
    return new HTypeParameter(switch(type){
      case TInst(t, [])             : type.getModule().fudge(); 
      default                       : throw __.fault().of(E_Makro_UnexpectedMacroCondition);
    });
  }
}