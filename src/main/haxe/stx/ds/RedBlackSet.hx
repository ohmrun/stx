package stx.ds;

import stx.ds.RedBlackTree.RedBlackTreeLift;

typedef RedBlackSetDef<T> = { data : RedBlackTreeSum<T>, with : Comparable<T> }; 

@:using(stx.ds.RedBlackSet.RedBlackSetLift)
@:forward abstract RedBlackSet<T>(RedBlackSetDef<T>) from RedBlackSetDef<T>{
  

  private function new(self){
    this = self;
  }
  static public function String():RedBlackSet<String>{
    return make(Comparable.String());
  }
  @:noUsing static public function make<T>(with:Comparable<T>,?data:RedBlackTree<T>):RedBlackSet<T>{
    return new RedBlackSet({
      with : with,
      data : data == null ? Leaf : data
    });
  }
  @:noUsing static public function make_with<T>(ord:Ord<T>,eq:Eq<T>,?data:RedBlackTree<T>):RedBlackSet<T>{
    var with : Comparable<T> = new stx.assert.comparable.term.Base(eq,ord);
    return make(with,data);
  }
  @:to public function toIterable():Iterable<T>{
    return {
      iterator : iterator
    };
  }
  @:to public inline function toIter():Iter<T>{
    return (toIterable():Iter<T>);
  }
  public function iterator(){
    return RedBlackTreeLift.iterator(this.data);
  }
  public function difference(that:RedBlackSet<T>):RedBlackSet<T>{
    return RedBlackSetLift.filter(self,(v) -> !(that.uses(self.with).has(v)));
  }
  public function has(v:T):Bool{
    return RedBlackSetLift.has(this,v);

  }
  public function equals(that:RedBlackSet<T>):Equaled{
    return RedBlackSetLift.union(self,that).fold(
      (next,memo:Equaled) -> memo && (has(next) ? AreEqual : NotEqual), 
      AreEqual
    );
  }
  public function uses(with:Comparable<T>):RedBlackSet<T>{
    return { data : this.data, with : with };
  }
  public function lt(that:RedBlackSet<T>):Ordered{
    return that.difference(this).fold((next,memo)-> memo++,0) > 0 ? LessThan : NotLessThan;    
  }
  private var self(get,never):RedBlackSet<T>;
  private function get_self():RedBlackSet<T> return this;

  public function toString(){
    return RedBlackSetLift.toString(this);
  }
  public function unit():RedBlackSet<T>{
    return make(this.with);
  }
  public function copy(?with,?data){
    return make(
      __.option(with).defv(this.with),
      __.option(data).defv(this.data)
    );
  }
}

class RedBlackSetLift{

