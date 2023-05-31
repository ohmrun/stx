package eu.ohmrun.glot.expr;

class GConstantCtr extends Clazz{
  public function Int(v:String,?s:String){
    return GConstant.lift(GCInt(v,s));
  }
  public function Float(v:String,?s:String){
    return GConstant.lift(GCFloat(v,s));
  }
  public function String(v:String,?s:GStringLiteralKind){
    return GConstant.lift(GCString(v,s));
  }
  public function Ident(v:String){
    return GConstant.lift(GCIdent(v));
  }
  public function Regexp(v:String,opt:String){
    return GConstant.lift(GCRegexp(v,opt));
  }
}
enum GConstantSum{
  GCInt(v:String, ?s:String);
	GCFloat(f:String, ?s:String);
	GCString(s:String, ?kind:GStringLiteralKind);
	GCIdent(s:String);
	GCRegexp(r:String, opt:String);
}
@:using(eu.ohmrun.glot.expr.GConstant.GConstantLift)
abstract GConstant(GConstantSum) from GConstantSum to GConstantSum{
    public function new(self) this = self;
  @:noUsing static public function lift(self:GConstantSum):GConstant return new GConstant(self);

  public function prj():GConstantSum return this;
  private var self(get,never):GConstant;
  private function get_self():GConstant return GConstant.lift(this);


  public function toSource():GSource{
		return Printer.ZERO.printConstant(this);
	}
  public function toGExpr(){
    return Wildcard.__.glot().Expr.GExpr.Constant(this);
  }
  public function canonical():String{
    return switch(this){
      case GCInt(v,_)       : v;
	    case GCFloat(f,_)     : f;
	    case GCString(s,_)    : s;
	    case GCIdent(s)       : s;
	    case GCRegexp(r, opt) : '~/$r/$opt';
    }
  }
}
class GConstantLift{
  #if macro

  static public function to_macro_at(self:GConstant,pos:Position){
    return switch(self){
      #if (haxe_ver > 4.205) 
      case GCInt(v, s)        : CInt(v, s);       
      case GCFloat(f, s)      : CFloat(f, s);     
      #else
      case GCInt(v)           : CInt(v);
      case GCFloat(f)         : CFloat(f);     
      #end       
      case GCString(s, kind) : CString(s, __.option(kind).map(x -> x.to_macro_at(pos)).defv(null)); 
      case GCIdent(s)        : CIdent(s);        
      case GCRegexp(r, opt)  : CRegexp(r, opt);  
    }
  }
  #end
  static public function toGComplexType(self:GConstant){
    final c = __.glot().Expr.GComplexType;
    return switch(self){
      case GCInt(v, s)       : c.string('std.Int');       
      case GCFloat(f, s)     : c.string('std.Float');
      case GCString(s, kind) : c.string('std.String');
      case GCIdent(s)        : switch(s){
        case 'true' | 'false' : c.string('std.Bool');
        case 'null'           : c.string('Dynamic');
        case x                : throw E_G_NoTypeForIdent(x);
      }        
      case GCRegexp(r, opt)  : c.string('std.EReg');
    }
  }
  // static public function spell(self:GConstant){
  //   final e = __.glot().expr();
  //   return switch(self){
  //     case GCInt(v, s)       : e.Call(
  //       e.Path('eu.ohmrun.glot.expr.GConstant.GConstantSum.GCInt'),[
  //         e.Const(c -> c.String(v)),
  //         __.option(s).fold(
  //           ok -> e.Const(c -> c.String(ok)),
  //           () -> e.Const(c -> c.Ident('null'))
  //         )
  //       ]
  //     )
  //     case GCFloat(f, s)     : 
  //       e.Call(
  //         e.Path('eu.ohmrun.glot.expr.GConstant.GConstantSum.GCFloat'),[
  //           e.Const(c -> c.String(v)),
  //           __.option(s).fold(
  //             ok -> e.Const(c -> c.String(ok)),
  //             () -> e.Const(c -> c.Ident('null'))
  //           )]
  //       );
  //     case GCString(s, kind) : 
  //       e.Call(
  //         e.Path('eu.ohmrun.glot.expr.GConstant.GConstantSum.GCString'),
  //         [e.Const(c -> c.String(s)),kind.spell()]
  //       );
  //     case GCIdent(s)        : 
  //       e.Call(
  //         e.Path('eu.ohmrun.glot.expr.GConstant.GConstantSum.GCIdent'),
  //         [e.Const(c -> c.String(s))]
  //       );
  //     case GCRegexp(r, opt)  : 
  //       e.Path('eu.ohmrun.glot.expr.GConstant.GConstantSum.GCRegexp'),
  //       [
  //         e.Const(c -> c.String(v)),
  //         e.Const(c -> c.String(opt))
  //       ]
  //   }
  // }   
}