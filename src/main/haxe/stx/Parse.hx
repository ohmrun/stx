package stx;

import haxe.Exception;
import stx.parse.ParseLapse;
using stx.Pico;
using stx.Fail;
using stx.Nano;
using stx.Fn;
using stx.Log;

import stx.parse.Parsers.*;

typedef LiftArrayReader       = stx.parse.lift.LiftArrayReader;
typedef LiftClusterReader     = stx.parse.lift.LiftClusterReader;
typedef LiftStringReader      = stx.parse.lift.LiftStringReader;
typedef LiftLinkedListReader  = stx.parse.lift.LiftLinkedListReader;


typedef ParseInput<P>         = stx.parse.ParseInput<P>;
typedef ParseResult<P,T>      = stx.parse.ParseResult<P,T>;
typedef ParseResultLift       = stx.parse.ParseResult.ParseResultLift;

typedef ParserApi<P,R>        = stx.parse.ParserApi<P,R>;
typedef ParserCls<P,R>       	= stx.parse.ParserCls<P,R>;
typedef Parser<P,R>           = stx.parse.Parser<P,R>;
typedef Parsers            		= stx.parse.Parsers;
typedef ParserLift            = stx.parse.parser.ParserLift;
typedef ParseFailure 					= stx.fail.ParseFailure;
typedef ParseFailureMessage 	= stx.fail.ParseFailureMessage;


class Parse{
	static public function e_error(hook:Ingests<ParseFailure>,label:String):CTR<Loc,Ingest<ParseFailure>>{
		return stx.parse.ParseErrorIngest.make.bind(label);
	}
	static public function e_fatal(hook:Excepts<ParseFailure>,?label:String,loc:Loc):Lapse<ParseFailure>{
		return Lapse.make(
				ParseFailure.ERROR,
				label,
				new haxe.Exception("FATAL"),
				null,
				loc
		);
	}
	/**
	 * Returns `stx.parse.parsers.StringParsers`
	 * @param self 
	 */
	static public function string(self:stx.parse.module.Parsers){
		return stx.parse.parsers.StringParsers;
	}
	@:noUsing static public function mergeString(a:String,b:String){
		return a + b;
	}
	@:noUsing static public function mergeArray<T>(a:Array<T>,b:Array<T>){
		return a.concat(b);
	}
	@:noUsing static public function mergeOption<T>(a:String, b:Option<String>){
		return switch (b){ case Some(v) : a += v ; default : ''; } return a; 
	}
	@:noUsing static public function mergeTAndArray<T>(a:T, b:Array<T>):Array<T>{
		return [a].concat(b);
	}
	@:noUsing static public function mergeOptionAndArray<T>(a:Option<T>, b:Array<T>):Array<T>{
		return a.fold(
			(t) -> [t].concat(b),
			() 	-> b
		);
	}
}
class LiftParse{
  static public function parse(wildcard:Wildcard){
    return new stx.parse.Module();
  }
	static private function stack(){
		return haxe.CallStack.callStack();
	}
	static public function cache<P,R>(parser:Void->Parser<P,R>):Parser<P,R>{
		return Parsers.LAnon(parser).asParser();
	}
  // static public function erration<P>(rest:ParseInput<P>,message:ParseFailure,fatal=false):Error<ParseFailure>{
  //   return Error.pure(ParseFailure.make(@:privateAccess rest.content.index,message,fatal));
  // }
	static public function sub<I,O,Oi,Oii>(p:Parser<I,O>,p0:Option<O>->Couple<ParseInput<Oi>,Parser<Oi,Oii>>):Parser<I,Oii>{
		return stx.parse.Parsers.Sub(p,p0);
	}
	static public inline function tagged<I,T>(p : Parser<I,T>, tag : String):Parser<I,T> {
    p.tag = Some(tag);
    return Parsers.TaggedDelegate(p, tag);
	}
	@:noUsing static public inline function succeed<I,O>(v:O):Parser<I,O>{
    return new stx.parse.parser.term.Succeed(v).asParser();
	}
}
//typedef LiftParseInputForwardToParser 	= stx.parse.lift.LiftParseInputForwardToParser;
typedef LiftArrayOfParser 							= stx.parse.lift.LiftArrayOfParser;
//typedef LiftParseFailureError 			= stx.parse.lift.LiftParseFailureError;
//typedef LiftParseFailureResult 		  = stx.parse.lift.LiftParseFailureResult;

class LiftParseFailure{

  static public inline function is_fatal(self:Defect<ParseFailure>):Bool{
    return self.error.is_fatal();
  }
  static public function toString(self:Defect<ParseFailure>){
    return (self.error.lapse.map(
			 x -> '${x.value}'
		):Iter<String>).lfold1((n,m) -> '$m,$n');
  } 
}