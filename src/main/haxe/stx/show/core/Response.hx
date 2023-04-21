package stx.show.core;

class Response{
  public final state      : State;

  public final width      : Int;
  public final height     : Int;

  public final prefix     : Option<String>;
  public final postfix    : Option<String>;
  
  public final children   : Cluster<Response>;
  public final node       : LayoutNode;
  
  public function new(state,width,height,prefix,postfix,children,node){
    this.state    = state;
    this.width    = width;
    this.height   = height;
    this.prefix   = prefix;
    this.postfix  = postfix;
    this.children = children; 
    this.node     = node;
  }
  public var yextent(get,null):Int;
  public function get_yextent():Int{
    var extent = this.state.request.yindex + height;
    for(response in this.children){
      if(response.yextent > extent){
        extent = response.yextent;
      }
    }
    return extent;    
  }
  public var xextent(get,null):Int;
  public function get_xextent():Int{
    var extent = this.state.request.xindex + width;
    for(response in this.children){
      if(response.xextent > extent){
        extent = response.xextent;
      }
    }
    return extent;    
  }
  static public function make(state,width,height,prefix,postfix,children,node){
    return new Response(state,width,height,prefix,postfix,children,node);
  }
  static public function make0(state,width,height,?prefix,?postfix,?children,?node){
    return make(
      state,
      width,
      height,
      __.option(prefix).defv(None),
      __.option(postfix).defv(None),
      __.option(children).defv([].imm()),
      __.option(node).defv(LTree)
    );
  }
}