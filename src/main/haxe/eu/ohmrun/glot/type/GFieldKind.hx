package eu.ohmrun.glot.type;


enum GFieldKind {
	GFVar(read:VarAccess, write:VarAccess);
	GFMethod(k:MethodKind);
}
