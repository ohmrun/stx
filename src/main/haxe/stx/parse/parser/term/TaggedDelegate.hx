package stx.parse.parser.term;

class TaggedDelegate<I,O> extends Base<I,O,Parser<I,O>>{
  public function new(delegation,tag,?pos:Pos){
    super(delegation,pos);
    this.tag = tag;
  }
  override function check(){
    __.assert().that(pos).exists(delegation);
  }
  public function apply(ipt){
    return this.delegation.apply(ipt);
  }
  override public function toString(){
    return '${this.tag}(${delegation})';
  }
}