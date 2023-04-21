package stx.g.lang.expr;

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

  //GOpNullCoal;//`??`
 }
 @:using(stx.g.lang.expr.GBinop.GBinopLift)
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
      //case GOpNullCoal        : OpNullCoal;
    }
  } 
  // static public function spell(self:GBinop){
  //   final e = __.g().expr();
  //   switch(self){
  //     case GOpAdd             : e.Path('stx.g.lang.expr.GBinop.GBinopSum.GOpAdd');
  //     case GOpMult            : e.Path('stx.g.lang.expr.GBinop.GBinopSum.GOpMult');
  //     case GOpDiv             : e.Path('stx.g.lang.expr.GBinop.GBinopSum.GOpDiv');
  //     case GOpSub             : e.Path('stx.g.lang.expr.GBinop.GBinopSum.GOpSub');
  //     case GOpAssign          : e.Path('stx.g.lang.expr.GBinop.GBinopSum.GOpAssign');
  //     case GOpEq              : e.Path('stx.g.lang.expr.GBinop.GBinopSum.GOpEq');
  //     case GOpNotEq           : e.Path('stx.g.lang.expr.GBinop.GBinopSum.GOpNotEq');
  //     case GOpGt              : e.Path('stx.g.lang.expr.GBinop.GBinopSum.GOpGt');
  //     case GOpGte             : e.Path('stx.g.lang.expr.GBinop.GBinopSum.GOpGte');
  //     case GOpLt              : e.Path('stx.g.lang.expr.GBinop.GBinopSum.GOpLt');
  //     case GOpLte             : e.Path('stx.g.lang.expr.GBinop.GBinopSum.GOpLte');
  //     case GOpAnd             : e.Path('stx.g.lang.expr.GBinop.GBinopSum.GOpAnd');
  //     case GOpOr              : e.Path('stx.g.lang.expr.GBinop.GBinopSum.GOpOr');
  //     case GOpXor             : e.Path('stx.g.lang.expr.GBinop.GBinopSum.GOpXor');
  //     case GOpBoolAnd         : e.Path('stx.g.lang.expr.GBinop.GBinopSum.GOpBoolAnd');
  //     case GOpBoolOr          : e.Path('stx.g.lang.expr.GBinop.GBinopSum.GOpBoolOr');
  //     case GOpShl             : e.Path('stx.g.lang.expr.GBinop.GBinopSum.GOpShl');
  //     case GOpShr             : e.Path('stx.g.lang.expr.GBinop.GBinopSum.GOpShr');
  //     case GOpUShr            : e.Path('stx.g.lang.expr.GBinop.GBinopSum.GOpUShr');
  //     case GOpMod             : e.Path('stx.g.lang.expr.GBinop.GBinopSum.GOpMod');
  //     case GOpAssignOp(op)    : 
  //       e.Call(
  //         e.Path('stx.g.lang.expr.GBinop.GBinopSum.GOpAssignOp'),
  //       );
  //     case GOpInterval        : e.Path('stx.g.lang.expr.GBinop.GBinopSum.GOpInterval');
  //     case GOpArrow           : e.Path('stx.g.lang.expr.GBinop.GBinopSum.GOpArrow');
  //     case GOpIn              : e.Path('stx.g.lang.expr.GBinop.GBinopSum.GOpIn');
  //     case GOpNullCoal        : e.Path('stx.g.lang.expr.GBinop.GBinopSum.GOpNullCoal');
  //   }
  // }
}