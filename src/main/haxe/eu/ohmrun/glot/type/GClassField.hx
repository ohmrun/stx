package eu.ohmrun.glot.type;


typedef GClassField = {
	var name:String;
	var type:Type;
	var isPublic:Bool;
	var isExtern:Bool;
	var isFinal:Bool;
	var isAbstract:Bool;
	var params:Cluster<GTypeParameter>;
	var meta:GMetadata;
	var kind:GFieldKind;
	function expr():Null<GTypedExpr>;
	var doc:Null<String>;
	var overloads:GRef<Cluster<GClassField>>;
}