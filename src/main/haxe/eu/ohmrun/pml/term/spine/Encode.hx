package eu.ohmrun.pml.term.spine;

class Encode extends Clazz{
  public function apply(self:Spine):PExpr<Atom>{
    return switch(self){
      case Unknown      : PEmpty;
      case Predate(v)   : PEmpty; 
      case Primate(sc)  : PValue(Atom._.fromPrimitive(sc));
      case Collate(arr) : PAssoc(arr.prj().map(
        fld -> tuple2(PLabel(fld.fst()),apply(fld.snd()()))
      ));
      case Collect(arr) : PArray(arr.map(x -> apply(x())));
    }
  }
}