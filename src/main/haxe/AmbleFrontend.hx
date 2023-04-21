using amble.Logging;

using stx.Nano;
using stx.Log;
import haxe.io.Path;

import haxe.ds.Option;

#if macro
import tink.syntaxhub.*;
import haxe.macro.Expr;
import haxe.macro.Context;

using bake.Util;

class AmbleFrontend implements FrontendPlugin {
	private static function search<T>(self:Array<T>,fn:T->Bool):Option<T>{
    return stx.lift.ArrayLift.search(self,fn);
  }
  public function new() {}
	
	public function extensions() 
		return ['hxr'].iterator();
		
	public function parse(file:String, context:FrontendContext):Void {
		final file_path 	= new Path(file);
    final text 				= sys.io.File.getContent(file);
		final pos  				= Context.makePosition({ file: file, min: 0, max: text.length });
		final bake 				= Bake.pop();
		__.log().trace('loading: $file');
		final root 				= new Path(Path.removeTrailingSlashes(bake.root.toString()));
		final sep  				= root.backslash ? "\\" : "/";
		final root_bits 	= root.toString().split(sep);
		final amble_root 	= search(bake.defines,
      x -> x.key == "Amble.root"
    ).map(x -> x.value);
		amble_root.fold(
			(x) -> {
				final amble_bits = x.split(sep);
				for(bit in amble_bits){
					root_bits.push(bit);
				}
			},
			() -> {}
		);
		final pack_bits 	= file.split(sep);
		__.log().trace('$root_bits $pack_bits');
		final extra	    	= [];
		for(i in 0...pack_bits.length){
			if(root_bits[i] != pack_bits[i]){
				extra.push(pack_bits[i]);
			}
		}
		final name 				= pack_bits.pop().split(".")[0];
		final pack 				= extra.copy();
			pack.pop();
		__.log().trace('$pack');
		var printer = new haxe.macro.Printer();
		final main 				= Context.parse('{$text}',pos);
		__.log().trace(printer.printExpr(main));
		__.log().trace(name);
		final call 			  = {
			pos 	: pos,
			name  : "main",
			kind  : FFun({
				expr : main,
				args : []
			}),
			access : [APublic,AStatic]
		}
		context.getType().fields.push(
			call
		);
		// var printer = new haxe.macro.Printer();
		// trace(printer.printTypeDefinition(tdef));
		// Context.defineType(tdef);
	}
}

#end