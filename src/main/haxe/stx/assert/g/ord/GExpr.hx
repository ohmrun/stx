package stx.assert.g.ord;

import stx.g.lang.expr.GExpr as GExprT;

class GExpr extends OrdCls<GExprT>{
  public function new(){}
  public function comply(lhs:GExprT,rhs:GExprT):Ordered{
    return switch([lhs,rhs]){
      case [GEConst(cI),GEConst(cII)] :
        new GConstant().comply(cI,cII);
      case [GEArray(e1I,e2I),GEArray(e1II,e2II)] :
        var ord = comply(e1I,e1II);
        if(ord.is_not_less_than()){
          ord = comply(e2I,e2II);
        }
        ord;
      case [GEBinop(opI,e1I,e2I),GEBinop(opII,e1II,e2II)] :
        var ord = new GBinop().comply(opI,opII);
        if(ord.is_not_less_than()){
          ord = comply(e1I,e1II);
        }
        if(ord.is_not_less_than()){
          ord = comply(e2I,e2II);
        }
        ord;
      #if (haxe_ver > 4.205)
      case [GEField(eI,fieldI,kindI),GEField(eII,fieldII,kindII)] :
        var ord = comply(eI,eII);
        if(ord.is_not_less_than()){
          ord = Ord.String().comply(fieldI,fieldII);
        }
        if(ord.is_not_less_than()){
          ord = Ord.NullOr(new GEFieldKind()).comply(kindI,kindII);
        }
        ord;
      #else
      case [GEField(eI,fieldI),GEField(eII,fieldII)] :
        var ord = comply(eI,eII);
        if(ord.is_not_less_than()){
          ord = Ord.String().comply(fieldI,fieldII);
        }
        ord;
      #end
      case [GEParenthesis(eI),GEParenthesis(eII)] :
        comply(eI,eII);
      case [GEObjectDecl(fieldsI),GEObjectDecl(fieldsII)] :
        Ord.Cluster(new GObjectField()).comply(fieldsI,fieldsII);
      case [GEArrayDecl(valuesI),GEArrayDecl(valuesII)] :
        Ord.Cluster(this).comply(valuesI,valuesII);
      case [GECall(eI,paramsI),GECall(eII,paramsII)] :
        var ord = comply(eI,eII);
        if(ord.is_not_less_than()){
          ord = Ord.Cluster(this).comply(paramsI,paramsII);
        }
        ord;
      case [GENew(tI,paramsI),GENew(tII,paramsII)] :
        var ord = new GTypePath().comply(tI,tII);
        if(ord.is_not_less_than()){
          ord = Ord.Cluster(this).comply(paramsI,paramsII);
        }
        ord;
      case [GEUnop(opI,postFixI,eI),GEUnop(opII,postFixII,eII)] :
        var ord = new GUnop().comply(opI,opII);
        if(ord.is_not_less_than()){
          ord = Ord.Bool().comply(postFixI,postFixII);
        }
        if(ord.is_not_less_than()){
          ord = comply(eI,eII);
        }
        ord;
      case [GEVars(varsI),GEVars(varsII)] :
        Ord.Cluster(new GVar()).comply(varsI,varsII);
      case [GEFunction(kindI,fI),GEFunction(kindII,fII)] :
        var ord = Ord.NullOr(new GFunctionKind()).comply(kindI,kindII);
        if(ord.is_not_less_than()){
          ord = new GFunction().comply(fI,fII);
        }
        ord;
      case [GEBlock(exprsI),GEBlock(exprsII)] :
        Ord.Cluster(this).comply(exprsI,exprsII);
      case [GEFor(iI,eexprI),GEFor(iII,eexprII)] :
        var ord = comply(iI,iII);
        if(ord.is_not_less_than()){
          ord = comply(eexprI,eexprII);
        }
        ord;
      case [GEIf(econdI,eifI,eelseI),GEIf(econdII,eifII,eelseII)] :
        var ord = comply(econdI,econdII);
        if(ord.is_not_less_than()){
          ord = comply(eifI,eifII);
        }
        if(ord.is_not_less_than()){
          ord = Ord.NullOr(this).comply(eelseI,eelseII);
        }
        ord;
      case [GEWhile(econdI,eI,normalWhileI),GEWhile(econdII,eII,normalWhileII)] :
        var ord = comply(econdI,econdII);
        if(ord.is_not_less_than()){
          ord = comply(eI,eII);
        }
        if(ord.is_not_less_than()){
          ord = Ord.Bool().comply(normalWhileI,normalWhileII);
        }
        ord;
      case [GESwitch(eI,casesI,edefI),GESwitch(eII,casesII,edefII) ] :
        var ord = comply(eI,eII);
        if(ord.is_not_less_than()){
          ord = Ord.Cluster(new GCase()).comply(casesI,casesII);
        }
        if(ord.is_not_less_than()){
          ord = Ord.NullOr(this).comply(edefI,edefII);
        }
        ord;
      case [GETry(eI,catchesI),GETry(eII,catchesII)] :
        var ord = comply(eI,eII);
        if(ord.is_not_less_than()){
          ord = Ord.Cluster(new GCatch()).comply(catchesI,catchesII);
        }
        ord;
      case [GEReturn(eI),GEReturn(eII)] :
        comply(eI,eII);
      case [GEBreak,GEBreak] :
        NotLessThan;
      case [GEContinue,GEContinue] :
        NotLessThan;
      case [GEUntyped(eI),GEUntyped(eII)] :
        comply(eI,eII);
      case [GEThrow(eI),GEThrow(eII)] :
        comply(eI,eII);
      case [GECast(eI,tI),GECast(eII,tII)] :
        var ord = comply(eI,eII);
        if(ord.is_not_less_than()){
          ord = Ord.NullOr(new GComplexType()).comply(tI,tII);
        }
        ord;
      case [GETernary(econdI,eifI,eelseI),GETernary(econdII,eifII,eelseII)] :
        var ord = comply(econdI,econdII);
        if(ord.is_not_less_than()){
          ord = comply(eifI,eifII);
        }
        if(ord.is_not_less_than()){
          ord = comply(eelseI,eelseII);
        }
        ord;
      case [GECheckType(eI,tI),GECheckType(eII,tII)] :
        var ord = comply(eI,eII);
        if(ord.is_not_less_than()){
          ord = Ord.NullOr(new GComplexType()).comply(tI,tII);
        }
        ord;
      case [GEMeta(sI,eI),GEMeta(sII,eII)] :
        var ord = new GMetadataEntry().comply(sI,sII);
        if(ord.is_not_less_than()){
          ord = comply(eI,eII);
        }
        ord;
      case [GEIs(eI,tI),GEIs(eII,tII)] :
        var ord = comply(eI,eII);
        if(ord.is_not_less_than()){
          ord = Ord.NullOr(new GComplexType()).comply(tI,tII);
        }
        ord;
      default : Ord.EnumValueIndex().comply(lhs,rhs);
    }
  }
}