package stx.pico;

/**
 * Encapulates position information from known macro position, unknown macro position, known runtime position and character only position
 */
typedef LocDef = {
  @:optional public final cursor  : Int;
  @:optional public final opaque  : haxe.macro.Expr.Position;
  @:optional public final known   : haxe.PosInfos;
}
class LocCtr{
  static public var instance(get,null) : LocCtr;
  static private function get_instance(){
    return instance == null ? instance = new LocCtr() : instance;
  }
  public function new(){}
  public function Make(?cursor,?opaque,?known){
    return Loc.make(cursor,opaque,known);
  }  
  public function Unit(?known){
    return Loc.unit(known);
  }
  public function Cursor(int){
    return Loc.make(int);
  }
  public function Known(?pos:haxe.PosInfos){
    return Loc.make(null,null,pos);
  }
  public function Available(?pos:Pos){
    return Loc.fromNullPos(pos);
  }
  public function Indexed(int,?pos:Pos){
    return PosLift.toLoc(pos,int);
  } 
}
@:forward abstract Loc(LocDef) from LocDef to LocDef{
  public static var ZERO(get,null) : Loc;
  static function get_ZERO():Loc{
    return ZERO == null ? ZERO = {}  : ZERO;
  }

  public function new(self) this = self;
  @:noUsing static public function lift(self:LocDef):Loc return new Loc(self);

  @:noUsing static public function make(?cursor,?opaque,?known:haxe.PosInfos) : Loc{
    return lift(switch([cursor,opaque,known]){
      case [null,null,null] : {};
      case [null,null,x]    : { known : known };
      case [null,x,null]    : { opaque : opaque };
      case [x,null,null]    : { cursor : cursor };
      case [x,y,z]          : { cursor : cursor, opaque : opaque, known : known };
    });
  }
  static public function makeI(?opaque:haxe.macro.Expr.Position,?known:Pos){
    return 
    #if (macro || eval || display ) 
      make(null,
        opaque ?? haxe.macro.Context.currentPos()
      ); 
    #else 
      make(null,null,known); 
    #end
  }
  static public function unit(?available:Pos){
    return #if (macro || eval || display ) makeI(null,available); #else make(null,available); #end
  }
  public function prj():LocDef return this;
  private var self(get,never):Loc;
  private function get_self():Loc return lift(this);

  @:from static public function fromPosInfos(?self:haxe.PosInfos):Loc{
    return Loc.make(null,null,self);
  }
  @:from static public function fromPos(?self:Pos):Loc{
    return #if macro Loc.make(null,self,null); #else Loc.make(null,null,self); #end
  }
  @:from static public function fromNullPos(?self:Null<Pos>):Loc{
    return #if macro Loc.make(null,self,null); #else Loc.make(null,null,self); #end
  }
  public function toString(){
    var result = "<unknown>";
      #if (macro || display ) 
      #else
        final known = this.known == null ? "?" : PosLift.toString(this.known);  
        final cursor = this.cursor == null ? "" : '[${this.cursor}]';
        result = '${known}';
        if(this.cursor!=null){
          result += ' $cursor';
        }
      #end
    return result;
  }
  public function is_ZERO(){
    return this == ZERO;
  }
  public function get_pos():Pos{
    return #if macro this.opaque; #else this.known; #end 
  }
  public function with_cursor(cursor:Int){
    return make(cursor,this.opaque,this.known);
  }
  // public function toString(){
  //   return switch([this.opaque,this.known]){
  //     case [null,null] : '@${this.cursor}';
  //     case [x,null]    : PosLift.toString(x);
  //     case [null,x]    : PosLift.toString(x);
  //   }
  // }
}