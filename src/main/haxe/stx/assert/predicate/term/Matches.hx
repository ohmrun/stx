package stx.assert.predicate.term;


class Matches<E> extends Base<String>{
  var fault : Fault;
  var match : String;
  var opt   : String;

  public function new(fault,match,opt="g",?pos){
    super(pos);
    this.fault  = fault;
    this.match  = match;
    this.opt    = opt;
  }
  override public function apply(v:String):Report<AssertFailure>{
    var err   = error('~/${match}/${opt}' ,v);
    var ereg  = new EReg(match,opt);
        ereg.match(v);
    var bool  = ereg.matched(0) == null;
    
    return bool.expect(err);
  }
}