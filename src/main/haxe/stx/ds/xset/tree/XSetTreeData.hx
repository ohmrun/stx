package stx.ds.xset.tree;


typedef XSetTreeDataDef = Either<Primitive,XSetTree>;

@:forward(fold) abstract XSetTreeData(XSetTreeDataDef) from XSetTreeDataDef to XSetTreeDataDef{
  public function new(self) this = self;
  @:noUsing static public function lift(self:XSetTreeDataDef):XSetTreeData return new XSetTreeData(self);

  public function prj():XSetTreeDataDef return this;
  private var self(get,never):XSetTreeData;
  private function get_self():XSetTreeData return lift(this);

  @:from static public function fromPrimitive(self:Primitive){
    return lift(__.left(self));
  }
  @:from static public function fromInt(self:Int){
    return fromPrimitive(self);
  }
  @:from static public function fromXSetTree(self:XSetTree){
    return lift(__.right(self));
  }
  public function label(place:XSetPlace):XSetVal<XSetPlace,Primitive>{
    return this.fold(
      l -> XSetVal.fromValCouple(__.couple(place,l)),
      r -> XSetVal.fromObjCouple(__.couple(place,r.prj()))
    );
  }
}