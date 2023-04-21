package stx.config.term;

typedef DirectoryDef = Attempt<HasDevice,Ensemble<stx.fs.path.Directory>,ConfigFailure>;

@:forward abstract Directory(DirectoryDef) to DirectoryDef{
  public function new(){
    this = __.attempt((state:HasDevice) -> {
      final bake      = Bake.pop();
      __.log().debug(_ -> _.pure(bake.defines));
      final dir  = bake.defines.map_filter(
        x -> x.key == 'stx.config.Directory' ? Some(x.value) : None
      );
      return Produce.bind_fold(
        dir.map(
          name -> __.f(Path.parse).then(x -> x.produce(state).errate(e -> (e:FsFailure)))(name).map(
            __.couple.bind(name)
          )
        ),
        (next:Produce<Couple<String,Raw>,FsFailure>,memo:Cluster<Couple<String,stx.fs.path.Directory>>) -> {
          return next.attempt(
            (couple:Couple<String,Raw>) -> {
              final that  = couple.snd().absolutize().command(
                __.command(
                  (address:Address) -> address.is_directory().produce(state).point(
                    b -> b.if_else(
                      () -> Execute.unit(),
                      () -> Execute.pure(__.fault().of(E_Path_ExpectedDirectory)).errate(e -> (e:FsFailure))
                    )
                  )
                )
              ).map(
                address -> address.toDirectory()
              ).map(
                directory -> memo.snoc(__.couple(couple.fst(),directory))
              ).produce(state);
              //$type(thatI);
              return that;
            }
          );
        },
        Cluster.unit()
      );
    }).errate(e -> (e:ConfigFailure))
      .map(
        cluster -> Ensemble.fromClusterCouple(cluster)
      );
  }
  public function prj(){
    return this;
  }
  static public function unit(){
    return new Directory();
  }
}