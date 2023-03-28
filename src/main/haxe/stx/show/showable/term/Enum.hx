package stx.show.showable.term;

class Enum extends ShowableCls<Dynamic>{
  final type : StdEnum<Dynamic>;
  public function new(type){
    super();
    this.type = type;
  }
  public function show(self:Dynamic,state:State):Res<Response,ShowFailure>{
    return throw UNIMPLEMENTED;
  }
}