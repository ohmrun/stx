package eu.ohmrun.glot.type;

typedef GEnumType = GBaseType & {
	var constructs:Map<String, GEnumField>;
	var names:Cluster<String>;
}
