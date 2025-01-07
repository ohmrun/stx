package eu.ohmrun.glot.type;

enum GTypeSum {
	TMono(t:GRef<Null<GTypeSum>>);
	TEnum(t:GRef<GEnumType>, params:Array<GTypeSum>);
	TInst(t:GRef<GClassType>, params:Array<GTypeSum>);
	TType(t:GRef<GDefType>, params:Array<GTypeSum>);
	TFun(args:Cluster<{name:String, opt:Bool, t:GTypeSum}>, ret:GTypeSum);
	TAnonymous(a:GRef<GAnonType>);
	TDynamic(t:Null<GTypeSum>);
	TLazy(f:Void->GTypeSum);
	TAbstract(t:GRef<GAbstractType>, params:Cluster<GTypeSum>);
}
abstract GType(GTypeSum) from GTypeSum to GTypeSum{
	public function new(self) this = self;
	@:noUsing static public function lift(self:GTypeSum):GType return new GType(self);

	public function prj():GTypeSum return this;
	private var self(get,never):GType;
	private function get_self():GType return lift(this);
}