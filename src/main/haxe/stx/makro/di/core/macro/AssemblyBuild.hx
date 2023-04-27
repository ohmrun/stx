package stx.makro.di.core.macro;

using stx.Pico;
using stx.Nano;
using stx.Log;

#if macro
import tink.macro.Member;
using tink.macro.Exprs;
import haxe.macro.Expr;
import haxe.macro.Context;
using stx.makro.Expr;
#end

class AssemblyBuild{
  static macro function build():Array<haxe.macro.Field>{
    final printer     = new haxe.macro.Printer();
    final btype       = Context.getLocalClass().get();
    final curr_fields = Context.getBuildFields();
    final pos         = Context.currentPos();

    __.log().info('build ${btype.pack.join(".")}.${btype.name}');

    final next_fields = [];

    for( next in curr_fields ){
      switch(
        [
          ["react","apply"].any((x) -> next.name == x),
          new EnumValue(next.kind).alike(FFun(null)),
          (next.access ?? []).any(x -> x == AStatic )
        ]
      ){
        case [false,true,false] : 
          //trace(next);
          next_fields.push(next);
        default : 
      }
    }
    //trace(next_fields);

    switch(curr_fields.search(x -> x.name == "react")){
      case Some(v) : curr_fields.remove(v);
      default      : 
    };

    var exprs : Expr = next_fields.map(
      (member) -> {
        var pos   = Context.currentPos();
        var expr  = macro stx.makro.di.Injectors.add(
          $i{"di"},
          $i{member.name}
        );
        return expr;
      }
    ).toBlock();
    
    //trace(printer.printExpr(exprs));

    final func : Function = {
      args : [{name : "di",type : haxe.macro.MacroStringTools.toComplex("stx.makro.di.DI")}],
      ret  : null,
      expr : exprs
    };
    final member : Member = {
      name    : "react",
      kind    : FFun(func),
      pos     : Context.currentPos()
    };
    member.overrides  = true;
    member.isPublic   = true;

    final id              = 
      haxe.macro.MacroStringTools.toFieldExpr(
        __.option(btype.pack).defv([]).snoc(btype.name)
      ); 

    final init_func : Function = {
      args : [],
      ret  : null,
      expr : macro {
        //trace($e{id});
        new stx.makro.di.Registry().push($e{id});
      }
    }
    var init : haxe.macro.Field = {
      name    : "__init__",
      kind    : FFun(init_func),
      pos     : pos,
      access  : [AStatic]
    }
    final react  : haxe.macro.Field             = member;
    final fields : Array<haxe.macro.Field>      = curr_fields.concat([react,init]);
    return fields;
  }
}