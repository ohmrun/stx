package stx.makro.pack;
import stx.makro.Package;


class Equals{
  macro static public function apply(e:HExpr){
    var type = Context.typeof(e);
    trace('type: $type');
    _apply(type);
    return macro {};
  }
  #if macro
  static public function _apply(type:Type){
    return (
      function rec(ftc:Y<Monoid<EqualBuild>,Type,EqualBuild>):Monoid<EqualBuild>->Type->EqualBuild{ 
        return function(m:Monoid<EqualBuild>,type:Type){
          trace('rec $type');
          function f(t) return ftc(rec)(m,type);
          return switch (type) {
            case TAbstract(t, params):
              m.empty();
            case TEnum(t, params):
            var t   = t.get();
            var idt = type.getModule();

            var map = m.empty();
                map.set(idt,null);
            m = m.put(map);  

            for (key => val in t.constructs){
              var ts : Type = val.type;
              var idts      = ts.getModule();
              if(!map.exists(idts)){
                map = ftc(rec)(m,ts);
              }
            }
            m.empty();
            default : m.empty();
            // case TInst(t, params):
            // case TType(t, params):
            // case TFun(args, ret):
            // case TAnonymous(a):
            // case TDynamic(t):
            // case TLazy(f):
          }
        } 
      }
    )(stx.makro.body.Types.mod())(EqualBuilds.Monoid(),type);
  }
  #end
}
class EqualBuilds{
  static public function Monoid():Monoid<EqualBuild>{
    return {
      empty   : function():EqualBuild return new ObjectMap(),
      append  : function(l:EqualBuild,r:EqualBuild):EqualBuild{
        var next = new ObjectMap();
          for(key => val in l){
            next.set(key,val);
          }
          for(key => val in r){
            next.set(key,val);
          }
        return next;
      }
    }
  }
}
typedef EqualBuild = haxe.ds.ObjectMap<Module,TypeDefinition>;