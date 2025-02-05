package stx.parse.path;

using stx.Pkg;
using stx.parse.path.Base;

import stx.parse.parsers.StringParsers as SParse;

function alts<I,O>(str):Parser<I,O> 			return __.parse().alts(str);
function id(str):Parser<String,String> 		return SParse.id(str);
function reg(str):Parser<String,String> 	return SParse.reg(str);

function log(wildcard:Wildcard):stx.Log{
	return new stx.Log().tag(__.pkg().toString());
}
class Base extends ParserCls<String,Cluster<Token>>{
	public final is_windows : Bool;
	public function new(is_windows,?id:Pos){
		this.is_windows = is_windows;
		super(Some('asys.fs.Path'),id);
	}
	private function separator(){
		return is_windows ? Separator.WinSeparator : Separator.PosixSeparator;
	}
	public function p_sep(): Parser<String,Token>{
		return Parsers.When(
			string -> {
				return string == separator();	
			},
			Some('p_sep')
		).asParser().then(
			_ -> FPTSep
		).with_tag('p_sep');
	}
	public function p_root():Parser<String,Cluster<Token>>{
		__.log().trace('is_windows? $is_windows');
		return if(is_windows) {
				SParse.alpha
				.then( Some.fn().then(FPTDrive) )
				.and(p_sep().option()).then(
					(tp) -> switch(tp.snd()){
						case Some(v) : [tp.fst(),v];
						case None		 : [tp.fst()];
					}
				);
			}else{
				inspect(p_sep().then( function(x) return [FPTDrive(None)] ));
			}
	}

	public var p_up  			= 
		'..'.id().then ( function(x) return FPTUp ).with_tag('p_up');


	public var char_and_space : Parser<String,String>
		= SParse.alphanum.or(SParse.whitespace).with_tag('char_and_space');

	//public var p_special_chars_exceptions = 
	public var p_special_chars : Parser<String,String>
		= alts(
			["<>:\"\\|?*/"].map(id)
		).not()._and(
			SParse.alphanum.not()
		)._and(Parsers.Something())
		 .with_tag('p_special_chars');
	//= "[^<>:\"\\\\|?*\\/A-Za-z0-9]".reg().with_tag('p_special_chars');


