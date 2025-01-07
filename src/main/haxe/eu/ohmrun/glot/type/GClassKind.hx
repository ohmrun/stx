package eu.ohmrun.glot.type;

enum GClassKind {
	GKNormal;
	GKTypeParameter(constraints:Cluster<GType>);
	GKModuleFields(module:String);
	GKExpr(expr:GExpr);
	GKGeneric;
	GKGenericInstance(cl:GRef<GClassType>, params:Cluster<GType>);
	GKMacroType;
	GKAbstractImpl(a:GRef<GAbstractType>);
	GKGenericBuild;
}
