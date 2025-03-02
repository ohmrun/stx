package stx.nano;
  
/**
  abstract of `Pos`, the parser will not inject this type if you use it so: `?pos:Position`, use `Pos` and then lift it in the function.
**/
@:using(stx.nano.Position.PositionLift)
@:forward abstract Position(Pos) from Pos to Pos{
  static public var ZERO(default,never) : Pos = make(null,null,null,null);

  
  public function new(self:Pos) this = self;
  static public inline function lift(pos:Pos):Position return fromPos(pos);
  

  @:noUsing static public function make(fileName:String,className:String,methodName:String,lineNumber:Null<Int>,?customParams:Array<Dynamic>):Pos{ 
    return
      #if macro
        (null:haxe.macro.Expr.Position);
      #else
        {
          fileName   : fileName,
          className  : className,
          methodName : methodName,
          lineNumber : lineNumber,
          customParams : customParams
        };
      #end
  }
  
  @:from static public function fromPos(pos:Pos):Position{
    return new Position(pos);
  }
  #if (!macro)
    public function toString():String{
      return PositionLift.toStringClassMethodLine(this);
    }
  #else
    public function toString() {
      return Std.string(this);
    }
  #end

  static public function here(?pos:Pos) {
    return pos;
  } 
  public var customParams(get,never) : Array<Dynamic>;
  public function get_customParams(){
    return #if macro [] #else this.customParams #end;
  }
  public function toIdent():Ident{
    return Ident.fromIdentifier(Identifier.lift(Position.lift(this).className));
  }
  public var className(get,never):String;
  private function get_className():String{
    return #if macro 'unknown' #else this.className #end;
  }
  public var fileName(get,never):String;
  private function get_fileName():String{
    return #if macro 'unknown' #else this.fileName #end;
  }
  public var lineNumber(get,never):Int;
  private function get_lineNumber():Int{
    return #if macro -1 #else this.lineNumber #end;
  }
  public var methodName(get,never):String;
  private function get_methodName():String{
    return #if macro 'unknown' #else this.methodName #end;
  }
  public function toPos():Pos{
    return this;
  }
}
class PositionLift {
  static public function copy(p:Pos){
    return 
      #if !macro 
        Position.make(p.fileName,p.className,p.methodName,p.lineNumber,p.customParams);
      #else
        p;
      #end
  }
  static public function withFragmentName(pos:Pos):String{
    #if !macro
      var f   = pos.fileName;
      var cls = pos.className;
      var fn  = pos.methodName;
      var ln  = pos.lineNumber;

      return '${cls}.${fn}';
    #else
      return '<unknown>';
    #end
  }
  static public function toStringClassMethodLine(pos:Pos){
    #if !macro
      var f   = pos.fileName;
      var cls = pos.className;
      var fn  = pos.methodName;
      var ln  = pos.lineNumber;

      var class_method = withFragmentName(pos);
      return '($class_method@${pos.lineNumber})';
    #else
      return '<unknown>';
    #end
  }
  static public function to_vscode_clickable_link(pos:Pos){
    #if !macro
      var f   = pos.fileName;
      var cls = pos.className;
      var fn  = pos.methodName;
      var ln  = pos.lineNumber;

      var class_method = withFragmentName(pos);
      return '$f:$ln';
    #else
      return '<unknown>';
    #end
  }
  static public function toString_name_method_line(pos:Pos){
    #if !macro
      var name    = Identifier.lift(Position.lift(pos).className).name;
      var method  = pos.methodName;
      var line     = pos.lineNumber;
      return '$name.$method@$line';
    #else
      return '<unknown>';
    #end
  }
  static public function withCustomParams(p:Pos,v:Dynamic):Pos{
    p = copy(p);
    #if !macro
      if(p.customParams == null){
        p.customParams = [];
      };
      p.customParams.push(v);
    #end
    return p;
  }
  @:deprecated
  static public function identifier(self:Pos):Identifier{
    var valid   = Position.lift(self).fileName.split(".").get(0).split(Pico.sep()).join(".");
    return new Identifier(valid);
  }
  static public inline function toIdentfier(self:Pos):Identifier{
    var valid   = Position.lift(self).fileName.split(".").get(0).split(Pico.sep()).join(".");
    return new Identifier(valid);
  }
}