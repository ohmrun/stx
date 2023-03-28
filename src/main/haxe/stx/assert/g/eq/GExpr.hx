package stx.assert.g.eq;

import stx.g.lang.expr.GExpr as GExprT;

class GExpr implements EqApi<GExprT> extends Clazz{
  public function comply(lhs:GExprT,rhs:GExprT):Equaled{
    return switch([lhs,rhs]){
      case [GEConst(cI),GEConst(cII)] :
        new GConstant().comply(cI,cII);
      case [GEArray(e1I,e2I),GEArray(e1II,e2II)] :
        var eq = comply(e1I,e1II);
        if(eq.is_ok()){
          eq = comply(e2I,e2II);
        }
        eq;
      case [GEBinop(opI,e1I,e2I),GEBinop(opII,e1II,e2II)] :
        var eq = new GBinop().comply(opI,opII);
        if(eq.is_ok()){
          eq = comply(e1I,e1II);
        }
        if(eq.is_ok()){
          eq = comply(e2I,e2II);
        }
        eq;
      #if (haxe_ver > 4.205)
      case [GEField(eI,fieldI,kindI),GEField(eII,fieldII,kindII)] :
        var eq = comply(eI,eII);
        if(eq.is_ok()){
          eq = Eq.String().comply(fieldI,fieldII);
        }
        if(eq.is_ok()){
          eq = Eq.NullOr(new GEFieldKind()).comply(kindI,kindII);
        }
        eq;
      #else
      case [GEField(eI,fieldI),GEField(eII,fieldII)] :
        var eq = comply(eI,eII);
        if(eq.is_ok()){
          eq = Eq.String().comply(fieldI,fieldII);
        }
        eq;
      #end
      case [GEParenthesis(eI),GEParenthesis(eII)] :
        comply(eI,eII);
      case [GEObjectDecl(fieldsI),GEObjectDecl(fieldsII)] :
        final cons = () -> RedBlackSet.make(Comparable.Anon(new GObjectField(),new stx.assert.g.ord.GObjectField()));
        var lset = cons();
            lset = lset.concat(fieldsI);
        var rset = cons();     
            rset = rset.concat(fieldsII);
        lset.equals(rset);
      case [GEArrayDecl(valuesI),GEArrayDecl(valuesII)] :
        Eq.Cluster(this).comply(valuesI,valuesII);
      case [GECall(eI,paramsI),GECall(eII,paramsII)] :
        var eq = comply(eI,eII);
        if(eq.is_ok()){
          eq = Eq.Cluster(this).comply(paramsI,paramsII);
        }
        eq;
      case [GENew(tI,paramsI),GENew(tII,paramsII)] :
        var eq = new GTypePath().comply(tI,tII);
        if(eq.is_ok()){
          eq = Eq.Cluster(this).comply(paramsI,paramsII);
        }
        eq;
      case [GEUnop(opI,postFixI,eI),GEUnop(opII,postFixII,eII)] :
        var eq = new GUnop().comply(opI,opII);
        if(eq.is_ok()){
          eq = Eq.Bool().comply(postFixI,postFixII);
        }
        if(eq.is_ok()){
          eq = comply(eI,eII);
        }
        eq;
      case [GEVars(varsI),GEVars(varsII)] :
        Eq.Cluster(new GVar()).comply(varsI,varsII);
      case [GEFunction(kindI,fI),GEFunction(kindII,fII)] :
        var eq = Eq.NullOr(new GFunctionKind()).comply(kindI,kindII);
        if(eq.is_ok()){
          eq = new GFunction().comply(fI,fII);
        }
        eq;
      case [GEBlock(exprsI),GEBlock(exprsII)] :
        Eq.Cluster(this).comply(exprsI,exprsII);
      case [GEFor(iI,eexprI),GEFor(iII,eexprII)] :
        var eq = comply(iI,iII);
        if(eq.is_ok()){
          eq = comply(eexprI,eexprII);
        }
        eq;
      case [GEIf(econdI,eifI,eelseI),GEIf(econdII,eifII,eelseII)] :
        var eq = comply(econdI,econdII);
        if(eq.is_ok()){
          eq = comply(eifI,eifII);
        }
        if(eq.is_ok()){
          eq = Eq.NullOr(this).comply(eelseI,eelseII);
        }
        eq;
      case [GEWhile(econdI,eI,normalWhileI),GEWhile(econdII,eII,normalWhileII)] :
        var eq = comply(econdI,econdII);
        if(eq.is_ok()){
          eq = comply(eI,eII);
        }
        if(eq.is_ok()){
          eq = Eq.Bool().comply(normalWhileI,normalWhileII);
        }
        eq;
      case [GESwitch(eI,casesI,edefI),GESwitch(eII,casesII,edefII) ] :
        var eq = comply(eI,eII);
        if(eq.is_ok()){
          eq = Eq.Cluster(new GCase()).comply(casesI,casesII);
        }
        if(eq.is_ok()){
          eq = Eq.NullOr(this).comply(edefI,edefII);
        }
        eq;
      case [GETry(eI,catchesI),GETry(eII,catchesII)] :
        var eq = comply(eI,eII);
        if(eq.is_ok()){
          eq = Eq.Cluster(new GCatch()).comply(catchesI,catchesII);
        }
        eq;
      case [GEReturn(eI),GEReturn(eII)] :
        comply(eI,eII);
      case [GEBreak,GEBreak] :
        AreEqual;
      case [GEContinue,GEContinue] :
        AreEqual;
      case [GEUntyped(eI),GEUntyped(eII)] :
        comply(eI,eII);
      case [GEThrow(eI),GEThrow(eII)] :
        comply(eI,eII);
      case [GECast(eI,tI),GECast(eII,tII)] :
        var eq = comply(eI,eII);
        if(eq.is_ok()){
          eq = Eq.NullOr(new GComplexType()).comply(tI,tII);
        }
        eq;
      case [GETernary(econdI,eifI,eelseI),GETernary(econdII,eifII,eelseII)] :
        var eq = comply(econdI,econdII);
        if(eq.is_ok()){
          eq = comply(eifI,eifII);
        }
        if(eq.is_ok()){
          eq = comply(eelseI,eelseII);
        }
        eq;
      case [GECheckType(eI,tI),GECheckType(eII,tII)] :
        var eq = comply(eI,eII);
        if(eq.is_ok()){
          eq = Eq.NullOr(new GComplexType()).comply(tI,tII);
        }
        eq;
      case [GEMeta(sI,eI),GEMeta(sII,eII)] :
        var eq = new GMetadataEntry().comply(sI,sII);
        if(eq.is_ok()){
          eq = comply(eI,eII);
        }
        eq;
      case [GEIs(eI,tI),GEIs(eII,tII)] :
        var eq = comply(eI,eII);
        if(eq.is_ok()){
          eq = Eq.NullOr(new GComplexType()).comply(tI,tII);
        }
        eq;
      default : 
        Eq.EnumValueIndex().comply(lhs,rhs);
    }
  }
}