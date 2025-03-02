package stx.parse.core.enumerable.term;

import String in StdString;

class String extends EnumerableCls<StdString,StdString>{
	public function new(v, ?i) {
		//__.assert().that().exists(v);
		super(v, i);
	}
	public function is_end() {
		return !(this.data.length > this.index);
	}
	public function match(e:StdString->Bool){
		var to_match = this.take();
		#if debug 
		__.log().trace(_ -> _.thunk(() -> 'match |<[${to_match}]>| is_end? ${is_end()}'));
		#end
		return e(to_match);
	}
	public function prepend(v:StdString):Enumerable<StdString,StdString> {
		var left 	= this.data.substr(0, index);
		var right = this.data.substr(index);
		
		return new String( this.data = left + v + right , this.index );
	}
	public function take(?len:Null<Int>):StdString {
		len = len == null ? this.data.length - this.index : len;
		len = len == 0 ? 1 : len;
		var out = data.substr(index, len);
		return out;
	}
	public function drop(i:Int):Enumerable<StdString,StdString>{
		return new String(this.data,this.index+i);
	}
	public function head():Chunk<StdString,ParseFailure>{
		return if(index >= this.data.length){
			End(__.fault().of(EOF));
		}else{
			Val(this.data.charAt(index));
		}
	}
	public function copy(?index:Int):Enumerable<StdString,StdString>{
		return new String(this.data,__.option(index).defv(this.index)).asEnumerable();
	}
	public function toString(){
		return 'Enumerable($data)';
	}
}