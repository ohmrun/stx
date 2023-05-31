package stx.assert.makro.type.eq;

import stx.makro.type.HAbstractType as THAbstractType;
import haxe.macro.Type.ClassField as TClassField;
import stx.makro.type.HClassField as THClassField;
import stx.makro.type.HType as THType;

final Eq = __.assert().Eq();

class HAbstractType extends EqCls<THAbstractType>{

  public function new(){}

  public function comply(a:THAbstractType,b:THAbstractType):Equaled{
    var eq = Eq.Makro().Type().Type.comply(a.type,b.type);
    if(eq.is_ok()){
      eq = Eq.NullOr(Eq.Makro().Type().HRef(Eq.Makro().Type().HClassType)).comply(a.impl,b.impl);
    }
    if(eq.is_ok()){
      eq = Eq.Array(Eq.Anon(binop_op)).comply(a.binops,b.binops);
    }
    if(eq.is_ok()){
      eq = Eq.Array(Eq.Anon(unop_op)).comply(a.unops,b.unops);
    }
    if(eq.is_ok()){
      eq = Eq.Array(Eq.Anon(from_and_to_op)).comply(a.from,b.from);
    }
    if(eq.is_ok()){
      eq = Eq.Array(Eq.Anon(from_and_to_op)).comply(a.to,b.to);
    }
    if(eq.is_ok()){
      eq = Eq.Array(Eq.Makro().Type().HClassField).comply(a.array,b.array);
    }
    if(eq.is_ok()){
      eq = Eq.NullOr(Eq.Makro().Type().HClassField).comply(a.resolve,b.resolve);
    }
    if(eq.is_ok()){
      eq = Eq.NullOr(Eq.Makro().Type().HClassField).comply(a.resolveWrite,b.resolveWrite);
    }
    return eq;
  }
  private function binop_op(a:{op:haxe.macro.Expr.Binop, field:TClassField},b:{op:haxe.macro.Expr.Binop, field:TClassField}){
    var eq = Eq.Makro().Expr().Binop.comply(a.op,b.op);
    if(eq.is_ok()){
      eq = Eq.Makro().Type().HClassField.comply(a.field,b.field);
    }
    return eq;
  }
  private function unop_op(a:{op:haxe.macro.Unop, postFix:Bool, field:TClassField},b:{op:haxe.macro.Expr.Unop, postFix:Bool, field:TClassField}){
    var eq = Eq.Makro().Expr().Unop.comply(a.op,b.op);
    if(eq.is_ok()){
      eq = Eq.Bool().comply(a.postFix,b.postFix);
    }
    if(eq.is_ok()){
      eq = Eq.Makro().Type().HClassField.comply(a.field,b.field);
    }
    return eq;
  }
  private function from_and_to_op(a:{t:THType,field:Null<TClassField>},b:{t:THType,field:Null<TClassField>}){
    var eq = Eq.Makro().Type().HType.comply(a.t,b.t);
    if(eq.is_ok()){
      eq = Eq.NullOr(Eq.Makro().Type().ClassField).comply(a.field,b.field);
    }
    return eq;
  }
}