package eu.ohmrun.pml.term.spine;

import stx.nano.Chars.CharsLift;
import stx.nano.Cluster.ClusterLift;


class Encode extends Clazz{
  public function apply(self:Spine):PExpr<Atom>{
    return switch(self){
      case Unknown      : PEmpty;
      case Predate(v)   : PEmpty; 
      case Primate(sc)  : 
        PValue(eu.ohmrun.pml.Atom.AtomLift.fromPrimitive(sc));
      case Collate(arr) if 
        (ClusterLift.head(arr.prj()).map(x -> CharsLift.starts_with(x.key,"#")).defv(false)
        && arr.size() == 1)
        :
        final fst = ClusterLift.head(arr.prj()).fudge();
        PApply(fst.key,apply(fst.val()));
      case Collate(arr) : PAssoc(arr.prj().map(
        fld -> tuple2(PLabel(fld.fst()),apply(fld.snd()()))
      ));
      case Collect(arr) : PArray(arr.map(x -> apply(x())));
    }
  }
}