package stx.show.showable.term;

class Int extends ShowableCls<StdInt>{
  public function show(self:StdInt,state:State):Upshot<Response,ShowFailure>{
    return new stx.show.showable.term.String().show('$self',state);
  }
}