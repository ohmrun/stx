package stx.makro.expr;

using stx.makro.Expr;

using stx.Show;
using stx.Test;

class Test{
  static function main(){
    final log       = __.log().global;
//          log.includes.push("**/*");    
          log.level = TRACE;
    #if boot
      boot();
    #else
      call();
    #end
  }
  static macro function boot(){
    final log         = __.log().global;
          log.includes.push("**/*");    
          log.level   = TRACE;
    __.test().run([],[]);
    return macro {};
  }
  static function call(){
    __.test().run(
      [
        //new WhatDoesReifiedFunctionDeclarationProduce(),
        //new ShimTest(),
        //new WhatPackageExprLookLikeTest(),
        new WhatEnumAbstractLookLikeTest(),
      ],[]);
  }
}
enum abstract Blum(String){
  var Hello;
}
class WhatEnumAbstractLookLikeTest extends TestCase{
  public function test(){
    var a : Blum = Hello;
    makro(a);
  }
  static macro function makro(e:Expr){
    final type = Context.typeof(e);
    switch(type){
      case TAbstract(ref,params) :
        final t = ref.get();
        trace(t);
        trace("______________________________________");
        trace(t.meta.get());
        trace("______________________________________");
        // trace(untyped t.__t);
        trace(t.impl.get());
        trace("______________________________________");
        final impl = t.impl.get();
        final fields = impl.statics.get();
        for(field in fields){
          trace(field);
          trace(field.expr());
        }
        // switch(__.option(t.impl).map(x -> x.get().kind).defv(null)){
        //   case KAbstractImpl(ref) :
        //     final t = ref.get();
        //     trace(t.name);
        //   default : 
        // }
      default : 
    }
    return macro {};
  }
}
class WhatPackageExprLookLikeTest extends TestCase{
  public function test(){
    makro(stx.makro.expr.Test);
  }
  static macro function makro(e:Expr){
    //trace(__.show(e));
    return macro {};
  }
}
class WhatIsFinalLookLikeTest extends TestCase{
  public function test(){
    makro(new HasFinal());
  }
  private static macro function makro(e:Expr){
    var type    : HType = Context.typeof(e);
    //trace(type.fields);
    return macro {};
  }
}
private class HasFinal extends Clazz{
  public final a : String;
  public function new(){
    super();
    this.a = "ok";
  }
}
class ShimTest extends TestCase{
  public function test(){
    var a = new SomethingSomething(); 
    makro(a);
  }
  private static macro function makro(e:Expr){
    var type    = Context.typeof(e);
    // trace(type);
    // switch(type){
    //   case TType(r,[]) : trace(r.get().type);
    //   default : null;
    // }
    //     type    = Context.follow(type);
    // switch(type){
    //   case TAnonymous(r) : 
    //     trace(r.get());
    //   default : null;
    // }
    final pos     = Context.currentPos();
    final fields  = HExpr._.shim(type,pos);
    //trace(fields); 
    return macro {};
  }
}
class SomethingSomething{
  public function new(){}
  public var a                : String;
  public var b(get,null)      : Bool;
  public  function get_b(){
    return b;
  }
  public var c(default,null)  : Int;
  private var d               : Float;
  public function get_go(){}
}
class WhatDoesReifiedFunctionDeclarationProduce extends TestCase{
  public function test_thingle(){
    final method      = return_function();
  }
  private static macro function return_function(){
    //trace("a");
    final result      = macro function(){};
    final printer     = new Printer();
    // trace("jere");
    // trace(result);
    // trace("EIHJHIHUIOOHUIHIOU");
    return macro {};
  }
}