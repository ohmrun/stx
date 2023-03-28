package stx.show.core;

class Request{
  public final xindex   : Int;
  public final yindex   : Int;
  public final node     : Option<LayoutNode>;

  public function new(xindex,yindex,node){
    this.xindex   = xindex;
    this.yindex   = yindex;
    this.node     = node;
  }
  @:noUsing static public function make(xindex,yindex,node){
    return new Request(xindex,yindex,node);
  }
  static public function unit(){
    return new Request(0,0,None);
  }
  public function with_node(fn:Option<LayoutNode>->Option<LayoutNode>){
    return new Request(this.xindex,this.yindex,fn(node));
  }
  public function with_xindex(i:Int){
    return make(i,yindex,node);
  }
}