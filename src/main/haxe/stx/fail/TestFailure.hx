package stx.fail;

using stx.Pico;
using stx.Nano;

enum TestFailureSum{
  E_Test_AutoRequiresIndecesDecl;
  E_Test_AutoMalformed(v:eu.ohmrun.pml.PExpr<eu.ohmrun.pml.Atom>);
  E_Test_AutoClassNotFound(name:String);
  E_Test_AutoFieldNotFound(name:String);
  E_Test_ClassNotInIndeces(name:String);
  E_Test_ReaderFailure(e:String,s:Dynamic);
  E_Test_NoIndeces;
  E_Test_BadSpec;
  E_Test_ParseFailure(f:stx.fail.ParseFailure);
  E_Test_Assertion(assertion:stx.test.core.Assertion);
  
  NullTestFailure;
  WhileAsserting(?description:String,failure:TestFailure);
  TestFailedBecause(str:String);
  TestTimedOut(after:Int);
  NoTestNamed(name:String);
  
  
  //E_Test_Dynamic(e:Dynamic);
  E_Test_Exception(e:haxe.Exception);
  E_Test_Error(err:Error<Dynamic>);
}
abstract TestFailure(TestFailureSum) from TestFailureSum to TestFailureSum{
  public function new(self) this = self;
  @:noUsing static public function lift(self:TestFailureSum):TestFailure return new TestFailure(self);

  public function prj():TestFailureSum return this;
  private var self(get,never):TestFailure;
  private function get_self():TestFailure return lift(this);

  public function toString():String{
    return switch(this){
      case E_Test_Exception(e)  : e.toString();
      case E_Test_Error(e)     : e.toString();
      default                   : Std.string(this);
    }
  }
  public var stack(get,never)  : Option<Array<haxe.CallStack>>;
  public function get_stack(){
    return switch(this){
      case E_Test_Exception(e)   : Some([e.stack]);
      case E_Test_Error(e)       : 
        (e.lapse:Iter<Lapse<Dynamic>>)
          .map_filter(l -> __.option(l.crack?.stack))
          .lfold((n,m:Array<haxe.CallStack>) -> m.snoc(n),[]);
      default                    : None;
    }
  }
  @:from static public function fromParseFailure(pf:ParseFailure){
    return lift(E_Test_ParseFailure(pf));
  }
}