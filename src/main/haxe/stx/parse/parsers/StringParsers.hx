package stx.parse.parsers;

import stx.parse.Parsers.*;

class StringParsers{
  static public inline function reg(str:String):Parser<String,String>{
		return Regex(str).asParser();
	}
	static public inline function id(str:String):Parser<String,String>{
		return Identifier(str);
	}
	static public inline function code(int:Int):Parser<String,String>{
		return CharCode(int);
	}
	static public inline function range(start:Int,finish:Int):Parser<String,String>{
		return Range(start,finish);
  }
  static public final boolean 				= id('true').or(id('false'));
	static public final integer     		= reg("^[+-]?\\d+");
  static public final float 					= reg("^[+-]?\\d+(\\.\\d+)?");
  
	static public function primitive():Parser<String,Primitive>{
		return boolean.then((x) -> PBool(x == 'true' ? true : false))
		.or(float.then(Std.parseFloat.fn().then(x -> PSprig(Byteal(NFloat(x))))))
		.or(integer.then((str) -> PSprig(Byteal(NFloat((__.option(Std.parseInt(str)).defv(0)))))))
		.or(literal.then(x -> PSprig(Textal(x))));
	}
		

	static public final lower						= Range(97, 122);
	static public final upper						= Range(65, 90);
	static public final alpha						= Or(upper,lower);
	static public final digit						= Range(48, 57);
	static public final alphanum				= alpha.or(digit);
	static public final ascii						= Range(0, 255);
	
	static public final valid						= alpha.or(digit).or(id('_'));
	
	static public final tab							= id('	');
	static public final space						= id(' ');
	
	static public final nl							= id('\n');
	static public final cr							= id('\r\n');
	static public final cr_or_nl				= nl.or(cr);

	static public final gap							= tab.or(space);
	static public final whitespace			= Range(0, 32).tagged('whitespace');

	//static public final camel 				= lower.and_with(word, mergeString);
	static public final word						= lower.or(upper).one_many().tokenize();//[a-z]*
	static public final quote						= id('"').or(id("'"));
	static public final escape					= id('\\');
	static public final not_escaped			= id('\\\\');
	
	static public final x 							= not_escaped.not()._and(escape);
	static public final x_quote 				= x._and(quote);

	static public final literal 				= new stx.parse.term.Literal().asParser();
	static public final symbol 					= Parsers.When(x -> StringTools.fastCodeAt(x,0) >= 33).one_many().tokenize().tagged('symbol');

	static public	final brkt_l_square = id('[');
	static public	final brkt_r_square = id(']');

	static public function spaced( p : Parser<String,String> ) {
		return p.and_(gap.many());
	}
	static public function returned(p : Parser<String,String>) {
		return p.and_(whitespace.many());
	}
}