package stx;

import haxe.PosInfos;

using stx.Nano;

typedef Pkg         = stx.pkg.Pkg;
typedef Packed<T>   = stx.pkg.Packed<T>;
typedef Scope       = stx.pkg.Scope;

class PkgLift{
  #if (!macro)
  static public function pkg(_:Wildcard,?pos:PosInfos):Pkg{
    var p           : Scope   = pos;
    return Pkg.fromScope(p);
  }
  #else
  static public function pkg(_:Wildcard,?pos:Position):Pkg{
    var p           : Scope   = Scope.fromPosition(pos);
    return Pkg.fromScope(p);
  }
  #end
}
