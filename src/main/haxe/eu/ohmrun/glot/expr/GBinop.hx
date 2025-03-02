package eu.ohmrun.glot.expr;

class GBinopCtr extends Clazz{
  static public var instance(get,null) : GBinopCtr;
  static private function get_instance(){
    return instance == null ? instance = new GBinopCtr() : instance;
  }
  public function Add(){ return GOpAdd;}
  public function Mult(){ return GOpMult;}
  public function Div(){ return GOpDiv;}
  public function Sub(){ return GOpSub;}
  public function Assign(){ return GOpAssign;}
  public function Eq(){ return GOpEq;}
  public function NotEq(){ return GOpNotEq;}
  public function Gt(){ return GOpGt;}
  public function Gte(){ return GOpGte;}
  public function Lt(){ return GOpLt;}
  public function Lte(){ return GOpLte;}
  public function And(){ return GOpAnd;}
  public function Or(){ return GOpOr;}
  public function Xor(){ return GOpXor;}
  public function BoolAnd(){ return GOpBoolAnd;}
  public function BoolOr(){ return GOpBoolOr;}
  public function Shl(){ return GOpShl;}
  public function Shr(){ return GOpShr;}
  public function UShr(){ return GOpUShr;}
  public function Mod(){ return GOpMod;}
  public function AssignOp(op:CTR<GBinopCtr,GBinop>){ return GOpAssignOp(op.apply(this));}
  public function Interval(){ return GOpInterval;}
  public function Arrow(){ return GOpArrow;}
  public function In(){ return GOpIn;}

  #if (haxe_ver > 4.205) 
  public function NullCoal(){ return GOpNullCoal;}
  #end
}
enum GBinopSum{
  GOpAdd;//`+`
  GOpMult;//`*`
  GOpDiv;//`/`
  GOpSub;//`-`
  GOpAssign;//`=`
  GOpEq;//`==`
  GOpNotEq;//`!=`
  GOpGt;//`>`
  GOpGte;//`>=`
  GOpLt;//`<`
  GOpLte;//`<=`
  GOpAnd;//`&`
  GOpOr;//`|`
  GOpXor;//`^`
  GOpBoolAnd;//`&&`
  GOpBoolOr;//`||`
  GOpShl;//`<<`
  GOpShr;//`>>`
  GOpUShr;//`>>>`
  GOpMod;//`%`
  GOpAssignOp(op:GBinop);//		`+=` `-=` `/=` `*=` `<<=` `>>=` `>>>=` `|=` `&=` `^=` `%=`
  GOpInterval;//`...`
  GOpArrow;//`=>`
  GOpIn;//`in`

