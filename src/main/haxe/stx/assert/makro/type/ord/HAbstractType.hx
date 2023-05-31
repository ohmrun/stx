package stx.assert.makro.type.ord;

import stx.makro.type.HAbstractType as THAbstractType;
import haxe.macro.Type.ClassField as TClassField;
import stx.makro.type.HClassField as THClassField;
import stx.makro.type.HType as THType;

final Ord = __.assert().Ord();

class HAbstractType extends OrdCls<THAbstractType>{

  public function new(){}

  public function comply(a:THAbstractType,b:THAbstractType):Ordered{
    var ord = Ord.Makro().Type().Type.comply(a.type,b.type);
    if(ord.is_not_less_than()){
      ord = Ord.NullOr(Ord.Makro().Type().HRef(Ord.Makro().Type().HClassType)).comply(a.impl,b.impl);
    }
    if(ord.is_not_less_than()){
      ord = Ord.Array(Ord.Anon(binop_op)).comply(a.binops,b.binops);
    }
    if(ord.is_not_less_than()){
      ord = Ord.Array(Ord.Anon(unop_op)).comply(a.unops,b.unops);
    }
    if(ord.is_not_less_than()){
      ord = Ord.Array(Ord.Anon(from_and_to_op)).comply(a.from,b.from);
    }
    if(ord.is_not_less_than()){
      ord = Ord.Array(Ord.Anon(from_and_to_op)).comply(a.to,b.to);
    }
    if(ord.is_not_less_than()){
      ord = Ord.Array(Ord.Makro().Type().HClassField).comply(a.array,b.array);
    }
    if(ord.is_not_less_than()){
      ord = Ord.NullOr(Ord.Makro().Type().HClassField).comply(a.resolve,b.resolve);
    }
    if(ord.is_not_less_than()){
      ord = Ord.NullOr(Ord.Makro().Type().HClassField).comply(a.resolveWrite,b.resolveWrite);
    }
    return ord;
  }
  private function binop_op(a:{op:haxe.macro.Expr.Binop, field:TClassField},b:{op:haxe.macro.Expr.Binop, field:TClassField}){
    var ord = Ord.Makro().Expr().Binop.comply(a.op,b.op);
    if(ord.is_not_less_than()){
      ord = Ord.Makro().Type().HClassField.comply(a.field,b.field);
    }
    return ord;
  }
  private function unop_op(a:{op:haxe.macro.Unop, postFix:Bool, field:TClassField},b:{op:haxe.macro.Expr.Unop, postFix:Bool, field:TClassField}){
    var ord = Ord.Makro().Expr().Unop.comply(a.op,b.op);
    if(ord.is_not_less_than()){
      ord = Ord.Bool().comply(a.postFix,b.postFix);
    }
    if(ord.is_not_less_than()){
      ord = Ord.Makro().Type().HClassField.comply(a.field,b.field);
    }
    return ord;
  }
  private function from_and_to_op(a:{t:THType,field:Null<TClassField>},b:{t:THType,field:Null<TClassField>}){
    var ord = Ord.Makro().Type().HType.comply(a.t,b.t);
    if(ord.is_not_less_than()){
      ord = Ord.NullOr(Ord.Makro().Type().ClassField).comply(a.field,b.field);
    }
    return ord;
  }
}