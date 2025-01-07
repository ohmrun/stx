package eu.ohmrun.glot.type;

enum GAnonStatus {
	GAClosed;
	GAOpened;
	GAConst;
	GAExtend(tl:GRef<Cluster<GType>>);
	GAClassStatics(t:GRef<GClassType>);
	GAEnumStatics(t:GRef<GEnumType>);
	GAAbstractStatics(t:GRef<GAbstractType>);
}