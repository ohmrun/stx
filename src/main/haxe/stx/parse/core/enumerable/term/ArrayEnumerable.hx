package stx.parse.core.enumerable.term;

class ArrayEnumerable<T> extends EnumerableCls<StdArray<T>, T > {
	public function new(v,?i) {
		super(v, i);
	}
	public function is_end() {
		return !(this.data.length > this.index); 	
	}
	public function match(e:T->Bool){
		return switch(head()){
			case Val(x) : e(x);
			default 		: false;
		}
	}
	public function prepend(v:T):Enumerable<StdArray<T>,T> {
		var lhs = this.data.slice(0,index);
		var rhs = this.data.slice(index);
		return new ArrayEnumerable(lhs.concat(rhs.cons(v)) , this.index);
	}
	public function take(?len:Null<Int>):StdArray<T> {
		len = len == null ? this.data.length - this.index : len;
		return data.prj().slice(this.index, this.index + len);
	}
	public function drop(i:Int):Enumerable<StdArray<T>,T>{
		return new ArrayEnumerable(this.data,this.index + i);
	}
	public function copy(?index:Int):Enumerable<StdArray<T>, T >{
		return new ArrayEnumerable(this.data,__.option(index).defv(this.index)).asEnumerable();
	}
	public function head():Chunk<T,ParseFailure>{
		return if(index >= this.data.length){
			End(__.fault().ingest((_:Ingests<ParseFailure>) -> _.e_error("E_Parse_Eof")));
		}else{
			switch(this.data[index]){
				case null : Tap;
				case x 		: Val(x);
			}
		}
	}
} 