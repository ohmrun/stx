package eu.ohmrun.glot.type;

typedef GAbstractType = GBaseType & {
	var type:GType;
	var impl:Null<GRef<GClassType>>;
	var binops:Cluster<{op:GBinop, field:GClassField}>;
	var unops:Cluster<{op:GUnop, postFix:Bool, field:GClassField}>;
	var from:Cluster<{t:GType, field:Null<GClassField>}>;
	var to:Cluster<{t:GType, field:Null<GClassField>}>;
	var array:Cluster<GClassField>;
	var resolve:Null<GClassField>;
	var resolveWrite:Null<GClassField>;
}
