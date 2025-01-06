package stx.assert.glot.eq;

import eu.ohmrun.glot.expr.GTypeDefKind as GTypeDefKindT;

class GTypeDefKind extends stx.assert.eq.term.Base<GTypeDefKindT> {
  public function comply(lhs:GTypeDefKindT,rhs:GTypeDefKindT){
    return switch([lhs,rhs]){
      case [GTDEnum,GTDEnum] : AreEqual;
      case [GTDStructure,GTDStructure] : AreEqual; 
      case [
        GTDClass(superClassI,interfacesI, isInterfaceI, isFinalI, isAbstractI),
        GTDClass(superClassII,interfacesII, isInterfaceII, isFinalII, isAbstractII)
      ] : 
        var eq = Eq.NullOr(new GTypePath()).comply(superClassI,superClassII);
        if(eq.is_ok()){
          eq = Eq.NullOr(Eq.Cluster(new GTypePath())).comply(interfacesI,interfacesII);
        }
        if(eq.is_ok()){
          eq = Eq.NullOr(Eq.Bool()).comply(isInterfaceI,isInterfaceII);
        }
        if(eq.is_ok()){
          eq = Eq.NullOr(Eq.Bool()).comply(isFinalI,isFinalII);
        }
        if(eq.is_ok()){
          eq = Eq.NullOr(Eq.Bool()).comply(isAbstractI,isAbstractII);
        }
        eq;
      case [GTDAlias(tI),GTDAlias(tII)] : 
        GComplexType.instance.comply(tI,tII);
      case [GTDAbstract( tthisI, flagsI, fromI, toI),GTDAbstract( tthisII, flagsII, fromII, toII)] : 
        var eq = Eq.NullOr(GComplexType.instance).comply(tthisI,tthisII);
        if(eq.is_ok()){
          eq = Eq.NullOr(Eq.Cluster(GAbstractFlag.instance)).comply(flagsI,flagsII);
        }
        if(eq.is_ok()){
          eq = Eq.NullOr(Eq.Cluster(GComplexType.instance)).comply(fromI,fromII);
        }
        if(eq.is_ok()){
          eq = Eq.NullOr(Eq.Cluster(GComplexType.instance)).comply(toI,toII);
        }
        eq;
      case [GTDField(kindI,accessI),GTDField(kindII,accessII)]:
        var eq = new GFieldType().comply(kindI,kindII);
        if(eq.is_ok()){
          eq = Eq.NullOr(Eq.Cluster(new GAccess())).comply(accessI,accessII);
        }
        eq;
      default : Eq.EnumValueIndex().comply(lhs,rhs);
    }
  }
}