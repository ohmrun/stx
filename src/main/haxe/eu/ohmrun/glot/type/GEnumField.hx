package eu.ohmrun.glot.type;

typedef GEnumField = {
	var name:String;
	var type:GType;
	var meta:GMetadata;
	var index:Int;
	var doc:Null<String>;
	var params:Cluster<GTypeParameter>;
}
