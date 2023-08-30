package stx.makro.type;

final type = __.makro().type;

class HTypeCtr extends Clazz{
  public function Mono(ctr:CTR<HRefCtr,HRef<HType>>){
    return haxe.macro.Type.TMono(ctr.apply(type.HRef));
  }
  //public function Enum()
}