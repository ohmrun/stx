package eu.ohmrun.glot.expr;

import stx.fail.OMFailure;
using eu.ohmrun.Pml;
using eu.ohmrun.pml.term.PmlSpine;

import stx.om.spine.glot.FromGlot;

class GMetadataCtr extends Clazz{
  public function Make(meta:CTR<GMetadataEntryCtr,Array<GMetadataEntry>>){
    return GMetadata.lift(meta.apply(new GMetadataEntryCtr()));
  }
}
typedef GMetadataDef = Cluster<GMetadataEntry>;

@:using(eu.ohmrun.glot.expr.GMetadata.GMetadataLift)
@:forward abstract GMetadata(GMetadataDef) from GMetadataDef to GMetadataDef{
  public function new(self) this = self;
  @:noUsing static public function lift(self:GMetadataDef):GMetadata return new GMetadata(self);
  static public function unit(){
    return lift(Cluster.unit());
  }
  public function prj():GMetadataDef return this;
  private var self(get,never):GMetadata;
  private function get_self():GMetadata return lift(this);

  @:from static public function fromArray(self:Array<GMetadataEntry>){
    return lift(Cluster.lift(self));
  }
  // public function toSource(){
  //   return this.map(x -> x.toSource()).join(' ');
  // }
}
class GMetadataLift{
  #if macro
  static public function to_macro_at(self:GMetadata,pos:Position):Metadata{
    return @:privateAccess self.map(e -> e.to_macro_at(pos)).prj();
  }
  #end
  static public function toSpine(self:GMetadata){
    final glot = __.accept(self).flat_map(
      arr -> Upshot.bind_fold(
        arr.prj(),
        (next,memo:Cluster<Spine>) -> {
          return Upshot.bind_fold(
            next.params,
            (nextI,memoI:Cluster<Spine>) -> {
              return new FromGlot().apply(nextI).map(
                spine -> spine.flat_map(
                  function recI(s){
                    return s.detuple(
                      (l,r) -> 
                        Collect(
                          [() -> Primate(PSprig(Textal(l)))].concat(r.map(x -> () -> x.flat_map(recI)))///TODO should this be flat?
                        )
                    );
                  }
                )
              ).map(memoI.snoc);
            },
            [].imm()
          ).map(memo.concat); 
        },
        [].imm()
      )
    );
    return glot;
  }
  static public function toPml(self:GMetadata):Upshot<Cluster<Tup2<String,Cluster<PExpr<Atom>>>>,OMFailure>{
    return __.accept(self).flat_map(
      glot -> Upshot.bind_fold(
        glot.prj(),
        (next:GMetadataEntry,memo:Cluster<Tup2<String,Cluster<PExpr<Atom>>>>) -> {
          return Upshot.bind_fold(
            next.params,
            (nextI:GExpr,memoI:Cluster<Spine>) -> {
              return nextI.toSpine().map(
                s -> s.toSpineNada()
              ).map(memoI.snoc);
            },
            [].imm()
          ).map(
            (arr) -> memo.snoc(tuple2(next.name,arr.map(x -> x.toPml()))) 
          );
        },
        [].imm()
      )
    );
  }
  // static public function denote(self:GMetadata){
  //   final e = __.glot().expr();
  //   return e.ArrayDecl(
  //     self.map()
  //   );
  // }
}