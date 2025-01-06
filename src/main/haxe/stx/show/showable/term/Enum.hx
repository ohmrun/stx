package stx.show.showable.term;

import stx.alias.StdEnum;

class Enum extends ShowableCls<Dynamic>{
  final type : StdEnum<Dynamic>;
  public function new(type){
    super();
    this.type = type;
  }
  public function show(self:Dynamic,state:State):Upshot<Response,ShowFailure>{
    return throw UNIMPLEMENTED;
  }
}