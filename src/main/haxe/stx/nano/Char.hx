package stx.nano;

import stx.alias.StdString;


abstract Char(StdString){
  public function new(self) this = self;

  public function code():Int{
    return this.charCodeAt(0);
  }
}
