package stx.show.showable.term;

class Object extends ShowableCls<Dynamic>{
  public function show(self:Dynamic,state:State):Upshot<Response,ShowFailure>{
    final fields = 
      Reflect.fields(self).map(
        (field_name) -> KV.make(field_name,Reflect.field(self,field_name))
      );
    return throw UNIMPLEMENTED;
  }
  private function try_layout_horizontally(fields:Cluster<KV<StdString,Dynamic>>,state:State){
    final state = state.with_request(
      request -> request.with_node(_ -> LArray(H))
    );
    final responses = Upshot.bind_fold(
      fields,
      (next:KV<StdString,Dynamic>,memo:Couple<Cluster<Response>,State>) -> {
        final key_display = '${next.key}: ';
        final next_state  = state.with_request(
          req -> req.with_xindex(req.xindex + key_display.length)
        );
        return state.lookup(()->{}).show(next.val,memo.snd()).flat_map(
          (res:Response) -> {
            switch(res.node){
              case LEscape(_)       : __.reject(__.fault().of(E_Show_Escaped));
              default               : 
                final next_state = state.with_request(
                  _ -> Request.make(
                    res.state.request.xindex + res.width,
                    res.state.request.yindex,
                    res.state.request.node
                  )
                );
                __.accept(__.couple(memo.fst().snoc(res),next_state));
            }
          }
        );
      },
      __.couple([],state)
    );
  }
  //private function layout_vertically(fields:Cluster<K)
}