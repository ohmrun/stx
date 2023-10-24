package stx.makro.type;

#if macro
import haxe.macro.TypeTools.map;
#end
final _t = __.makro().type;

private typedef NameAndPack = {
  name : String,
  pack : Array<String>
}
class HStdType{
  #if macro
  /**
   * Workaround for https://github.com/HaxeFoundation/haxe/issues/11322
   * @param self 
   */
  static public function ensure(self:HType){
    return apply(self);
  }
  
  static public function apply(self:HType):HType{
    trace(self);
    function get_name(fn:()-> NameAndPack){
      return fn().name;
    }
    function is_named(fn:()-> NameAndPack,name:String){
      return get_name(fn) == name;
    }
    function  is_root(fn:()-> NameAndPack){
      return fn().pack.length == 0;
    }
    function is(fn,name){
      return is_named(fn,name) && is_root(fn);
    }
    function get_instance(t:HRef<ClassType>){
      return () -> {
        final type      = t.get();
              type.pack = ['std'];
        return type;
      }
    }
    function get_abstract(t:HRef<AbstractType>){
      return () -> {
        final type      = t.get();
              type.pack = ['std'];
        return type;
      }
    }
    function get_typedef(t:HRef<DefType>){
      return () -> {
        final type      = t.get();
              type.pack = ['std'];
        return type;
      }
    }
    function make_instance_ref(get:Void->ClassType,params:Array<Type>){
      return TInst(
        _t.HRef.Make(get,() -> (get():HClassType).getIdent().canonical()),
        params
      );
    }
    function make_abstract_ref(get:Void->AbstractType,params:Array<Type>):haxe.macro.Type{
      return TAbstract(
        _t.HRef.Make(get,() -> (get():HAbstractType).getIdent().canonical()),
        params
      );
    }
    function make_typedef_ref(get:Void->HDefType,params:Array<Type>){
      return TType(
        _t.HRef.Make(get,() -> (get():HDefType).getIdent().canonical()).prj(),
        params
      );
    }
    final res = switch(self){
      case TInst(t,params) if (is(t.get,"String"))        :
        final get = get_instance(t);
        make_instance_ref(get,params.map(apply));
      case TInst(t,params) if (is(t.get,"Array"))        :
        final get = get_instance(t);
        make_instance_ref(get,params.map(apply));
      case TAbstract(t, params) if (is(t.get,"Bool")) :
        final get = get_abstract(t);
        make_abstract_ref(get,params);
      case TAbstract(t, params) if (is(t.get,"Int")) :
        final get = get_abstract(t);
        make_abstract_ref(get,params);
      case TAbstract(t, params) if (is(t.get,"Float")) :
        final get = get_abstract(t);
        make_abstract_ref(get,params);
      case TAbstract(t, params) if (is(t.get,"Null")) :
        final get = get_abstract(t);
        make_abstract_ref(get,params.map(apply));
      case TAbstract(t, params) if (is(t.get,"Single")) :
        final get = get_abstract(t);
        make_abstract_ref(get,params);
      case TType(t, params) if (is(t.get,"Map")) :
          final get = get_typedef(t);
          make_typedef_ref(get,params.map(apply));
      case TInst(t,params) if (is(t.get,"StringBuf"))        :
        final get = get_instance(t);
        make_instance_ref(get,params);
      case TAbstract(t, params) if (is(t.get,"UInt")) :
        final get = get_abstract(t);
        make_abstract_ref(get,params);
      case TAbstract(t, params) if (is(t.get,"UnicodeString")) :
        final get = get_abstract(t);
        make_abstract_ref(get,params);
      case TInst(t,params) if (is(t.get,"Xml"))        :
        final get = get_instance(t);
        make_instance_ref(get,params);
      case TAbstract(t, params) if (is(t.get,"XmlType")) :
        final get = get_abstract(t);
        make_abstract_ref(get,params);
      default : map(self,apply);
    }
    return res;    
  }
  #end
}