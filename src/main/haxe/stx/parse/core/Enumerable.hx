package stx.parse.core;

import stx.parse.core.enumerable.term.Array;
import stx.parse.core.enumerable.term.String;
import stx.parse.core.enumerable.term.LinkedList;

interface EnumerableApi<C,T>{
	
	@:allow(stx)
	private var data(default,null) 	: C;

	public var index(default,null)	: Int;

	public function zero():Enumerable<C,T>;
	public function copy(?index:Int):Enumerable<C,T>;

	public function head():Chunk<T,ParseFailureCode>;
	public function take(?len : Null<Int>):C;

	public function drop(n:Int):Enumerable<C,T>;

	/**
		ParseInputing the implementation allows this interface not to leak information about the internals into the type definitions.
	**/
	public function match(fn:T -> Bool):Bool;

	public function prepend(v:T):Enumerable<C,T>;
	//public function append(v:T):Enumerable<C,T>;
	//public function concat(e:Enumerable<Dynamic || C ,T>):???
	public function is_end():Bool;

	public function asEnumerable():Enumerable<C,T>;
} 

@:forward abstract Enumerable<C,T>(EnumerableApi<C,T>) from EnumerableApi<C,T> to EnumerableApi<C,T>{
  public function new(self) this = self;
  @:noUsing static public function lift<C,T>(self:EnumerableApi<C,T>):Enumerable<C,T> return new Enumerable(self);
  
	@:deprecated
	@:noUsing static public function array<T>(array:std.Array<T>):Enumerable<std.Array<T>,T>{
		return new Array(array);
	}
	@:noUsing static public function Array<T>(array:std.Array<T>):Enumerable<std.Array<T>,T>{
		return new Array(array);
	}
	@:noUsing static public function String(string:std.String):Enumerable<std.String,std.String>{
		return new String(string);
	}
	@:deprecated
	@:noUsing static public function string(string:std.String):Enumerable<std.String,std.String>{
		return new String(string);
	}

	@:noUsing static public function LinkedList<T>(list:stx.ds.LinkedList<T>):Enumerable<stx.ds.LinkedList<T>,T>{
		return new LinkedList(list);
	}
	@:deprecated
	@:noUsing static public function linked_list<T>(list:stx.ds.LinkedList<T>):Enumerable<stx.ds.LinkedList<T>,T>{
		return new LinkedList(list);
	}
  

  public function prj():EnumerableApi<C,T> return this;
  private var self(get,never):Enumerable<C,T>;
  private function get_self():Enumerable<C,T> return lift(this);
}
abstract class EnumerableCls<C,T> implements EnumerableApi<C,T>{
	
	public var data 	: C;
	public var index 	: Int;

	public function new(data,?index = 0) {
		this.data 	= data;
		this.index 	= index;
	}
	public function zero():Enumerable<C,T>{
		return copy(0);
	}
	abstract public function is_end():Bool;
	abstract public function match(fn:T -> Bool):Bool;
	abstract public function prepend(v:T):Enumerable<C,T>;
	abstract public function head():Chunk<T,ParseFailureCode>;
	abstract public function drop(n:Int):Enumerable<C,T>;
	abstract public function take(?len : Null<Int>) : C;
	abstract public function copy(?index:Int):Enumerable<C,T>;
	public function asEnumerable():Enumerable<C,T>{
		return this;
	}
} 