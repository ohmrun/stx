package stx.assert.makro.expr.eq;

import stx.makro.expr.HExprdef  as THExprdef;
import stx.makro.expr.HExpr     as THExpr;
import haxe.macro.Expr          as TExpr;
import haxe.macro.Expr.ExprDef  as TExprdef;

final Eq = __.assert().Eq();

class HExprdef extends stx.assert.eq.term.Base<THExprdef> {
  public function new(){
    super();
  }
  public function comply(lhs:THExprdef,rhs:THExprdef):Equaled{
    return switch([lhs.prj(),rhs.prj()]){
      case [TExprdef.EConst(cI),TExprdef.EConst(cII)] :
        Eq.Makro().Expr().HConstant.comply(cI,cII);
      case [TExprdef.EArray(e1I,e2I),TExprdef.EArray(e1II,e2II)] :
        var eq = Eq.Makro().Expr().Expr.comply(e1I,e1II);
        if(eq.is_ok()){
          eq = Eq.Makro().Expr().Expr.comply(e2I,e2II);
        }
        eq;
      case [TExprdef.EBinop(opI,e1I,e2I),TExprdef.EBinop(opII,e1II,e2II)] :
        var eq = Eq.Makro().Expr().Binop.comply(opI,opII);
        if(eq.is_ok()){
          eq = Eq.Makro().Expr().Expr.comply(e1I,e1II);
        }
        if(eq.is_ok()){
          eq = Eq.Makro().Expr().Expr.comply(e2I,e2II);
        }
        eq;
      #if (haxe_ver > 4.205)
      case [TExprdef.EField(eI,fieldI,kindI),TExprdef.EField(eII,fieldII,kindII)] :
        var eq = Eq.Makro().Expr().Expr.comply(eI,eII);
        if(eq.is_ok()){
          eq = Eq.String().comply(fieldI,fieldII);
        }
        if(eq.is_ok()){
          eq = Eq.NullOr(Eq.Makro().Expr().EFieldKind).comply(kindI,kindII);
        }
        eq;
      #else
      case [TExprdef.EField(eI,fieldI),TExprdef.EField(eII,fieldII)] :
        var eq = Eq.Makro().Expr().Expr.comply(eI,eII);
        if(eq.is_ok()){
          eq = Eq.String().comply(fieldI,fieldII);
        }
        eq;
      #end
      case [TExprdef.EParenthesis(eI),TExprdef.EParenthesis(eII)] :
        Eq.Makro().Expr().Expr.comply(eI,eII);
      case [TExprdef.EObjectDecl(fieldsI),TExprdef.EObjectDecl(fieldsII)] :
        final cons = () -> RedBlackSet.make(Comparable.Anon(Eq.Makro().Expr().HObjectField,new stx.assert.makro.expr.ord.HObjectField()));
        var lset = cons();
            lset = lset.concat(fieldsI);
        var rset = cons();     
            rset = rset.concat(fieldsII);
        lset.equals(rset);
      case [TExprdef.EArrayDecl(valuesI),TExprdef.EArrayDecl(valuesII)] :
        Eq.Array(Eq.Makro().Expr().Expr).comply(valuesI,valuesII);
      case [TExprdef.ECall(eI,paramsI),TExprdef.ECall(eII,paramsII)] :
        var eq = Eq.Makro().Expr().Expr.comply(eI,eII);
        if(eq.is_ok()){
          eq = Eq.Array(Eq.Makro().Expr().Expr).comply(paramsI,paramsII);
        }
        eq;
      case [TExprdef.ENew(tI,paramsI),TExprdef.ENew(tII,paramsII)] :
        var eq = Eq.Makro().Expr().HTypePath.comply(tI,tII);
        if(eq.is_ok()){
          eq = Eq.Array(Eq.Makro().Expr().Expr).comply(paramsI,paramsII);
        }
        eq;
      case [TExprdef.EUnop(opI,postFixI,eI),TExprdef.EUnop(opII,postFixII,eII)] :
        var eq = Eq.Makro().Expr().Unop.comply(opI,opII);
        if(eq.is_ok()){
          eq = Eq.Bool().comply(postFixI,postFixII);
        }
        if(eq.is_ok()){
          eq = Eq.Makro().Expr().Expr.comply(eI,eII);
        }
        eq;
      case [TExprdef.EVars(varsI),TExprdef.EVars(varsII)] :
        Eq.Array(Eq.Makro().Expr().HVar).comply(varsI,varsII);
      case [TExprdef.EFunction(kindI,fI),TExprdef.EFunction(kindII,fII)] :
        var eq = Eq.NullOr(Eq.Makro().Expr().HFunctionKind).comply(kindI,kindII);
        if(eq.is_ok()){
          eq = Eq.Makro().Expr().HFunction.comply(fI,fII);
        }
        eq;
      case [TExprdef.EBlock(exprsI),TExprdef.EBlock(exprsII)] :
        Eq.Array(Eq.Makro().Expr().Expr).comply(exprsI,exprsII);
      case [TExprdef.EFor(iI,eexprI),TExprdef.EFor(iII,eexprII)] :
        var eq = Eq.Makro().Expr().Expr.comply(iI,iII);
        if(eq.is_ok()){
          eq = Eq.Makro().Expr().Expr.comply(eexprI,eexprII);
        }
        eq;
      case [TExprdef.EIf(econdI,eifI,eelseI),TExprdef.EIf(econdII,eifII,eelseII)] :
        var eq = Eq.Makro().Expr().Expr.comply(econdI,econdII);
        if(eq.is_ok()){
          eq = Eq.Makro().Expr().Expr.comply(eifI,eifII);
        }
        if(eq.is_ok()){
          eq = Eq.NullOr(Eq.Makro().Expr().Expr).comply(eelseI,eelseII);
        }
        eq;
      case [TExprdef.EWhile(econdI,eI,normalWhileI),TExprdef.EWhile(econdII,eII,normalWhileII)] :
        var eq = Eq.Makro().Expr().Expr.comply(econdI,econdII);
        if(eq.is_ok()){
          eq = Eq.Makro().Expr().Expr.comply(eI,eII);
        }
        if(eq.is_ok()){
          eq = Eq.Bool().comply(normalWhileI,normalWhileII);
        }
        eq;
      case [TExprdef.ESwitch(eI,casesI,edefI),TExprdef.ESwitch(eII,casesII,edefII) ] :
        var eq = Eq.Makro().Expr().Expr.comply(eI,eII);
        if(eq.is_ok()){
          eq = Eq.Array(Eq.Makro().Expr().HCase).comply(casesI,casesII);
        }
        if(eq.is_ok()){
          eq = Eq.NullOr(Eq.Makro().Expr().Expr).comply(edefI,edefII);
        }
        eq;
      case [TExprdef.ETry(eI,catchesI),TExprdef.ETry(eII,catchesII)] :
        var eq = Eq.Makro().Expr().Expr.comply(eI,eII);
        if(eq.is_ok()){
          eq = Eq.Array(Eq.Makro().Expr().HCatch).comply(catchesI,catchesII);
        }
        eq;
      case [TExprdef.EReturn(eI),TExprdef.EReturn(eII)] :
        Eq.Makro().Expr().Expr.comply(eI,eII);
      case [TExprdef.EBreak,TExprdef.EBreak] :
        AreEqual;
      case [TExprdef.EContinue,TExprdef.EContinue] :
        AreEqual;
      case [TExprdef.EUntyped(eI),TExprdef.EUntyped(eII)] :
        Eq.Makro().Expr().Expr.comply(eI,eII);
      case [TExprdef.EThrow(eI),TExprdef.EThrow(eII)] :
        Eq.Makro().Expr().Expr.comply(eI,eII);
      case [TExprdef.ECast(eI,tI),TExprdef.ECast(eII,tII)] :
        var eq = Eq.Makro().Expr().Expr.comply(eI,eII);
        if(eq.is_ok()){
          eq = Eq.NullOr(Eq.Makro().Expr().HComplexType).comply(tI,tII);
        }
        eq;
      case [TExprdef.ETernary(econdI,eifI,eelseI),TExprdef.ETernary(econdII,eifII,eelseII)] :
        var eq = Eq.Makro().Expr().Expr.comply(econdI,econdII);
        if(eq.is_ok()){
          eq = Eq.Makro().Expr().Expr.comply(eifI,eifII);
        }
        if(eq.is_ok()){
          eq = Eq.Makro().Expr().Expr.comply(eelseI,eelseII);
        }
        eq;
      case [TExprdef.ECheckType(eI,tI),TExprdef.ECheckType(eII,tII)] :
        var eq = Eq.Makro().Expr().Expr.comply(eI,eII);
        if(eq.is_ok()){
          eq = Eq.NullOr(Eq.Makro().Expr().HComplexType).comply(tI,tII);
        }
        eq;
      case [TExprdef.EMeta(sI,eI),TExprdef.EMeta(sII,eII)] :
        var eq = Eq.Makro().Expr().HMetadataEntry.comply(sI,sII);
        if(eq.is_ok()){
          eq = Eq.Makro().Expr().Expr.comply(eI,eII);
        }
        eq;
      case [TExprdef.EIs(eI,tI),TExprdef.EIs(eII,tII)] :
        var eq = Eq.Makro().Expr().Expr.comply(eI,eII);
        if(eq.is_ok()){
          eq = Eq.NullOr(Eq.Makro().Expr().HComplexType).comply(tI,tII);
        }
        eq;
      default : 
        Eq.EnumValueIndex().comply(lhs.prj(),rhs.prj());
    }
  }
}