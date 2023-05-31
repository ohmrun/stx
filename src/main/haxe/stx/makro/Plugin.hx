package stx.makro;

using stx.Nano;

#if macro
using StringTools;


import haxe.macro.Compiler;
import haxe.macro.Type;
import haxe.macro.ExprTools;
import haxe.macro.MacroStringTools;

import haxe.macro.Type as StdMacroType;
#end
using stx.makro.Logging;  
/**
 * Any class with metadata starting `stx.makro` will be used in the following way:
 * e.g in `stx.makro.Test.use(__,1)`
 * `stx.makro.Test` is constructed with no parameters
 * `use` is called with the `haxe.macro.Type` where the metadata is found denoted by `__`, and 1
 * so the class should look like
 * ```haxe
 * package stx.makro;
 * class Test{
 *  public function use(type:haxe.macro.Type,int:Int){
 *    ///...
 *  }
 * }
 * ```
 */
class Plugin{
  static public macro function use(){
    //#if (test||debug)
    __.log().info('stx.makro.Plugin.use');
    //#end
    var args          = Sys.args();
    Context.onAfterTyping(module);
    return macro {};
  }
  #if macro
  static function module(arr:Cluster<ModuleType>){
    //__.log().trace('onAfterTyping');
    // #if make
    for(module in arr){
      apply(module);
    }
    // #end
  }
  static function apply(self:ModuleType){

    final v = switch(self){
      case TClassDecl(c)     : Some(TInst(c,[]));
      case TEnumDecl(e)      : Some(TEnum(e,[]));
      case TTypeDecl(t)      : Some(TType(t,[]));
      case TAbstract(a)      : Some(TAbstract(a,[]));
      default                : None;
    }
    for (t in v){
      final type    = HType._.makro(t);
      final base    = __.option(type.getBaseType()).force();
      final entries = base.meta.get().filter(
          (mde) -> mde.name.startsWith(":stx.makro")
      );
      //trace(entries);
      for(entry in entries){
        __.log().trace("here");
        var body      = entry.name.split(".");
            body[0]   = body[0].substr(1);
        __.log().trace(_ -> _.thunk(() -> '$body'));
        var method    = body.pop();
        var params    = entry.params.map(parameter.bind(type)).prj();
        var path      = body.join(".");
        
        __.log().trace(body.join("."));
        var clazz     = stx.alias.StdType.resolveClass(path);
        __.log().trace(_ -> _.pure(clazz));
        if(clazz == null){
          #if (test || debug)
            #if (!stfu)
              Context.warning('${path.split(".").last().fudge()} not imported. Anything relying on "${path}#${method}($params)" will fail.',Context.currentPos());
            #end
          #end
        }
        __.log().trace(_ -> _.thunk(() -> '$clazz'));
        for (clazz in __.option(clazz)){
          var value       = std.Type.createInstance(clazz,[]);
          __.log().trace(_ -> _.thunk(() -> '$value'));
          __.log().trace('$method');
          var method_ref  : haxe.Constraints.Function = std.Reflect.field(value,method);
          __.log().trace(_ -> _.thunk(() -> '$method_ref'));
          Reflect.callMethod(value,method_ref,params);
        }
      }
    }
  }
  static function parameter(type:HType,e:Expr):Dynamic{
    return switch(e.expr){
      case EConst(CIdent("__")) : type;
      default                   : ExprTools.getValue(e);
    }
  }
  #end
}