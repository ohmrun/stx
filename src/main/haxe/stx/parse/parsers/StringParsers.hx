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
  static public final boolean : Parser<String,String> 				= id('true').or(id('false'));
	static public final integer : Parser<String,String>     		= reg("^[+-]?\\d+");
  static public final float   : Parser<String,String> 					= reg("^[+-]?\\d+(\\.\\d+)?");
  
	static public function primitive():Parser<String,Primitive>{
		return boolean.then((x) -> PBool(x == 'true' ? true : false))
		.or(float.then(Std.parseFloat.fn().then(x -> PSprig(Byteal(NFloat(x))))))
		.or(integer.then((str) -> PSprig(Byteal(NFloat((__.option(Std.parseInt(str)).defv(0)))))))
		.or(literal.then(x -> PSprig(Textal(x))));
	}
		

	static public final lower 			: Parser<String,String>					= Range(97, 122);
	static public final upper				: Parser<String,String>					= Range(65, 90);
	static public final alpha				: Parser<String,String>					= Or(upper,lower);
	static public final digit				: Parser<String,String>					= Range(48, 57);
	static public final alphanum 		: Parser<String,String>					= alpha.or(digit);
	static public final ascii    		: Parser<String,String>					= Range(0, 255);
	
	static public final valid     	: Parser<String,String>					= alpha.or(digit).or(id('_'));
	
	static public final tab					: Parser<String,String>			= id('	');
	static public final space				: Parser<String,String>						= id(' ');
	
	static public final nl					: Parser<String,String>							= id('\n');
	static public final cr					: Parser<String,String>							= id('\r\n');
	static public final cr_or_nl  	: Parser<String,String>				= nl.or(cr);

	static public final gap					: Parser<String,String>			= tab.or(space);
	static public final whitespace	: Parser<String,String>			= Range(0, 32).tagged('whitespace');

	//static public final camel 		: Parser<String,String>		= lower.and_with(word, mergeString);
	static public final word				: Parser<String,String>		= lower.or(upper).one_many().tokenize();//[a-z]*
	static public final quote				: Parser<String,String>		= id('"').or(id("'"));
	static public final escape			: Parser<String,String>		= id('\\');
	static public final not_escaped : Parser<String,String>			= id('\\\\');
	
	static public final x 					: Parser<String,String> = not_escaped.not()._and(escape);
	static public final x_quote 		: Parser<String,String>		= x._and(quote);

	static public final literal  		: Parser<String,String> 				= new stx.parse.term.Literal().asParser();
	static public final symbol   		: Parser<String,String> 					= Parsers.When(x -> StringTools.fastCodeAt(x,0) >= 33).one_many().tokenize().tagged('symbol');

	static public	final brkt_l_square  :Parser<String,String> = id('[');
	static public	final brkt_r_square  :Parser<String,String> = id(']');

	static public function spaced( p : Parser<String,String> ):Parser<String,String> {
		return p.and_(gap.many());
	}
	static public function returned(p : Parser<String,String>):Parser<String,String>{
		return p.and_(whitespace.many());
	}
}