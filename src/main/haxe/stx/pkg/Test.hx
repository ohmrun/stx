package stx.pkg;


#if test
  import stx.pkg.test.*;
#end

class Test{
  #if (test=="pkg_test")
    static public function main(){
      stx.Test.test([new PkgTest()],[]);
    }
  #end
}
