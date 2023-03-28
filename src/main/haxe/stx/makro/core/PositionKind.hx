package stx.makro.core;

enum PositionKindSum{
  POS_NONE;
  POS_MACRO;
  POS_RUNTIME;
}
abstract PositionKind(PositionKindSum) from PositionKindSum to PositionKindSum{
  public function new(){
    this = 
      #if macro
        __.option(__.here()).fold(
          ok -> POS_MACRO,
          () -> POS_NONE
        )
      #else
        POS_RUNTIME
      #end
    ;
  }
  static public function unit(){
    return new PositionKind();
  }
  public function prj():PositionKindSum return this;
}