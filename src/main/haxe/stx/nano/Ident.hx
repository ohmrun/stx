package stx.nano;

import stx.nano.Chars.CharsLift;

typedef IdentDef = {
  final name    : String;
  final ?pack   : Way; 
}

@:forward abstract Ident(IdentDef) from IdentDef to IdentDef{
  public function new(self) this = self;
  @:noUsing static public function lift(self:IdentDef):Ident return new Ident(self);
  @:noUsing static public function make(name:String,?pack:Way){
    return lift({
      name : name,
      pack : pack
    });
  }
  public function prj():IdentDef return this;
  private var self(get,never):Ident;
  private function get_self():Ident return lift(this);

  public function toWay():Way{
    return if(this.pack == null){
      Way.unit().snoc(this.name);
    }else{
      this.pack.snoc(this.name); 
    }
  }
  @:from static public function fromObject(self:{ name : String, pack : Array<String> }){
    return lift({
      name : self.name,
      pack : Way.fromArray(self.pack)
    });
  }
  static public function fromIdentifier(self:Identifier):stx.nano.Ident{
    var n = self.name;
    var p = self.pack;
    return {
      name : n,
      pack : stx.nano.Way.lift(p)
    }
  }
  public function toIdentifier(){
    return switch(this){
      case { name : n, pack : null }                          : Identifier.lift(n);
      case { name : n, pack : pack }    if (pack.length == 0) : Identifier.lift(n);
      case { name : n, pack : p    }                          : Identifier.lift(p.snoc(n).join("."));    
    }
  }
  public function toString_with_sep(sep:String){
    return switch(this){
      case { name : n, pack : null }                          : n;
      case { name : n, pack : pack }    if (pack.length == 0) : n;
      case { name : n, pack : p    }                          : Identifier.lift(p.snoc(n).join(sep));    
    }
  }
  public function canonical(){
    return toString_with_sep(".");
  }
  public function toString_underscored(){
    return toString_with_sep("_");
  }
  public function into():Way{
    final next_path = CharsLift.uncapitalize_first_letter(this.name);
    return this.pack.snoc(next_path);
  }
}