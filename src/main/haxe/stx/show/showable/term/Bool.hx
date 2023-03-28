package stx.show.showable.term;

class Bool extends ShowableCls<StdBool>{
  public function show(self:StdBool,state:State):Res<Response,ShowFailure>{
    return new stx.show.showable.term.String().show('$self',state);
  }
}