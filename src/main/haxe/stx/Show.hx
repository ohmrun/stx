package stx;

// abstract Indent(String) from String{
//   public function toString(){
//     return this;
//   }
// }
// @:callable @:forward abstract ToString<T>(T->Indent->String){

// }

class Show {
  static public function show<A>(wildcard:Wildcard,v:A):String{
    return make(v)(v);
  }
  @:noUsing static private function __show__<T>(impl : Dynamic->String) : T -> String {
    return function(v) return null == v ? 'null' : impl(v);
  }
  /**
    Returns a ShowFunction (T -> String). It works for any Stdtype. For Custom Classes you must provide a toString()
    method, otherwise the full class name is returned.
  */
  @:noUsing static public function make<T>(t : T) : T -> String{
    return make0(StdType.typeof(t));
  }

  /**
    @:todo Reflect.fields doesn't work consistenly across platforms so we may probably pass to use StdType.getInstanceFields. The problem here
    is that we must check if the fields are functions before grabbing the value.
  */
  @:noUsing static public function make0<T>(v : ValueType) : T->String {
    return switch(v) {
      case TBool                        : __show__(BoolShow.toString);
      case TInt                         : __show__(IntShow.toString);
      case TFloat                       : __show__(FloatShow.toString);
      case TUnknown                     : __show__(function(v) return '<unknown>');
      case TObject                      : __show__(ObjectShow.toString);
      case TEnum(_)                     : __show__(EnumShow.toString);
      case TClass(c) if(c == String)    : __show__(std.Std.string);
      case TClass(c) if(c == StdArray)  : __show__(ArrayShow.toString);
      case TClass(c) if(c == std.List)  : __show__(ListShow.toString);
      case TClass(c)                    :
          if(StdType.getInstanceFields(c).remove("toString")){
            __show__(function(v) return Reflect.callMethod(v, Reflect.field(v, "toString"), []));
          }else{
            __show__(function(v) return StdType.getClassName(StdType.getClass(v)));
          }
      case TNull                        : NullShow.toString;
      case TFunction                    : __show__(function(v) return '<function>');
    }
  }
}
private class ListShow{
  static public function toString<A>(lst:std.List<A>):String{
    return IterableShow.toString(lst);
  }
}
private class NullShow{
  static public function toString<A>(v:A):String{
    return "null";
  }
}
private class EnumShow{
  static public function toString(v:Dynamic):String {
    var buf = StdType.enumConstructor(v);
    var params = StdType.enumParameters(v);
    return if(params.length == 0)
      buf;
    else {
      buf +="(";
      for(i in 0...params.length){
        var p = params[i];
        buf += Show.make(p)(p);
        if(i < params.length - 1){
          buf += ", ";
        }
      }
      buf+= ")";
      buf;
    }

  }
}
private class ObjectShow {
  static public function toString(v:Dynamic):String{
    if(Reflect.fields(v).length == 0){
      return std.Std.string(v); // fix : Haxe mistypes nodejs native error
    }
    var buf = [];
    for(k in Reflect.fields(v)) {
      var i = Reflect.field(v, k);
      buf.push(k + ":" + Show.make(i)(i));
    }
    return "{" + buf.join(",") + "}";
  }
}
private class ArrayShow {
	public static function toString<T>(v: StdArray<T>) {
    return toStringWith(v, Show.make(v[0]));
  }
  public static function toStringWith<T>(v: StdArray<T>, show : T->String) {
    return "[" + v.map(show).join(", ") + "]";
  }
	public static function mkString<T>(arr: StdArray<T>, ?sep: String = ', ', ?show: T -> String): String {
    var isFirst = true;

    return arr.fold(function(b,a) {
      var prefix = if (isFirst) { isFirst = false; ''; } else sep;
      if(null == show)
      show = Show.make(b);
      return a + prefix + show(b);
    },'');
  }
}
private class IterableShow {
	public static function toString<T>(i: Iterable<T>, ?show: T -> String, ?prefix: String = '(', ?suffix: String = ')', ?sep = ', ') {
    return mkString(i, show, prefix, suffix, sep);
  }

  public static function mkString<T>(i: Iterable<T>, ?show: T -> String, ?prefix: String = '(', ?suffix: String = ')', ?sep = ', ') {
    if (show == null) show = std.Std.string;

    var s = prefix;
    var isFirst = true;

    for (t in i) {
      if (isFirst) isFirst = false; else s += sep;

      s += show(t);
    }

    return s + suffix;
  }
}

private class IntShow {
	public static function toString(v: Int) : String {
    return "" + v;
  }
}
private class FloatShow {
	public static function toString(v: Float) : String {
    return "" + v;
  }
}
private class StackItemShow{
  static public function toString(s:StackItem){
    return
      switch (s){
        case CFunction                      : 'function';
        case Module( m )                    : m;
        case FilePos( si , _ , line )       : toString(si) + ':$line';
        case Method( classname , method )   : '$classname.$method';
        case LocalFunction( v )             : '@$v';
      }
  }
}
private class BoolShow {
	public static function toString(v : Bool) : String {
    return if (v) "true" else "false";
  }
}

typedef ShowFailure     = stx.fail.ShowFailure;
typedef ShowFailureSum  = stx.fail.ShowFailure.ShowFailureSum;

typedef ShowableDef<T>  = stx.show.Showable.ShowableDef<T>;
typedef ShowableCls<T>  = stx.show.Showable.ShowableCls<T>;
typedef ShowableApi<T>  = stx.show.Showable.ShowableApi<T>;
typedef Showable<T>     = stx.show.Showable.Showable<T>;