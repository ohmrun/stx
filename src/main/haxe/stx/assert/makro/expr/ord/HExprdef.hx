package stx.assert.makro.expr.ord;

import stx.makro.expr.HExprdef as THExprdef;
import stx.makro.expr.HExpr as THExpr;
import haxe.macro.Expr as TExpr;
import haxe.macro.Expr.ExprDef as TExprDef;

final Ord = __.assert().Ord();

class HExprdef extends OrdCls<THExprdef>{
  public function new(){}
  public function comply(lhs:THExprdef,rhs:THExprdef):Ordered{
    return switch([lhs.prj(),rhs.prj()]){
      case [TExprDef.EConst(cI),TExprDef.EConst(cII)] :
        Ord.Makro().Expr().HConstant.comply(cI,cII);
      case [TExprDef.EArray(e1I,e2I),TExprDef.EArray(e1II,e2II)] :
        var ord = Ord.Makro().Expr().Expr.comply(e1I,e1II);
        if(ord.is_not_less_than()){
          ord = Ord.Makro().Expr().Expr.comply(e2I,e2II);
        }
        ord;
      case [TExprDef.EBinop(opI,e1I,e2I),TExprDef.EBinop(opII,e1II,e2II)] :
        var ord : Ordered = new stx.assert.makro.expr.ord.Binop().comply(opI,opII);
        if(ord.is_not_less_than()){
          ord = Ord.Makro().Expr().Expr.comply(e1I,e1II);
        }
        if(ord.is_not_less_than()){
          ord = Ord.Makro().Expr().Expr.comply(e2I,e2II);
        }
        ord;
      #if (haxe_ver > 4.205)
      case [TExprDef.EField(eI,fieldI,kindI),TExprDef.EField(eII,fieldII,kindII)] :
        var ord = Ord.Makro().Expr().Expr.comply(eI,eII);
        if(ord.is_not_less_than()){
          ord = Ord.String().comply(fieldI,fieldII);
        }
        if(ord.is_not_less_than()){
          ord = Ord.NullOr(new stx.assert.makro.expr.ord.EFieldKind()).comply(kindI,kindII);
        }
        ord;
      #else
      case [TExprDef.EField(eI,fieldI),TExprDef.EField(eII,fieldII)] :
        var ord = Ord.Makro().Expr().Expr.comply(eI,eII);
        if(ord.is_not_less_than()){
          ord = Ord.String().comply(fieldI,fieldII);
        }
        ord;
      #end
      case [TExprDef.EParenthesis(eI),TExprDef.EParenthesis(eII)] :
        Ord.Makro().Expr().Expr.comply(eI,eII);
      case [TExprDef.EObjectDecl(fieldsI),TExprDef.EObjectDecl(fieldsII)] :
        Ord.Array(Ord.Makro().Expr().HObjectField).comply(fieldsI,fieldsII);
      case [TExprDef.EArrayDecl(valuesI),TExprDef.EArrayDecl(valuesII)] :
        Ord.Array(Ord.Makro().Expr().Expr).comply(valuesI,valuesII);
      case [TExprDef.ECall(eI,paramsI),TExprDef.ECall(eII,paramsII)] :
        var ord = Ord.Makro().Expr().Expr.comply(eI,eII);
        if(ord.is_not_less_than()){
          ord = Ord.Array(Ord.Makro().Expr().Expr).comply(paramsI,paramsII);
        }
        ord;
      case [TExprDef.ENew(tI,paramsI),TExprDef.ENew(tII,paramsII)] :
        var ord = Ord.Makro().Expr().HTypePath.comply(tI,tII);
        if(ord.is_not_less_than()){
          ord = Ord.Array(Ord.Makro().Expr().Expr).comply(paramsI,paramsII);
        }
        ord;
      case [TExprDef.EUnop(opI,postFixI,eI),TExprDef.EUnop(opII,postFixII,eII)] :
        var ord = new stx.assert.makro.expr.ord.Unop().comply(opI,opII);
        if(ord.is_not_less_than()){
          ord = Ord.Bool().comply(postFixI,postFixII);
        }
        if(ord.is_not_less_than()){
          ord = Ord.Makro().Expr().Expr.comply(eI,eII);
        }
        ord;
      case [TExprDef.EVars(varsI),TExprDef.EVars(varsII)] :
        Ord.Array(Ord.Makro().Expr().HVar).comply(varsI,varsII);
      case [EFunction(kindI,fI),EFunction(kindII,fII)] :
        var ord = Ord.NullOr(Ord.Makro().Expr().HFunctionKind).comply(kindI,kindII);
        if(ord.is_not_less_than()){
          ord = Ord.Makro().Expr().HFunction.comply(fI,fII);
        }
        ord;
      case [TExprDef.EBlock(exprsI),TExprDef.EBlock(exprsII)] :
        Ord.Array(Ord.Makro().Expr().Expr).comply(exprsI,exprsII);
      case [EFor(iI,eexprI),EFor(iII,eexprII)] :
        var ord = Ord.Makro().Expr().Expr.comply(iI,iII);
        if(ord.is_not_less_than()){
          ord = Ord.Makro().Expr().Expr.comply(eexprI,eexprII);
        }
        ord;
      case [TExprDef.EIf(econdI,eifI,eelseI),TExprDef.EIf(econdII,eifII,eelseII)] :
        var ord = Ord.Makro().Expr().Expr.comply(econdI,econdII);
        if(ord.is_not_less_than()){
          ord = Ord.Makro().Expr().Expr.comply(eifI,eifII);
        }
        if(ord.is_not_less_than()){
          ord = Ord.NullOr(Ord.Makro().Expr().Expr).comply(eelseI,eelseII);
        }
        ord;
      case [TExprDef.EWhile(econdI,eI,normalWhileI),TExprDef.EWhile(econdII,eII,normalWhileII)] :
        var ord = Ord.Makro().Expr().Expr.comply(econdI,econdII);
        if(ord.is_not_less_than()){
          ord = Ord.Makro().Expr().Expr.comply(eI,eII);
        }
        if(ord.is_not_less_than()){
          ord = Ord.Bool().comply(normalWhileI,normalWhileII);
        }
        ord;
      case [TExprDef.ESwitch(eI,casesI,edefI),TExprDef.ESwitch(eII,casesII,edefII) ] :
        var ord = Ord.Makro().Expr().Expr.comply(eI,eII);
        if(ord.is_not_less_than()){
          ord = Ord.Array(Ord.Makro().Expr().HCase).comply(casesI,casesII);
        }
        if(ord.is_not_less_than()){
          ord = Ord.NullOr(Ord.Makro().Expr().Expr).comply(edefI,edefII);
        }
        ord;
      case [TExprDef.ETry(eI,catchesI),TExprDef.ETry(eII,catchesII)] :
        var ord = Ord.Makro().Expr().Expr.comply(eI,eII);
        if(ord.is_not_less_than()){
          ord = Ord.Array(Ord.Makro().Expr().HCatch).comply(catchesI,catchesII);
        }
        ord;
      case [TExprDef.EReturn(eI),TExprDef.EReturn(eII)] :
        Ord.Makro().Expr().Expr.comply(eI,eII);
      case [TExprDef.EBreak,TExprDef.EBreak] :
        NotLessThan;
      case [TExprDef.EContinue,TExprDef.EContinue] :
        NotLessThan;
      case [TExprDef.EUntyped(eI),TExprDef.EUntyped(eII)] :
        Ord.Makro().Expr().Expr.comply(eI,eII);
      case [TExprDef.EThrow(eI),TExprDef.EThrow(eII)] :
        Ord.Makro().Expr().Expr.comply(eI,eII);
      case [TExprDef.ECast(eI,tI),TExprDef.ECast(eII,tII)] :
        var ord = Ord.Makro().Expr().Expr.comply(eI,eII);
        if(ord.is_not_less_than()){
          ord = Ord.NullOr(Ord.Makro().Expr().HComplexType).comply(tI,tII);
        }
        ord;
      case [TExprDef.ETernary(econdI,eifI,eelseI),TExprDef.ETernary(econdII,eifII,eelseII)] :
        var ord = Ord.Makro().Expr().Expr.comply(econdI,econdII);
        if(ord.is_not_less_than()){
          ord = Ord.Makro().Expr().Expr.comply(eifI,eifII);
        }
        if(ord.is_not_less_than()){
          ord = Ord.Makro().Expr().Expr.comply(eelseI,eelseII);
        }
        ord;
      case [TExprDef.ECheckType(eI,tI),TExprDef.ECheckType(eII,tII)] :
        var ord = Ord.Makro().Expr().Expr.comply(eI,eII);
        if(ord.is_not_less_than()){
          ord = Ord.NullOr(Ord.Makro().Expr().HComplexType).comply(tI,tII);
        }
        ord;
      case [TExprDef.EMeta(sI,eI),TExprDef.EMeta(sII,eII)] :
        var ord = Ord.Makro().Expr().HMetadataEntry.comply(sI,sII);
        if(ord.is_not_less_than()){
          ord = Ord.Makro().Expr().Expr.comply(eI,eII);
        }
        ord;
      case [TExprDef.EIs(eI,tI),TExprDef.EIs(eII,tII)] :
        var ord = Ord.Makro().Expr().Expr.comply(eI,eII);
        if(ord.is_not_less_than()){
          ord = Ord.NullOr(Ord.Makro().Expr().HComplexType).comply(tI,tII);
        }
        ord;
      default : Ord.EnumValueIndex().comply(lhs.prj(),rhs.prj());
    }
  }
}