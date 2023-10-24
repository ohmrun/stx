package stx.makro.context;

class Module extends Clazz{
  #if macro
  public function getType(self:String):Upshot<HType,MakroFailure>{
    return try{
      __.accept(haxe.macro.Context.getType(self));
    }catch(e:haxe.Exception){
      __.reject(f -> f.of(E_Makro_TypeNotFound(e.message)));
    }
  }
  public function getModule(self:String):Upshot<Cluster<HType>,MakroFailure>{
    return try{
      __.accept(haxe.macro.Context.getModule(self)).map(arr -> arr.map(x -> (x:HType)));
    }catch(e:haxe.Exception){
      __.reject(f -> f.of(E_Makro_TypeNotFound(e.message)));
    }
  }
  #end
}