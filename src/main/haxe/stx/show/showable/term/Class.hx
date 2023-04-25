package stx.show.showable.term;

import Class as TClass;

class Class extends ShowableCls<Dynamic>{
  final type : TClass<Dynamic>;
  public function new(type){
    super();
    this.type = type;
  }
  public function show(self:Dynamic,state:State):Upshot<Response,ShowFailure>{
    
    return throw UNIMPLEMENTED;
  }
}