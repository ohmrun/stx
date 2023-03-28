package stx.di;

import haxe.macro.Expr;
import haxe.macro.Type;
import haxe.macro.Context;

import stx.di.DI;
import stx.di.Util;

class Injectors{
  static var printer = new haxe.macro.Printer();
  #if macro
    @:noUsing static public function run(fn:Expr):Expr {
      var self    = macro @:privateAccess stx.Dependencies.instance.deferred.injector();
      var printer = new haxe.macro.Printer();
      function get_id(type:haxe.macro.Type):String{
        var id = printer.printComplexType(
          haxe.macro.TypeTools.toComplexType(
            haxe.macro.Context.follow(type,true)
          )
        );
        return id;
      }
      function rec(t:Type) {
        //trace(t);
        return switch (t) {
          case TFun(args, ret):
            var callArgs = [];
            for (arg in args) {
              var id      = get_id(arg.t);
              var access  = macro(@:privateAccess $self.di.resolver);
              var access0 = macro(@:privateAccess $self.di);
              var expr = macro $access($v{id})($access0); // always resolving on the head. late binding the context.
              callArgs.push(expr);
            }
            macro $fn($a{callArgs});
          case TAbstract(t, _):
            rec(t.get().type);
          default:
            throw new Error('"fn should be a function"', fn.pos);
            null;
        }
      }
      return macro { 
        ${rec(haxe.macro.Context.typeof(fn))};
      }
    }
    #end
    inline static public macro function add(self:haxe.macro.Expr, factory:haxe.macro.Expr, force:Bool = false):haxe.macro.Expr {
      function get_id(type:haxe.macro.Type):String{
        var id = printer.printComplexType(
          haxe.macro.TypeTools.toComplexType(
            haxe.macro.Context.follow(type,true)
          )
        );
        return id;
      }
      function rec(t:haxe.macro.Type){
          return switch(t){
            case haxe.macro.Type.TFun(args, ret):
              var id = get_id(ret);
              var callArgs = [];
              for (arg in args) {
                var id    = get_id(arg.t);
                //trace('ID = $id');
                var expr  = macro(@:privateAccess $self.resolver)($v{id});
                callArgs.push(expr);
              }
              var fn = macro function(di:stx.di.DI) {
                return $a{callArgs}.map(function(f) {
                    return f(di);
                  });
              }
              var access = macro(@:privateAccess $self._add);
              //trace(id);
              var out = macro $access($v{id}, function(di) {
                var values = $fn(di);
                // stx.di.Util.print('_run $id');
                return Reflect.callMethod(null, $factory, values);
              }, $v{force});
              // DI.print( new haxe.macro.Printer().printExpr(out));
              out;
            case haxe.macro.Type.TAbstract(t,_):
              rec(t.get().type);
            default:
              throw new Error("Factory should be a function", factory.pos);
          }
        }
        var type    = haxe.macro.Context.typeof(factory);
        var printer = new haxe.macro.Printer();
        var ct      = haxe.macro.TypeTools.toComplexType(type);
        var string  = printer.printComplexType(ct);
        //trace(string);
        return rec(type);
      }
}