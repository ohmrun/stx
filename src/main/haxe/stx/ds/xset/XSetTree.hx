package stx.ds.xset;

typedef XSetTreeDef     = XSet<XSetPlace,Primitive>;

abstract XSetTree(XSetTreeDef) from XSetTreeDef{
  static public var _(default,never) = XSetTreeLift;
  public function new(self:XSetTreeDef){
    this = self;
  }
  static public function unit():XSetTree{
    return XSet.makeKV(
      new stx.assert.ds.xset.comparable.term.XSetPlace(),
      new stx.assert.comparable.term.Primitive()
    );
  }
  public function isObject(){
    return this.data.fold(
      (sv,memo) -> switch([sv.fst(),memo]){ 
        case [_,false]            : false;
        case [Field(idx, key),_]  : true;
        case [Index(idx),_]       : false; 
      },
      true
    );
  }
  public function isCluster(){
    return this.data.fold(
      (sv,memo) -> switch([sv.fst(),memo]){
        case [_,false]            : false;
        case [Field(idx, key),_] : false;
        case [Index(idx),_]      : true; 
      },
      true
    );
  }
  public function getType(){
    return switch([isCluster(),isObject()]){
      case [false,true] : DTObject;
      case [true,false] : DTCluster;
      default           : DTMixed;
    }
  }
  public function put(v:XSetTreeVal):XSetTree{
    return this.put(v);
  }
  public function prj():XSetTreeDef{
    return this;
  }
  public function keyspace():XSetTree{
    return this.keyspace();
  }
  @:noUsing static public function fromSpine(sp:Spine<Nada>):XSetTree{
    var rec = null;
        rec = 
    function(sp):XSetTreeDef{
      return switch sp {
        case Collate(arr) : 
          var out = arr.prj().imap(
            (i:Int,kv:Field<Thunk<Spine<Nada>>>) -> {
              return switch(kv.val()){
                case Primate(p) : SetVal(Field(i,kv.key),p);
                case x          : SetObj(Field(i,kv.key),rec(x));
              }
            }
          ).lfold(
            (n:XSetVal<XSetPlace,Primitive>,m:XSetTreeDef) -> m.put(n),
            XSetTree.unit().prj()
          );
          out;
        case Collect(arr)  :   
          var out = arr.imap(
            (i,v) -> switch(v()){
              case Primate(p) : SetVal(Index(i),p);
              case x          : SetObj(Index(i),rec(x));
            }
          ).lfold(
            (n:XSetVal<XSetPlace,Primitive>,m:XSetTreeDef) -> m.put(n),
            XSetTree.unit().prj()
          );
          out;
        case Unknown | Predate(_): 
          XSetTree.unit().prj();
        case x:
          throw(x);
          XSetTree.unit().prj();
      }
    }
    return new XSetTree(rec(sp));
  }
  private var self(get,never):XSetTree;
  private function get_self():XSetTree return this;

  public function get(key:String):XSetTree{
    return this.filter(
      (x:XSetTreeVal) -> x.fold(
        (k,v) -> k.has_key(key),
        (k,v) -> k.has_key(key)
      )
    );
  }
  public function hoist(key:String):XSetTree{
    return this.mod(
      (next:XSetTreeVal) -> next.fold(
          (p:XSetPlace,x) -> p.fold(
            (i,k) -> k == key ? SetObj(Index(stx.ds.xset.tree.Counter.instance.next()),x)  : SetObj(Field(i,k),x),
            (i)   -> SetObj(Index(i),x) 
          ),
          (p:XSetPlace,x) -> p.fold(
            (i,k) -> k == key ? SetVal(Index(stx.ds.xset.tree.Counter.instance.next()),x)  : SetVal(Field(i,k),x)  ,
            (i)   -> SetVal(Index(i),x) 
          )
      )
    );
  }
  public function toString(){
    return this.data.toString();
  }
}
class XSetTreeLift{
  static public function Cluster(?data:Cluster<XSetTreeData>){
    return __.option(data)
      .map((x:Cluster<XSetTreeData>) -> XSetTreeDataCluster.pure(x))
      .def(XSetTreeDataCluster.unit);
  }
  static public function Val(key:XSetPlace,val:XSetTreeData){
    return XSetTreeVal.make(key,val);
  }
  static public function Idx(val:XSetTreeData){
    return XSetTreeVal.make(Index(stx.ds.xset.tree.Counter.instance.next()),val);
  }
}