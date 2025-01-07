package eu.ohmrun.glot.type;

enum GModuleType {
	GTClassDecl(c:GRef<GClassType>);
	GTEnumDecl(e:GRef<GEnumType>);
	GTTypeDecl(t:GRef<GDefType>);
	GTAbstract(a:GRef<GAbstractType>);
}