  #if (haxe_ver > 4.205) 
  GOpNullCoal;//`??`
  #end
 }
 @:using(eu.ohmrun.glot.expr.GBinop.GBinopLift)
 abstract GBinop(GBinopSum) from GBinopSum to GBinopSum{
   public function new(self) this = self;
   @:noUsing static public function lift(self:GBinopSum):GBinop return new GBinop(self);
 

   public function prj():GBinopSum return this;
   private var self(get,never):GBinop;
   private function get_self():GBinop return lift(this);

   public function toSource():GSource{
		return Printer.ZERO.printBinop(this);
	}
 }
 class GBinopLift{
  #if macro
  static public function to_macro_at(self:GBinop,pos:Position):Binop{
    return switch(self){
      case GOpAdd             : OpAdd;
      case GOpMult            : OpMult;
      case GOpDiv             : OpDiv;
      case GOpSub             : OpSub;
      case GOpAssign          : OpAssign;
      case GOpEq              : OpEq;
      case GOpNotEq           : OpNotEq;
      case GOpGt              : OpGt;
      case GOpGte             : OpGte;
      case GOpLt              : OpLt;
      case GOpLte             : OpLte;
      case GOpAnd             : OpAnd;
      case GOpOr              : OpOr;
      case GOpXor             : OpXor;
      case GOpBoolAnd         : OpBoolAnd;
      case GOpBoolOr          : OpBoolOr;
      case GOpShl             : OpShl;
      case GOpShr             : OpShr;
      case GOpUShr            : OpUShr;
      case GOpMod             : OpMod;
      case GOpAssignOp(op)    : OpAssignOp(to_macro_at(op,pos));
      case GOpInterval        : OpInterval;
      case GOpArrow           : OpArrow;
      case GOpIn              : OpIn;
      #if (haxe_ver > 4.205)
      case GOpNullCoal        : OpNullCoal;
      #end
    }
  } 
  #end
  static public function canonical(self:GBinop){
    return switch(self){
      case GOpAdd             : '+';
      case GOpMult            : '*';
      case GOpDiv             : '/';
      case GOpSub             : '-';
      case GOpAssign          : '=';
      case GOpEq              : '==';
      case GOpNotEq           : '!=';
      case GOpGt              : '>';
      case GOpGte             : '>=';
      case GOpLt              : '<';
      case GOpLte             : '<=';
      case GOpAnd             : '&';
      case GOpOr              : '|';
      case GOpXor             : '^';
      case GOpBoolAnd         : '&&';
      case GOpBoolOr          : '||';
      case GOpShl             : '<<';
      case GOpShr             : '>>';
      case GOpUShr            : '>>>';
      case GOpMod             : '%';
      case GOpAssignOp(op)    : canonical(op) + "=";
      case GOpInterval        : '...';
      case GOpArrow           : '=>';
      case GOpIn              : 'in';
    
      #if (haxe_ver > 4.205) 
      case GOpNullCoal        : '??';
      #end
    }
  }
  // static public function spell(self:GBinop){
  //   final e = __.glot().expr();
  //   switch(self){
  //     case GOpAdd             : e.Path('eu.ohmrun.glot.expr.GBinop.GBinopSum.GOpAdd');
  //     case GOpMult            : e.Path('eu.ohmrun.glot.expr.GBinop.GBinopSum.GOpMult');
  //     case GOpDiv             : e.Path('eu.ohmrun.glot.expr.GBinop.GBinopSum.GOpDiv');
  //     case GOpSub             : e.Path('eu.ohmrun.glot.expr.GBinop.GBinopSum.GOpSub');
  //     case GOpAssign          : e.Path('eu.ohmrun.glot.expr.GBinop.GBinopSum.GOpAssign');
  //     case GOpEq              : e.Path('eu.ohmrun.glot.expr.GBinop.GBinopSum.GOpEq');
  //     case GOpNotEq           : e.Path('eu.ohmrun.glot.expr.GBinop.GBinopSum.GOpNotEq');
  //     case GOpGt              : e.Path('eu.ohmrun.glot.expr.GBinop.GBinopSum.GOpGt');
  //     case GOpGte             : e.Path('eu.ohmrun.glot.expr.GBinop.GBinopSum.GOpGte');
  //     case GOpLt              : e.Path('eu.ohmrun.glot.expr.GBinop.GBinopSum.GOpLt');
  //     case GOpLte             : e.Path('eu.ohmrun.glot.expr.GBinop.GBinopSum.GOpLte');
  //     case GOpAnd             : e.Path('eu.ohmrun.glot.expr.GBinop.GBinopSum.GOpAnd');
  //     case GOpOr              : e.Path('eu.ohmrun.glot.expr.GBinop.GBinopSum.GOpOr');
  //     case GOpXor             : e.Path('eu.ohmrun.glot.expr.GBinop.GBinopSum.GOpXor');
  //     case GOpBoolAnd         : e.Path('eu.ohmrun.glot.expr.GBinop.GBinopSum.GOpBoolAnd');
  //     case GOpBoolOr          : e.Path('eu.ohmrun.glot.expr.GBinop.GBinopSum.GOpBoolOr');
  //     case GOpShl             : e.Path('eu.ohmrun.glot.expr.GBinop.GBinopSum.GOpShl');
  //     case GOpShr             : e.Path('eu.ohmrun.glot.expr.GBinop.GBinopSum.GOpShr');
  //     case GOpUShr            : e.Path('eu.ohmrun.glot.expr.GBinop.GBinopSum.GOpUShr');
  //     case GOpMod             : e.Path('eu.ohmrun.glot.expr.GBinop.GBinopSum.GOpMod');
  //     case GOpAssignOp(op)    : 
  //       e.Call(
  //         e.Path('eu.ohmrun.glot.expr.GBinop.GBinopSum.GOpAssignOp'),
  //       );
  //     case GOpInterval        : e.Path('eu.ohmrun.glot.expr.GBinop.GBinopSum.GOpInterval');
  //     case GOpArrow           : e.Path('eu.ohmrun.glot.expr.GBinop.GBinopSum.GOpArrow');
  //     case GOpIn              : e.Path('eu.ohmrun.glot.expr.GBinop.GBinopSum.GOpIn');
  //     case GOpNullCoal        : e.Path('eu.ohmrun.glot.expr.GBinop.GBinopSum.GOpNullCoal');
  //   }
  // }
}