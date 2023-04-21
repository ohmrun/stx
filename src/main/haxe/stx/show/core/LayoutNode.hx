package stx.show.core;

enum LayoutNodeSum{
  LEscape(node:LayoutNode);
  //LTable;
  LTree;
  LArray(axis:Axis);
  LBlock;
}
@:using(stx.show.core.LayoutNode.LayoutNodeLift)
abstract LayoutNode(LayoutNodeSum) from LayoutNodeSum to LayoutNodeSum{
  static public var _(default,never) = LayoutNodeLift;
  public inline function new(self:LayoutNodeSum) this = self;
  @:noUsing static inline public function lift(self:LayoutNodeSum):LayoutNode return new LayoutNode(self);

  public function prj():LayoutNodeSum return this;
  private var self(get,never):LayoutNode;
  private function get_self():LayoutNode return lift(this);
}
class LayoutNodeLift{
  static public inline function lift(self:LayoutNodeSum):LayoutNode{
    return LayoutNode.lift(self);
  }
}