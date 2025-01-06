package stx.test;

class Util{
  static public inline function or_res<U>(fn:Void->U,?pos:Pos):Upshot<U,TestFailure>{
    return try{
      __.accept(fn());
    }catch(e:Error<Dynamic>){
      __.log().debug('$e');
      __.reject(e.errata(E_Test_Error));
    }catch(e:haxe.Exception){
      __.log().debug('$e');
      __.reject(ErrorCtr.instance.Make(
          _ -> _.Value(E_Test_Exception(e),_ -> Loc.fromPos(pos)).enlist()
        )
      );
    }
    //return __.accept(fn());
  }
}