	public function p_path_chars() : Parser<String,String>{
		final not_sep = p_sep().not().with_tag('p_path_chars.p_sep');
		final char 		= char_and_space.or(p_special_chars); 
		return 
			not_sep._and(char.or(".".id()))
			.and(
				not_sep._and(char).many()
			).then(
				__.decouple(
					(x:String,r:Cluster<String>) -> r.cons(x)
				)
			).tokenize()
			 .with_tag('p_path_chars'); 
	}		
	public function p_file_chars():Parser<String,String>{
		return char_and_space.or(p_special_chars).one_many().tokenize().with_tag('p_file_chars');
	}
	static function spect<I,O>(parser:Parser<I,O>,?pos:Pos):Parser<I,O>{
		return parser;
	}
	static function inspect<I,O>(parser:Parser<I,O>,?pos:Pos):Parser<I,O>{
		return Parsers.Inspect(
			parser,
			__.log().printer(pos),((x:ParseResult<I,O>) -> x.toString()).fn().then(__.log().printer(pos)));
	}
	public function p_term():Parser<String,Token>{
		//__.log().debug('pterm');
		return p_path_chars().and_(
			':'.id().not()
		).and_then(
			(str:String) -> {
				__.log().trace(' ###$str###');
				//There's no way to tell without context
				return Parsers.Succeed(FPTDown(str));
				// return switch(str){
				// 	case '.' 		: Parsers.Failed('not a term');
				// 	case '..' 	: Parsers.Failed('not a term');
				// 	default  		: 
				// 		var all = str.split(".");
				// 		var ext = null;
				// 		if(all.length>1 && all[1] != null && str!='.'){
				// 			ext = all.pop();
				// 		}
				// 	return if(ext==null){
						
				// 	}else{
				// 		Parsers.Succeed(FPTFile(all.join('.'),ext));
				// 	}
				// }
			}
		).with_tag('p_term');
	}
	public function p_junction():Parser<String,Token>{
		return inspect(p_term().or(p_up).or(p_down()));
	}
	public function p_down():Parser<String,Token>{
		return p_path_chars().and_(
			':'.id().not()
		).then( function(str) { return FPTDown(str); } );
	}
	public function p_body():Parser<String,Cluster<Token>>{
		return inspect(p_junction().rep1sep0(p_sep()));
	}
	public function p_abs():Parser<String,Cluster<Token>>{ 
		return p_root()
		.and( p_body().option() )
		.then( 
			function(t) {
				__.log().trace('${t.tup()}');
				return switch(t.tup()){
					case tuple2(tk,b2_opt_arr) :
						var out = [];
						for(v in tk){ 
							out.push(v); 
						}
						for(v0 in b2_opt_arr){ 
							for(v1 in v0){
								out.push(v1); 
							}
						}
						out;
					default : [];
				}
			}
		);
	}
	public function p_rel_root():Parser<String,Token>{
		return '.'.id().and_('.'.id().not().and(p_sep().option())).then( (_) -> FPTRel);
	}
	public function p_rel():Parser<String,Cluster<Token>>{ 
		return p_rel_root().or(p_junction())
		.and(p_sep().option().with_tag("HSDF"))
		.and(
				p_up.repsep0(p_sep()).and_(p_sep()).and_with(p_junction().repsep0(p_sep()) 
				,function(a,b){
					trace('$a $b');
					return a.concat(b);
				}
			).or(
				p_junction().repsep0(p_sep())
			).option()
		).then(
			(tp) -> tp.decouple(
				(tp,c:StdOption<Cluster<Token>>) -> tp.decouple(
					(a:Null<Token>,b:Option<Token>) -> switch([a,b,c]){
						case [null,None,None]							: Cluster.pure(FPTRel);
						case [null,None,Some(v)] 	 				: Cluster.pure(FPTRel).concat(v);
						case [head,None,Some(v)]  				: Cluster.pure(head).concat(v);
						case [head,Some(tail),Some(v)]  	: Cluster.make([head,tail]).concat(v);
						case [head,Some(tail),None]  			: Cluster.make([head,tail]);
						case [head,None,None]  						: Cluster.pure(head);
					}
				)
			)
		);
	}
	public function p_path():Parser<String,Cluster<Token>>{
		return p_rel()
			.or(p_abs())
			.and(p_sep().option())
			.then(
				(tp) -> {
					__.log().debug('${tp.tup()}');
					return ((l:Cluster<Token>,r:Option<Token>) -> switch(r){
						case Some(v): l.concat([v]);
						case None 	: l;
					})(tp.fst(),tp.snd());
				}
			).or(
				p_term().then(
					(x) -> [x]
				)
			).and_(Parsers.Eof());
	}               
	override public function apply(i:ParseInput<String>):ParseResult<String,Cluster<Token>>{
		return p_path().apply(i);
	}
	public function format(arr:Cluster<Token>){
		var o = arr.lfold(
			function(e,init){
				switch (e) {
					case FPTUp 								: init.length > 1 ? init.pop() : null;
					case FPTDown(str) 				: init.push(str);
					case FPTDrive(Some(root)) : init.push(root);
					default 									:
				}
				return init;
			},
			[]
		);
		return o;
	}
	public function stringify(n:Token){
		return switch (n){
			case FPTUp 										:	'..';
			case FPTDown(str) 						:	str;
			case FPTDrive(Some(root)) 		: root;
			case FPTDrive(None)						:	separator().toString();
			case FPTRel 									: '.';
			case FPTFile(str, null)				: str;
			case FPTFile(str,ext) 				: '$str.$ext'; 
			case FPTSep 									: separator().toString();
		}
	}
	public function asBase():Base{
		return this;
	}
}