  static public function balance<V>(set:RedBlackSet<V>):RedBlackSet<V>{
    return { data : RedBlackTreeLift.balance(set.data), with : set.with };
  }
  static public function put<V>(set: RedBlackSet<V>, val: V): RedBlackSet<V> {
    function ins(tree: RedBlackTree<V>, comparator: Assertion<V,AssertFailure>): RedBlackTree<V> {
      return switch (tree) {
        case Leaf: 
          Node(Red, Leaf, val, Leaf);
        case Node(color, left, v, right):
            if (comparator.comply(val, v).is_ok())
                RedBlackTreeLift.balance(Node(color, ins(left, comparator), v, right))
            else if (comparator.comply(v, val).is_ok())
                RedBlackTreeLift.balance(Node(color, left, v, ins(right, comparator)))
            else
                Node(color,left, val, right);//HMMM
      }
    };
    return switch (ins(set.data, set.with.lt())) {
      case Leaf:
          throw "Never reach here";
      case Node(_, left, label, right):
          { data: Node(Black, left, label, right), with: set.with };
    }
  }
  static public function concat<V>(set:RedBlackSet<V>,xs:Iterable<V>):RedBlackSet<V>{
    for(x in xs){
      set = set.put(x);
    }
    return set;
  }
  static public function toString<V>(set:RedBlackSet<V>):String{
    return RedBlackTreeLift.toString(set.data);
  }
  static public function rem<V>(set:RedBlackSet<V>, value:V): RedBlackSet<V>{
    var balance = RedBlackTreeLift.balance;
    var eq      = set.with.eq;
    var lt      = set.with.lt;

    function cons(data):RedBlackTree<V>{
      return data;
    }
    function s(v:RedBlackTree<V>){
      return RedBlackTreeLift.toString(v);
    }
    function merge(l:RedBlackTree<V>,r:RedBlackTree<V>){
      //trace('${s(l)}\n${s(r)}');
      return switch([l,r]){
        case [Leaf,v] : v;
        case [v,Leaf] : v;
        case [Node(c0,l0,v0,r0),Node(c1,l1,v1,r1)] if (lt().comply(v0,v1).is_ok()):
          balance(Node(c1,merge(l,l1),v1,r1));
        case [Node(c0,l0,v0,r0),Node(c1,l1,v1,r1)] if (lt().comply(v1,v0).is_ok()):
          balance(Node(c0,merge(l0,r),v0,r0));
        default : Leaf;
      }
    }
    function rec(data:RedBlackTree<V>):RedBlackTree<V>{
      return switch (data) {
        case Leaf                 : cons(Leaf);
        case Node(c,l,v,r):
        if(eq().comply(value,v).is_ok()){
          switch([l,r]){
            case [Leaf,v] : 
              cons(v);
            case [v,Leaf] : 
              cons(v);
            case [Node(c0,l0,v0,r0),Node(c1,l1,v1,r1)] :
              var out = merge(l,r);
              //trace(RedBlackTreeLift.toString(r));
              out;
          }
        }else if(lt().comply(value,v).is_ok()){
          cons(Node(c,rec(l),v,r));
        }else if(lt().comply(v,value).is_ok()){
          cons(Node(c,l,v,rec(r)));
        }else{
          data;
        }
        default : data;            
      }
    }
    return RedBlackSet.make(set.with,rec(set.data));
  }
  static public function has<V>(set:RedBlackSet<V>,val):Bool{
    function hs(tree: RedBlackTree<V>, with: Comparable<V>): Bool {
      return switch (tree) {
        case Leaf: 
          false;
        case Node(color, left, v, right):
          if(with.eq().comply(val,v).is_ok()){
            true;
          }else if(with.lt().comply(val, v).is_ok()){
            hs(left, with);
          }else if (with.lt().comply(v, val).is_ok()){
            hs(right,with);
          }else{
            false;
          }
      }
    };
    return hs(set.data,set.with);
  }
  static public function split<V>(self:RedBlackSet<V>,item:V){
    final balance = RedBlackTreeLift.balance;
    final cons    = (data) -> RedBlackSet.make(self.with,data);
    function merge(l:RedBlackTree<V>,r:RedBlackTree<V>){
      //trace('${s(l)}\n${s(r)}');
      return switch([l,r]){
        case [Leaf,v] : v;
        case [v,Leaf] : v;
        case [Node(c0,l0,v0,r0),Node(c1,l1,v1,r1)] if (self.with.lt().comply(v0,v1).is_ok()):
          balance(Node(c1,merge(l,l1),v1,r1));
        case [Node(c0,l0,v0,r0),Node(c1,l1,v1,r1)] if (self.with.lt().comply(v1,v0).is_ok()):
          balance(Node(c0,merge(l0,r),v0,r0));
        default : Leaf;
      }
    }
    function rec(x:RedBlackSet<V>):Couple<RedBlackSet<V>,RedBlackSet<V>>{
      return switch(x.data){
        case Leaf                           : __.couple(self.unit(),self.unit());
        case Node(_, left, label , right)   : 
          if(self.with.lt().comply(item,label).is_ok() || self.with.lt().comply(item,label).is_ok()){  
          final next = cons(left);
          rec(next).decouple(
            (l:RedBlackSet<V>,r:RedBlackSet<V>) -> __.couple(
              l,
              cons(merge(cons(right).put(label).data,r.data))
            )
          );
          }else{
            final next = cons(right);
            rec(next).decouple(
              (l:RedBlackSet<V>,r:RedBlackSet<V>) -> __.couple(
                  cons(merge(cons(left).put(label).data,l.data)),
                  r
              )
            );
          }
      }
    }
    return rec(self);
  }
  static public function fold<T,U>(self:RedBlackSet<T>,fn:T->U->U,z:U):U{
    var memo = z;
    for(next in self){
      memo = fn(next,memo);
    }
    return memo;
  }
  static public function toArray<T>(self:RedBlackSet<T>):Array<T>{
    var itr = self.iterator();
    var out = [];
    while(itr.hasNext()){
      out.push(itr.next());
    }
    return out;
  }
  static public function toCluster<T>(self:RedBlackSet<T>):Cluster<T>{
    return Cluster.lift(toArray(self));
  }
  static public function union<T>(self:RedBlackSet<T>,that:RedBlackSet<T>):RedBlackSet<T>{
    for(val in that){
      self = self.put(val);
    }
    return self;
  }
  static public function difference<T>(self:RedBlackSet<T>,that:RedBlackSet<T>):RedBlackSet<T>{
    for(val in that){
      //trace(val);
      self = self.rem(val);
    }
    return self;
  }
  static public function symmetric_difference<T>(self:RedBlackSet<T>,that:RedBlackSet<T>):RedBlackSet<T>{
    var a = self.difference(that);
    var b = that.difference(self);
    return a.union(b);
  }
  static public function filter<T>(self:RedBlackSet<T>,fn:T->Bool):RedBlackSet<T>{
    var next = RedBlackSet.make(self.with);
    for(val in self){
      if(fn(val)){
        next = next.put(val);
      }
    }
    return next;
  }
  static public function equals<T>(self:RedBlackSet<T>,that:RedBlackSet<T>):Equaled{
    return union(self,that).fold(
      (next,memo:Equaled) -> memo && (has(self,next) ? AreEqual : NotEqual), 
      AreEqual
    );
  }
  static public function less_than<T>(self:RedBlackSet<T>,that:RedBlackSet<T>):Ordered{
    final l_iter = self.iterator();
    final r_iter = that.iterator();
    var res = NotLessThan;
    while(true){ 
      switch([l_iter.hasNext(),r_iter.hasNext()]){
        case [true,true] : 
          res = self.with.lt().comply(l_iter.next(),r_iter.next());
          if(res == LessThan){
            break;
          }
        case [true,false] : 
          res = NotLessThan;
          break;
        case [false,true] : 
          res = LessThan;
          break;
        case [false,false] :
          res;
      }
    }
    return res;
  }
  static public function is_defined<T>(self:RedBlackSet<T>):Bool{
    return !(self.data == Leaf);
  }
  static public function last<T>(self:RedBlackSet<T>):Option<T>{
    function rec(self:RedBlackTree<T>,def:Option<T>){
      return switch(self){
        case Leaf                     : def;
        case Node(_,_, label, right)  : rec(right,Some(label));
      }
    }
    return rec(self.data,None);
  }
}