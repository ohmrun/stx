package stx.nano;

abstract FPath(Chars){
  @:noUsing static public function lift(self:Chars) return new FPath(self);
  public function new(self) this = self;
  @:noUsing static public function unit():FPath{
    return lift("/"); 
  }
  @:noUsing static public function pure(str:Chars):FPath{
    return new FPath(str);
  }
  public function into(str:String):FPath{
    return new FPath(
      if(has_end_slash()){
        '$this$str';
      }else{
        '$this/$str';
      } 
    );
  }
  public function trim_end_slash(){
    return if(has_end_slash()){
      lift(this.rdropn(1));
    }else{
      lift(this);
    }
  }
  public function has_end_slash(){
    return StringTools.endsWith(this,'/');   
  }
  public function is_absolute(){
    return StringTools.startsWith(this,'/');
  }
  @:noUsing static public function fromString(str:String):FPath{
    return lift(str);
  }
  public function toString(){
    return this;
  }
  public function toArray(){
    var splut = this.split('/');
    if(is_absolute()){
      splut.shift();
    }
    if(has_end_slash()){
      splut.pop();
    }
    return splut;
  }
  public function head(){
    return toArray().head();
  }
  public function prj(){
    return this;
  }
}