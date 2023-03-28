
package stx.makro.pack;

#if macro
class MetadataExtractor<C>{
  private var source : Type;
  private var target : Type;

  public function new(source,target){
    this.source = source;
    this.target = target;
  }
  function react(arr:Array<Type>){
    __.log().trace({ target : target, source : src() });
    var registered  = apply(arr);
        target.makro().getBaseType().meta.add(
          target.getBaseType().getModule().toString(),
          registered.map(Context.makeHExpr.bind(_,pos())).prj(),
          pos()
        );
  }
  public function upply(){
    Context.onGenerate(react);
  }
  function apply(arr:Array<Type>):Array<C>{
    return arr.filter(registered).map(
      (type) -> {
        return configure(type,opts(type));
      }
    ).mapFilter((x)->x);
  }
  public function configure(type:Type,arr:Array<Dynamic>):Option<C>{
    return None;
  }
  function src(){
    return ':${source.getBaseType().getModule().toString()}';
  }
  function registered(type:Type):Bool{
    return type.stx().getBaseType().meta.has(src());
  }
  function opts(type:Type):Array<Dynamic>{
    return  type.stx().getBaseType().meta.extract(src()).ds().map(
      (md) -> {
        return __.makro(md).stx().toObject().object().get("params");
      }
    ).fmap((x)->x);
  }
  function pos(){
    return Context.currentPos();
  }
}
#end