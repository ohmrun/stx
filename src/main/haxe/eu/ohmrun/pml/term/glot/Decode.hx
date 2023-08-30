package eu.ohmrun.pml.term.glot;

import eu.ohmrun.pml.PExpr in TPExpr;

import eu.ohmrun.pml.term.glot.decode.PExpr;
import eu.ohmrun.pml.term.glot.decode.EnumValue;
import eu.ohmrun.pml.term.glot.decode.Object;

class Decode extends Clazz{
  public function apply(self:TPExpr<Atom>){
    return PExpr.apply(self);
  }
  @:isVar public var PExpr(get,null):PExpr;
  private function get_PExpr():PExpr{
    return __.option(this.PExpr).def(() -> this.PExpr = new PExpr());
  }
  @:isVar public var EnumValue(get,null):EnumValue;
  private function get_EnumValue():EnumValue{
    return __.option(this.EnumValue).def(() -> this.EnumValue = new EnumValue());
  }
  @:isVar public var Object(get,null):Object;
  private function get_Object():Object{
    return __.option(this.Object).def(() -> this.Object = new Object());
  }
}