package stx.assert.g.ord;

import stx.g.lang.expr.GTypeDefKind as GTypeDefKindT;

class GTypeDefKind extends OrdCls<GTypeDefKindT>{
  public function new(){}
  public function comply(lhs:GTypeDefKindT,rhs:GTypeDefKindT){
    return switch([lhs,rhs]){
      case [GTDEnum,GTDEnum] : NotLessThan;
      case [GTDStructure,GTDStructure] : NotLessThan; 
      case [GTDClass(superClassI,interfacesI, isInterfaceI, isFinalI, isAbstractI),GTDClass(superClassII,interfacesII, isInterfaceII, isFinalII, isAbstractII)]:
        var ord = Ord.NullOr(new GTypePath()).comply(superClassI,superClassII);
        if(ord.is_not_less_than()){
          ord = Ord.NullOr(Ord.Cluster(new GTypePath())).comply(interfacesI,interfacesII);
        }
        if(ord.is_not_less_than()){
          ord = Ord.NullOr(Ord.Bool()).comply(isInterfaceI,isInterfaceII);
        }
        if(ord.is_not_less_than()){
          ord = Ord.NullOr(Ord.Bool()).comply(isFinalI,isFinalII);
        }
        if(ord.is_not_less_than()){
          ord = Ord.NullOr(Ord.Bool()).comply(isAbstractI,isAbstractII);
        }
        ord;
      case [GTDAlias(tI),GTDAlias(tII)] : 
        new GComplexType().comply(tI,tII);
      case [GTDAbstract( tthisI, fromI, toI),GTDAbstract( tthisII, fromII, toII)] : 
        var ord = Ord.NullOr(new GComplexType()).comply(tthisI,tthisII);
        if(ord.is_not_less_than()){
          ord = Ord.NullOr(Ord.Cluster(new GComplexType())).comply(fromI,fromII);
        }
        if(ord.is_not_less_than()){
          ord = Ord.NullOr(Ord.Cluster(new GComplexType())).comply(toI,toII);
        }
        ord;
      case [GTDField(kindI,accessI),GTDField(kindII,accessII)]:
        var ord = new GFieldType().comply(kindI,kindII);
        if(ord.is_not_less_than()){
          ord = Ord.NullOr(Ord.Cluster(new GAccess())).comply(accessI,accessII);
        }
        ord;
      default :
        Ord.EnumValueIndex().comply(lhs,rhs);
    }
  }
}