package stx.assert.eq.term;

import haxe.ds.StringMap in TStringMap;

/**
 * `stx.assert.Eq` for `StringMap`.
 */
class StringMap<T> extends EqCls<TStringMap<T>>{
  final inner : Eq<T>;
  public function new(inner){
    this.inner = inner;
  }
  public function comply(lhs:TStringMap<T>,rhs:TStringMap<T>):Equaled{
    //trace('$lhs $rhs');
    final lhs_keys = lhs.keys();
    final rhs_keys = rhs.keys();

    final get_str_compare   = function(lstr:std.String,rstr:std.String):Either<Ordered,Equaled>{
      return if(lstr.length < rstr.length){
        Left(LessThan);
      }else if(lstr.length == rstr.length){
        stx.nano.Chars.CharsLift.toIter(lstr).zip(stx.nano.Chars.CharsLift.toIter(rstr)).lfold(
          function (next:Couple<std.String,std.String>,memo:Option<Either<Ordered,Equaled>>):Option<Either<Ordered,Equaled>>{
            //trace('$next');
            return switch(memo){
              case None | Some(Right(AreEqual)) : 
                next.decouple(
                  (l:std.String,r:std.String) -> {
                    final lcode = (l:Chars).cca(0);
                    final rcode = (r:Chars).cca(0);
                    return (lcode == rcode).if_else(
                      () -> Some(Right(AreEqual)),
                      () -> {
                        return lcode < rcode ? Some(Left(LessThan)) : None;
                      }
                    );
                  }
                );
              case Some(Left(LessThan))     : Some(Left(LessThan));
              case Some(Left(NotLessThan))  : Some(Left(NotLessThan));
              case Some(Right(NotEqual))    : Some(Right(NotEqual));
            }
          },
          None
        ).defv(Left(NotLessThan));
      }else{
        Left(NotLessThan);
      }
    }
    final set_add  = function(arr:StdArray<std.String>,str:std.String):StdArray<std.String>{
      final res = arr.length == 0 ? { value : [str], input : None } : arr.lfold(
        (next:std.String,memo:{value : StdArray<std.String>, input : stx.Option<std.String> }) -> {
          //trace('$next $memo');
          return switch(memo.input){
            case Some(str) : 
              final r = get_str_compare(str,next);
              //trace(r);
              switch (r){
                case Left(NotLessThan)  : { value : memo.value.snoc(next).snoc(str) , input : None };
                case Right(AreEqual)    : { value : memo.value.snoc(next)           , input : None};
                case Right(NotEqual)    : { value : memo.value.snoc(next)           , input : None};//TODO can I rule this out?
                case Left(LessThan)     : { value : memo.value.snoc(next)           , input : Some(str)};
              }
            case None : memo;
          }
        },
        { value : [], input : Some(str) }
      );
      //trace(res);
      return res.value; 
    }
    return if(lhs.size() == rhs.size()){
      var set   = [];
      for(x in lhs.keys()){
        set = set_add(set,x);
      }
      for(x in rhs.keys()){
        set = set_add(set,x);
      }
      var eq = true;
      // trace(set);
      for(x in set){
        // trace(x);
        final l = lhs.get(x);
        // trace(lhs);
        // trace(rhs);
        final r = rhs.get(x);
        // trace('$x $l $r');
        eq = l == r;
        if(!eq){
          break;
        }
      }
      eq ? AreEqual : NotEqual;
    }else{
      NotEqual;
    }
  }
}