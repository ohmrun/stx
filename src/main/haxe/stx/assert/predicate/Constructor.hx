package stx.assert.predicate;

import stx.assert.predicate.term.*;

class Constructor extends Clazz{
  static public var ZERO(default,never) = new Constructor();
         public var _(default,never)    = new Destructure();

  
}