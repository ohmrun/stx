package stx.coroutine.core;

@:forward abstract Digest(Lapse<Nada>) from Lapse<Nada> to Lapse<Nada>{
  public function new(note:CoroutineFailureNote,detail,?pos:Pos){
    this = new LapseCtr().Digest(
      "d905e32c-edd4-4e2b-b044-fb3d643cab57",
      '$detail',
      null,
      _ ->  Loc.fromPos(pos)
    );
  }
}