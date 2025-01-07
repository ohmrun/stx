package eu.ohmrun.glot.type;

typedef GTVar = {
  final id : Int;
  final name : String;
  final t : GType;
  final capture : Bool;
  final extra :Null<{params:Array<GTypeParameter>, expr:Null<GTypedExpr>}>;
  final meta:Null<GMetadata>;
	final isStatic:Bool;
}