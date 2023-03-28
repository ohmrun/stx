package stx.ds.xset.tree;

typedef XSetTreeValDef  = XSetVal<XSetPlace,Primitive>;

@:forward(fold) abstract XSetTreeVal(XSetTreeValDef) from XSetTreeValDef to XSetTreeValDef{
  public function new(self) this = self;
  @:noUsing static public function lift(self:XSetTreeValDef):XSetTreeVal return new XSetTreeVal(self);

  public function prj():XSetTreeValDef return this;
  private var self(get,never):XSetTreeVal;
  private function get_self():XSetTreeVal return lift(this);

  @:noUsing static public function make(key:XSetPlace,val:XSetTreeData){
    return lift(val.fold(
      l -> XSetVal.fromValCouple(__.couple(key,l)),
      r -> XSetVal.fromObjCouple(__.couple(key,r.prj()))
    ));
  }
}