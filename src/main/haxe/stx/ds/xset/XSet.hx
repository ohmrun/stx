package stx.ds.xset;

typedef XSetDef<K,V> = {
  with : XSetWith<K,V>,
  data : RedBlackSet<XSetVal<K,V>>,
}

@:forward abstract XSet<K,V>(XSetDef<K,V>) from XSetDef<K,V> to XSetDef<K,V> {
  
  @:noUsing static public function makeKV<K,V>(key:Comparable<K>,val:Comparable<V>,?data:RedBlackTree<XSetVal<K,V>>){
    var with = new XSetWith(new With(key,val));
    return XSet.create(with,RedBlackSet.make(with.comparable(),data));
  }
  @:noUsing static public function make<K,V>(with:With<K,V>,?data:RedBlackTree<XSetVal<K,V>>){
    var with = new XSetWith(with);
    return new XSet({ with : with , data : RedBlackSet.make(with.comparable(),data) });
  }
  @:noUsing static public function create<K,V>(with:XSetWith<K,V>,data:RedBlackSet<XSetVal<K,V>>){
    return new XSet({ with : with, data : data});
  }
  @:noUsing static public function lift<K,V>(self:XSetDef<K,V>){
    return new XSet(self);
  }
  private function new(self:XSetDef<K,V>){
    this = self;
  }
  public function ltx(that:XSet<K,V>,with:Comparable<XSetVal<K,V>>):Ordered{
    var current = this.data.with;
    var self    = uses(with);
    return self.lt(that);
  }
  function next(data):XSet<K,V>{
    return create(this.with,data);
  }
  public function uses(with:Comparable<XSetVal<K,V>>):XSet<K,V>{
    return next(this.data.uses(with));
  }
  public function whilst(with:Comparable<XSetVal<K,V>>,fn:XSet<K,V>->XSet<K,V>):XSet<K,V>{
    var current = this.data.with;
    var next    = uses(with);
    var last    = fn(next).uses(current);
    return last;
  }
  public function lt(that:XSet<K,V>):Ordered{
    return this.data.lt(that.data);
  }
  public function eq(that:XSet<K,V>):Equaled{
    return this.data.equals(that.data);
  }
  public function eqx(that:XSet<K,V>,with:Comparable<XSetVal<K,V>>):Equaled{
    var current = this.with;
    var self    = uses(with);
    return self.eq(that);
  }
  public function put(v:XSetVal<K,V>):XSet<K,V>{
    return next(this.data.put(v));
  }
  public function set(k:K,v:Either<XSet<K,V>,V>):XSet<K,V>{
    return switch(v){
      case Left(v)  : put(SetObj(k,v));
      case Right(v) : put(SetVal(k,v));
    }
  }
  public function set_val(k:K,v:V){
    return set(k,Right(v));
  }
  public function set_set(k:K,v:XSet<K,V>){
    return set(k,Left(v));
  }
  function as(st:XSetWithState):XSet<K,V>{
    return create(this.with.as(st),this.data);
  }
  public function keyspace():XSet<K,V>{
    return uses(this.with.keyspace().comparable()).as(CKey);
  }
  public function valspace():XSet<K,V>{
    return uses(this.with.valspace().comparable()).as(CVal);
  }
  public function setspace():XSet<K,V>{
    return uses(this.with.setspace().comparable()).as(CKeyVal);
  }
  public function has(v){
    return this.data.has(v);
  }
  public function has_key(k:K){
    return keyspace().has(
      SetVal(k,null)
    );
  }
  public function has_node(v:XSet<K,V>){
    return valspace().has(
      SetObj(null,v)
    );
  }
  public function has_leaf(v:V){
    return valspace().has(
      SetVal(null,v)
    );
  }
  public function filter(fn){
    return next(this.data.filter(fn));
  }
  public function restrict(itr:Array<K>){
    return filter(
      (item) -> keyspace().has(item)
    );
  }
  public function difference(that:XSet<K,V>){
    return next(this.data.difference(that.data));
  }
  public function toString(){
    return this.data.toString();
  }
  public function mod(fn:XSetVal<K,V> -> XSetVal<K,V>){
    return create(this.with,this.data.fold(
      (next:XSetVal<K,V>,memo:RedBlackSet<XSetVal<K,V>>) -> memo.put(fn(next)),
      RedBlackSet.make(this.data.with)     
    ));
  }
}