package stx.ds.xset;

import stx.assert.comparable.term.Base in BaseComparable;

class XSetWith<K,V> extends Clazz{
  public var state(default,null)   : XSetWithState;  
  public var with(default,null)    : With<K,V>;

  public function new(with,?state){
    super();
    this.state  = state == null ? CKeyVal : state;
    this.with   = with;
  }
  public function as(st:XSetWithState):XSetWith<K,V>{
    return new XSetWith(this.with,st);
  }
  public function comparable():Comparable<XSetVal<K,V>>{
    return new XSetWithComparable(this);
  }
  public function keyspace(){
    return as(CKey);
  }
  public function valspace(){
    return as(CVal);
  }
  public function setspace(){
    return as(CKeyVal);
  }
  static public function key<K,V>(c:Comparable<K>):Comparable<XSetVal<K,V>>{
    return new XSetKeyComparable(c);
  }
  static public function val<K,V>(c:Comparable<V>):Comparable<XSetVal<K,V>>{
    return new XSetValComparable(c);
  }
  static public function kv<K,V>(with:With<K,V>):Comparable<XSetVal<K,V>>{
    return new XSetComparable(with);
  }
  public function toString(){
    return identifier();
  }
}