package eu.ohmrun.glot.type;

typedef GClassType = GBaseType & {
	var kind:GClassKind;
	var isInterface:Bool;
	var isFinal:Bool;
	var isAbstract:Bool;
	var superClass:Null<{t:GRef<GClassType>, params:Cluster<GType>}>;
	var interfaces:Cluster<{t:GRef<GClassType>, params:Cluster<GType>}>;
	var fields:GRef<Cluster<GClassField>>;
	var statics:GRef<Cluster<GClassField>>;
	var constructor:Null<GRef<GClassField>>;
	var init:Null<GTypedExpr>;
	var overrides:Cluster<GRef<GClassField>>;
}
