package stx.sys.cli.application;

import stx.sys.cli.application.spec.term.PropertyDefaultSpec;
import stx.sys.cli.application.spec.term.FlagDefaultSpec;

class Spec extends SpecSlice{
  static public var instance(get,null) : SpecCtr;
  static private function get_instance(){
    return instance == null ? instance = new SpecCtr() : instance;
  }
  public function new(config:CliConfig,name:String,doc:String,opts:Cluster<OptionSpecApi>,args:Cluster<ArgumentSpec>,rest){
    super(config,name,doc,opts,args);
    this.rest = rest;
  }
  public final rest      : RedBlackMap<String,Spec>;

public function reply(){
    return SpecParser.makeI(SpecValue.makeI(this));
  }
  public function with_rest(fn : RedBlackMap<String,Spec> -> RedBlackMap<String,Spec>){
    return new Spec(this.config, this.name, this.doc, this.opts, this.args, fn(this.rest));
  }
}
class SpecCtr extends Clazz{
  public function Make(config,name,doc,opts,args,?rest:Null<CTR<SpecCtr,Map<String,Spec>>>){
    final r   = __.option(rest).map(x-> x.apply(this)).defv(new StringMap());
    final rI  = RedBlackMap.make(Comparable.String()).concat(
      r.toIterKV().toIter()
    );
    return new Spec(config,name,doc,opts,args,rI);
  }
  public function Property(name,doc,repeatable,required,?short){
    return new PropertyDefaultSpec(name,doc,repeatable,required);
  }
  public function Flag(name,doc,?short){
    return new FlagDefaultSpec(name,doc);
  }
  public function Argument(name:String,doc:String,required:Bool){
    return new ArgumentSpec(name,doc,required);
  }
  /**
   * Default Constructor
   */
  public function Config(){
    return CliConfigCtr;
  }

}