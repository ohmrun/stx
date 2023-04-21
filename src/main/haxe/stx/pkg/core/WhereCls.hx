package stx.pkg.core;

class WhereCls implements WhereApi extends Clazz{
  public function where(?pos:Pos){
    return __.pkg(Position.fromPos(pos));
  }
}