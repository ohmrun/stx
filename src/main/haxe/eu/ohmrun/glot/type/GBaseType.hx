package eu.ohmrun.glot.type;

typedef GBaseType = {
	var pack:Cluster<String>;
	var name:String;
	var module:String;
	var isPrivate:Bool;
	var isExtern:Bool;
	var params:Array<GTypeParameter>;
	var meta:GMetadata;
	var doc:Null<String>;
}
