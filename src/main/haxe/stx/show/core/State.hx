package stx.show.core;

class State{
  public final options   : Options;
  public final request   : Request;
  public final cache     : Cluster<Dynamic>;

  public function new(options,request,cache){
    this.options  = options;
    this.request  = request;
    this.cache    = cache;
  }
  static public function make(options,request,cache){
    return new State(options,request,cache);
  }
  static public function make0(?options,?request,?cache){
    return new State(
      __.option(options).defv(Options.unit()),
      __.option(request).defv(Request.unit()),
      __.option(cache).defv([].imm())
    );
  }
  public function copy(?Int,?options,?xindex,?request,?cache){
    return make(
      __.option(options).defv(this.options),
      __.option(request).defv(this.request),
      __.option(cache).defv(this.cache)
    );
  }
  public var width(get,null):Int;
  public function get_width(){
    return this.options.width;
  }
  public var width_remaining(get,null):Int;
  public function get_width_remaining(){
    return this.width - this.request.xindex;
  }
  public function lookup<T>(block:Block):Showable<T>{
    return (new stx.show.showable.term.Mono().toShowable():Showable<T>);
  }
  public function with_request(fn:Request->Request){
    return make(this.options,fn(request),this.cache);
  }
  public function respond(width,height,prefix,postfix,children,node){
    var r = this.request;
    return Response.make(this,width,height,prefix,postfix,children,node);
  }
}