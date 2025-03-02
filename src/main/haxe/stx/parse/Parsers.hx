package stx.parse;

class Parsers{
  @:noUsing static public function Anon<P,R>(fn:ParseInput<P> -> ParseResult<P,R>,tag:Option<String>,?pos:Pos):Parser<P,R>{
    return new stx.parse.parser.term.Anon(fn,tag,pos).asParser();
  }
  @:noUsing static public function Equals<P>(v:P):Parser<P,P>{
    return new stx.parse.parser.term.Equals(v).asParser();
  }
  @:noUsing static public function Sub<I,O,Oi,Oii>(p:Parser<I,O>,fn:Option<O>->Couple<ParseInput<Oi>,Parser<Oi,Oii>>):Parser<I,Oii>{
    return new stx.parse.parser.term.Sub(p,fn).asParser();
  }
  @:noUsing static public function SyncAnon<P,R>(fn:ParseInput<P> -> ParseResult<P,R>,tag:Option<String>,?pos:Pos):Parser<P,R>{
    return new stx.parse.parser.term.SyncAnon(fn,tag,pos).asParser();
  }
  @:noUsing static public function TaggedAnon<P,R>(fn:ParseInput<P> -> ParseResult<P,R>,tag,?pos:Pos):Parser<P,R>{
    return new stx.parse.parser.term.TaggedAnon(fn,tag,pos).asParser();
  }
  @:noUsing static public function TaggedDelegate<P,R>(self:Parser<P,R>,tag,?pos:Pos):Parser<P,R>{
    return new stx.parse.parser.term.TaggedDelegate(self,tag,pos).asParser();
  }
  @:noUsing static public function Failed<P,R>(?msg,?pos:Pos):Parser<P,R>{
    return new stx.parse.parser.term.Failed(ParseFailure.FATAL,msg,pos).asParser();
  }
  @:noUsing static public function Fatal<P,R>(msg,?pos:Pos):Parser<P,R>{
    return new stx.parse.parser.term.Failed(ParseFailure.FATAL,msg,pos).asParser();
  }
  @:noUsing static public function Succeed<P,R>(value:R,?pos:Pos):Parser<P,R>{
    return new stx.parse.parser.term.Succeed(value,pos).asParser();
  }
  @:noUsing static public function Stamp<P,R>(result:ParseResult<P,R>,?pos:Pos):Parser<P,R>{
    return new stx.parse.parser.term.Stamp(result,pos).asParser();
  }
  // @:noUsing static public function Closed<P,R>(self:Provide<ParseResult<P,R>>,?pos:Pos):Parser<P,R>{
  //   return new stx.parse.parser.term.Closed(self,pos).asParser();
  // }
  @:noUsing static public function Range(min:Int,max:Int):Parser<String,String>{
    return new stx.parse.parser.term.Range(min,max).asParser();
  }
  @:noUsing static public function Named<P,R>(self:Parser<P,R>,name:String):Parser<P,R>{
    return new stx.parse.parser.term.Named(self,name).asParser();
  }
  @:noUsing static public function Regex(str:String):Parser<String,String>{
    return new stx.parse.parser.term.Regex(str).asParser();
  }
  @:noUsing static public function Or<I,T>(pI : Parser<I,T>, pII : Parser<I,T>):Parser<I,T>{
    return new stx.parse.parser.term.Or(pI,pII).asParser();
  }
  @:noUsing static public function Ors<I,T>(ps : Array<Parser<I,T>>):Parser<I,T>{
    return new stx.parse.parser.term.Ors(ps).asParser();
  }
  @:noUsing static public function AnonThen<I,T,U>(p : Parser<I,T>, f : T -> U):Parser<I,U>{
    return new stx.parse.parser.term.AnonThen(p,f).asParser();
  }
  @:noUsing static public function AndThen<I,T,U>(p: Parser<I,T>, f : T -> Parser<I,U>):Parser<I,U>{
    return new stx.parse.parser.term.AndThen(p,f).asParser();
  }
  @:noUsing static public function Many<I,T>(p: Parser<I,T>):Parser<I,Array<T>>{
    return new stx.parse.parser.term.Many(p).asParser();
  }
  @:noUsing static public function OneMany<I,T>(p: Parser<I,T>):Parser<I,Array<T>>{
    return new stx.parse.parser.term.OneMany(p).asParser();
  }
  @:noUsing static public function Repeated<I,T>(p: Parser<I,T>,n):Parser<I,Array<T>>{
    return new stx.parse.parser.term.Repeated(p,n).asParser();
  }
  @:noUsing static public function RepeatedUpto<I,T>(p: Parser<I,T>,n):Parser<I,Array<T>>{
    return new stx.parse.parser.term.RepeatedUpto(p,n).asParser();
  }
  @:noUsing static public function RepeatedOnlyUpto<I,T>(p: Parser<I,T>,n):Parser<I,Array<T>>{
    return new stx.parse.parser.term.RepeatedOnlyUpto(p,n).asParser();
  }
  @:noUsing static public function RepeatedOnly<I,T>(p: Parser<I,T>,n):Parser<I,Array<T>>{
    return new stx.parse.parser.term.RepeatedOnly(p,n).asParser();
  }
  @:noUsing static public function Eof<I,O>(?pos:Pos):Parser<I,O>{
    return new stx.parse.parser.term.Eof().asParser();
  }
  @:noUsing static public function Lookahead<I,O>(parser:Parser<I,O>):Parser<I,O>{
    return new stx.parse.parser.term.Lookahead(parser).asParser();
  }
  @:noUsing static public function Identifier(str:String):Parser<String,String>{
    return new stx.parse.parser.term.Identifier(str).asParser();
  }
  @:noUsing static public function Option<I,O>(p:Parser<I,O>):Parser<I,Option<O>>{
    return new stx.parse.parser.term.Option(p).asParser();
  }
  /**
   * @constructs stx.parse.parser.term.Choose
   * @param parser `Parser<I,O>`
   * @param name `String`
   * @param ?pos `Pos`
   * @return `Parser<I,O>`
   */
  @:noUsing static public function Choose<I,O>(fn:I->Option<O>,?tag:Option<String>,?pos:Pos): Parser<I,O>{
    return new stx.parse.parser.term.Choose(fn,tag,pos).asParser();
  }
  @:noUsing static public function When<I>(fn:I->Bool,?tag:Option<String>,?pos:Pos):Parser<I,I>{
    return new stx.parse.parser.term.When(fn,tag,pos).asParser();
  }
  @:noUsing static public function Materialize<I,O>(parser:Parser<I,O>):Parser<I,O>{
    return new stx.parse.parser.term.Materialize(parser).asParser();
  }
  @:noUsing static public function Inspect<I,O>(parser:Parser<I,O>,?prefix:ParseInput<I>->Void,?postfix:ParseResult<I,O>->Void,?pos:Pos):Parser<I,O>{
    return new stx.parse.parser.term.Inspect(parser,prefix,postfix,pos).asParser();
  }
  // @:noUsing static public function TagError<I,O>(parser:Parser<I,O>,name:String,?pos:Pos):Parser<I,O>{
  //   return new stx.parse.parser.term.TagError(parser,name,pos).asParser();
  // }
  // @:noUsing static public function Debug<P,R>(parser:Parser<P,R>):Parser<P,R>{
  //   return new stx.parse.parser.term.Debug(parser).asParser();
  // }
  /**
   * @constructs `stx.parse.parser.term.Something`
   * @param l `Parser<P,Ri>`
   * @param r `Parser<P,Rii>`
   * @return `Parser<P,Ri>`
   */
  @:noUsing static public function Something<P>():Parser<P,P>{
    return new stx.parse.parser.term.Something().asParser();
  }
  @:noUsing static public function Always<P>():Parser<P,P>{
    return new stx.parse.parser.term.Always().asParser();
  }
  @:noUsing static public function Nothing<P,R>():Parser<P,R>{
    return new stx.parse.parser.term.Nothing().asParser();
  }
  @:noUsing static public function Never<P>():Parser<P,P>{
    return new stx.parse.parser.term.Never().asParser();
  }
  @:noUsing static public function Head<I,O>(fn:I->Option<Couple<O,Option<I>>>):Parser<I,O>{
		return new stx.parse.parser.term.Head(fn).asParser();
	}
  @:noUsing static public function AndR<P,Ri,Rii>(l:Parser<P,Ri>,r:Parser<P,Rii>):Parser<P,Rii>{
    return new stx.parse.parser.term.AndR(l,r).asParser();
  }
  @:noUsing static public function AndL<P,Ri,Rii>(l:Parser<P,Ri>,r:Parser<P,Rii>):Parser<P,Ri>{
    return new stx.parse.parser.term.AndL(l,r).asParser();
  }
  @:noUsing static public function LAnon<P,R>(fn:Void->Parser<P,R>,?pos:Pos):Parser<P,R>{
    return new stx.parse.parser.term.LAnon(fn,pos).asParser();
  }
  @:noUsing static public function AnonWith<P,Ri,Rii,Riii>(pI:Parser<P,Ri>,pII:Parser<P,Rii>,f:Null<Ri>->Null<Rii>->Option<Riii>):Parser<P,Riii>{
    return new stx.parse.parser.term.AnonWith(pI,pII,f).asParser();
  }
  static public inline function CoupleWith<P,Ri,Rii>(pI:Parser<P,Ri>,pII : Parser<P,Rii>):Parser<P,Couple<Ri,Rii>>{
    return new stx.parse.parser.term.CoupleWith(pI,pII).asParser();
  }
  static public inline function Rep1Sep<P,Ri,Rii>(pI:Parser<P,Ri>,sep : Parser<P,Rii> ):Parser <P, Cluster<Ri>> {
    return new stx.parse.parser.term.Rep1Sep(pI,sep).asParser(); /* Optimize that! */
  }
  static public inline function Commit<I,T> (pI : Parser<I,T>):Parser<I,T>{
    return new stx.parse.parser.term.Commit(pI).asParser();
  }
  static public inline function Not<I,O>(p:Parser<I,O>,?pos:Pos):Parser<I,O>{
		return new stx.parse.parser.term.Not(p,pos).asParser();
	}
  @:noUsing static public inline function While<I,O>(p:Parser<I,O>,?pos:Pos):Parser<I,Cluster<O>>{
		return new stx.parse.parser.term.While(p,pos).asParser();
	}
  // static public inline function Position<O>(p:Parser<String,O>,?pos:Pos):Parser<String,O>{
	// 	return new stx.parse.parser.term.Position(p,pos).asParser();
	// }
  static public function CharCode(i:Int):Parser<String,String>{
		return new stx.parse.parser.term.CharCode(i).asParser();
	}	
  @:noUsing static public function Bag<I,O>(choices:Array<Parser<I,O>>):Parser<I,Cluster<O>>{
    return new stx.parse.parser.term.Bag(choices).asParser();
  }
  @:noUsing static public function FlatMap<P,Ri,Rii>(self:Parser<P,Ri>,fn:Ri->Parser<P,Rii>,?pos:Pos):Parser<P,Rii>{
    return new stx.parse.parser.term.AnonFlatMap(self,fn,pos).asParser();
  }
  @:noUsing static public function Literal():Parser<String,String>{
    return new stx.parse.term.Literal().asParser();
  }
}

