package eu.ohmrun.pml.term.glot;

using eu.ohmrun.Glot;

import eu.ohmrun.pml.term.glot.encode.GExpr;
import eu.ohmrun.pml.term.glot.encode.EnumValue;
import eu.ohmrun.pml.term.glot.encode.Dyn;
import eu.ohmrun.pml.term.glot.encode.Object;

class Module extends Clazz{
   @:isVar public var encode(get,null):Encode;
   private function get_encode():Encode{
     return __.option(this.encode).def(() -> this.encode = new Encode());
   } 
   @:isVar public var decode(get,null):Decode;
   private function get_decode():Decode{
     return __.option(this.decode).def(() -> this.decode = new Decode());
   }
}
private class Encode extends Clazz{
  @:isVar public var GExpr(get,null):GExpr;
  private function get_GExpr():GExpr{
    return __.option(this.GExpr).def(() -> this.GExpr = new GExpr());
  }
  @:isVar public var EnumValue(get,null):EnumValue;
  private function get_EnumValue():EnumValue{
    return __.option(this.EnumValue).def(() -> this.EnumValue = new EnumValue());
  }
  @:isVar public var Dyn(get,null):Dyn;
  private function get_Dyn():Dyn{
    return __.option(this.Dyn).def(() -> this.Dyn = new Dyn());
  }
  @:isVar public var Object(get,null):Object;
  private function get_Object():Object{
    return __.option(this.Object).def(() -> this.Object = new Object());
  }
}