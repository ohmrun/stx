package stx.makro.type;

@:using(stx.makro.type.HEnumType.HEnumTypeLift)
@:forward abstract HEnumType(StdEnumType) from StdEnumType{
  @:noUsing static public function lift(self:StdEnumType) return new HEnumType(self);
  static public var _(default,never) = HEnumTypeLift;
  public function new(self){
    this = self;
  }
  public function prj(){
    return this;
  }
}
class HEnumTypeLift{  
  @:noUsing static public function getModule(e:HEnumType):Module{
    return stx.makro.core.Module.lift({
      name    : e.name,
      pack    : Way.lift(e.pack),
      module  : new haxe.io.Path(e.module)
    });
  }
  @:noUsing static public function getConstructors(e:HEnumType):Map<String,HTFunArgCluster>{
    return e.constructs.toArrayKV().fold(
      (next,memo:Map<String,HTFunArgCluster>) -> next.into(
        (k,v) -> switch v.type {
          case TFun(args,_) : 
            memo.set(k,(args:HTFunArgCluster));
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