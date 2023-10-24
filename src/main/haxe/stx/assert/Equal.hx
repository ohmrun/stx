package stx.assert;

import stx.assert.eq.term.*;
import stx.assert.eq.term.Null;
import stx.assert.eq.term.Int;
import stx.assert.eq.term.Map;
import stx.assert.eq.term.Float;
import stx.assert.eq.term.Enum;
import stx.assert.eq.term.Bool;
import stx.assert.eq.term.Unknown;

class Equal{
  static public function getEqualFor<T>(v:T):Eq<T>{
    return getEqualForType(std.Type.typeof(v));
  }
  static public function getEqualForType<T>(v: ValueType):Eq<T>{
    return new NotNull(switch (v){
      case TNull                                                        :   new Null();
      case TInt                                                         :   new Int();
      case TFloat                                                       :   new Float();
      case TBool                                                        :   new Bool();
      case TFunction                                                    :   new Function();
      case TClass( c ) if ( c == StringMap  )                           :   new Map(new Deferred());
      case TClass( c ) if ( c == Array  )                               :   new Array(new Deferred());
      case TClass( c ) if ( c == Date   )                               :   new Date();
      case TClass( c ) if ( c == String )                               :   new String();
      case TEnum(_)                                                     :   new Enum();
      case TClass( c )                                                  :
        if(std.Type.getInstanceFields(c).remove("equals")){
          new HasFunction().elide();
        }else{
          new UnsupportedClass();
        }
      case TObject      : new Object();
      case TUnknown     : new Unknown();
    });
  }
}