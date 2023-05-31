package stx.makro.type;

typedef HTFunArgDef = { t : StdMacroType, opt : Bool, name : String };

@:forward abstract HTFunArg(HTFunArgDef) from HTFunArgDef{
  public function equals(that:HTFunArg){
    return 
      this.name == that.name && 
      this.opt  == that.opt && 
      HType._.makro(this.t).getIdentity().equals(
        HType._.makro(that.t).getIdentity()
      );
  }
  public function getMoniker(){
    return HType.lift(this.t).getMoniker();
  }
}