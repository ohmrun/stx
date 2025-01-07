package eu.ohmrun.glot.type;

enum GFieldAccess {
	GFInstance(c:GRef<GClassType>, params:Cluster<GType>, cf:GRef<GClassField>);
	GFStatic(c:GRef<ClassType>, cf:GRef<GClassField>);
	GFAnon(cf:GRef<GClassField>);
	GFDynamic(s:String);
	GFClosure(c:Null<{c:GRef<GClassType>, params:Cluster<GType>}>, cf:GRef<GClassField>);
	GFEnum(e:GRef<GEnumType>, ef:GEnumField);
}

