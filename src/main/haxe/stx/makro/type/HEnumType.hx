package stx.makro.type;

final __type = __.makro().type;
final __expr = __.makro().expr;

class HEnumTypeCtr extends Clazz{
  public function Make(
    pack,
    name:String,
    module,
    constructs:CTR<HEnumFieldCtr,Map<String,HEnumField>>,
    isPrivate,
    isExtern,
    params:CTR<HTypeParameterCtr,Cluster<HTypeParameter>>,
    meta:CTR<HMetaAccessCtr,HMetaAccess>,
    doc,
    exclude,
    pos:CTR<stx.makro.expr.HPosition.HPositionCtr,stx.makro.expr.HPosition>){

    final constructors  = constructs.apply(__type.HEnumField);
    final names         = constructors.map(x -> x.name).prj();

    return HEnumType.make(
      pack,
      name,
      module,
      names,
      constructors,
      isPrivate,
      isExtern,
      params.apply(__type.HTypeParameter).prj(),
      meta.apply(__type.HMetaAccess),
      doc,
      exclude,
      pos.apply(__expr.HPosition)
    );
  }
}
@:using(stx.makro.type.HEnumType.HEnumTypeLift)
@:forward abstract HEnumType(StdEnumType) from StdEnumType{
  @:noUsing static public function lift(self:StdEnumType) return new HEnumType(self);
  @:noUsing static public function make(pack,name,module,names,constructs,isPrivate,isExtern,params,meta,doc,exclude,pos){
    return lift({
      pack : pack,
      name : name,
      module : module,
      names : names,
      constructs : constructs,
      pos : pos,
      isPrivate : isPrivate,
      isExtern : isExtern,
      params : params,
      meta : meta,
      doc : doc,
      exclude : exclude,
    });
  }
  static public var _(default,never) = HEnumTypeLift;
  public function new(self){
    this = self;
  }
  public function prj(){
    return this;
  }
}
class HEnumTypeLift{  
  @:noUsing static public function getMoniker(e:HEnumType):Moniker{
    return stx.makro.type.core.Moniker.lift({
      name    : e.name,
      pack    : Way.lift(e.pack),
      module  : new haxe.io.Path(e.module)
    });
  }
  static public function toBaseType(self:HEnumType):BaseType{
    return self.prj();
  }
  @:noUsing static public function getConstructors(e:HEnumType):Map<String,HTFunArgArray>{
    return e.constructs.toArrayKV().fold(
      (next,memo:Map<String,HTFunArgArray>) -> next.into(
        (k,v) -> switch v.type {
          case TFun(args,_) : 
            memo.set(k,(args:HTFunArgArray));
            memo;
          default           : 
            memo.set(k,[]);
            memo;
        }
      ),
      __.nano().Map().String()
    );
  } 
  @:noUsing static public function constructorHandler<U>(e:HEnumType,handler:Array<HTFunArg>->U):StringMap<U>{
    var next = new StringMap();
    for(key => val in e.constructs){
      switch(val.type){
        case TFun(args,_)     : next.set(key,handler(args));
        default               : next.set(key,handler([]));
      }
    }
    return next;
  }   
  @:noUsing static public function constructorOf(e:HEnumType,name:String){
    var out = None;
    for(key => val in e.constructs){
      if(key == name){
        out = Some(val.type);
      }
    }
    return out;
  }
}