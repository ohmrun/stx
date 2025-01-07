package stx.parse.parser.term;

class AnonFlatMap<P,Ri,Rii> extends FlatMap<P,Ri,Rii>{
  final _flat_map : (rI:Ri) -> Parser<P,Rii>;
  public function new(delegate,flat_map,pos){
    this._flat_map = flat_map;
    super(delegate,pos);
  }
  public function flat_map(rI:Ri):Parser<P,Rii>{
    return this._flat_map(rI);
  }
}