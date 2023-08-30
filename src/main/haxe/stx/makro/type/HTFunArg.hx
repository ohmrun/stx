package stx.makro.type;

final __type = __.makro().type;

class HTFunArgCtr extends Clazz{
  public function Make(name:String,t:CTR<HTypeCtr,HType>,opt:Bool=false){
    return HTFunArg.make(name,t.apply(__type.HType),opt);
  }
}
typedef HTFunArgDef = { t : StdMacroType, opt : Bool, name : String };

@:forward abstract HTFunArg(HTFunArgDef) from HTFunArgDef{
  public function new(self){
    this = self;
  }
  @:noUsing static public function lift(obj){
    return new HTFunArg(obj);
  }
  @:noUsing static public function make(name,t,opt){
    return lift({
      name  : name,
      t     : t,
      opt   : opt 
    });
  }
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