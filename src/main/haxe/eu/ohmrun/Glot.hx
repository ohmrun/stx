package eu.ohmrun;

import haxe.macro.Expr;

import stx.fail.OMFailure;

using stx.Nano;
using stx.Log;
using stx.om.Spine;

using eu.ohmrun.Glot;

class Lang{
  static public function glot(wildcard:Wildcard){
    return new eu.ohmrun.glot.Module();  
  }
}

typedef GlotFailure                 = stx.fail.GlotFailure;
typedef GSource                     = eu.ohmrun.glot.GSource;

typedef GAccessCtr                  = eu.ohmrun.glot.expr.GAccess.GAccessCtr;
typedef GAccessSum                  = eu.ohmrun.glot.expr.GAccess.GAccessSum;
typedef GAccess                     = eu.ohmrun.glot.expr.GAccess;

typedef GExprCtr                    = eu.ohmrun.glot.expr.GExpr.GExprCtr;
typedef GExprSum                    = eu.ohmrun.glot.expr.GExpr.GExprSum;
typedef GExpr                       = eu.ohmrun.glot.expr.GExpr;

typedef GBinopCtr                   = eu.ohmrun.glot.expr.GBinop.GBinopCtr;
typedef GBinopSum                   = eu.ohmrun.glot.expr.GBinop.GBinopSum;
typedef GBinop                      = eu.ohmrun.glot.expr.GBinop;

typedef GCaseCtr                    = eu.ohmrun.glot.expr.GCase.GCaseCtr;
typedef GCaseDef                    = eu.ohmrun.glot.expr.GCase.GCaseDef;
typedef GCase                       = eu.ohmrun.glot.expr.GCase;

typedef GCatchCtr                   = eu.ohmrun.glot.expr.GCatch.GCatchCtr;
typedef GCatchDef                   = eu.ohmrun.glot.expr.GCatch.GCatchDef;
typedef GCatch                      = eu.ohmrun.glot.expr.GCatch;

typedef GComplexTypeCtr             = eu.ohmrun.glot.expr.GComplexType.GComplexTypeCtr;
typedef GComplexTypeSum             = eu.ohmrun.glot.expr.GComplexType.GComplexTypeSum;
typedef GComplexType                = eu.ohmrun.glot.expr.GComplexType;

typedef GConstantCtr                = eu.ohmrun.glot.expr.GConstant.GConstantCtr;
typedef GConstantSum                = eu.ohmrun.glot.expr.GConstant.GConstantSum;
typedef GConstant                   = eu.ohmrun.glot.expr.GConstant;

typedef GEFieldCtr                  = eu.ohmrun.glot.expr.GEField.GEFieldCtr;
typedef GEFieldDef                  = eu.ohmrun.glot.expr.GEField.GEFieldDef;
typedef GEField                     = eu.ohmrun.glot.expr.GEField;

#if (haxe_ver > 4.205)
typedef GEFieldKind                 = eu.ohmrun.glot.expr.GEFieldKind;
#end

typedef GFieldTypeCtr               = eu.ohmrun.glot.expr.GFieldType.GFieldTypeCtr;
typedef GFieldTypeSum               = eu.ohmrun.glot.expr.GFieldType.GFieldTypeSum;
typedef GFieldType                  = eu.ohmrun.glot.expr.GFieldType;

typedef GFunctionCtr                = eu.ohmrun.glot.expr.GFunction.GFunctionCtr;
typedef GFunctionDef                = eu.ohmrun.glot.expr.GFunction.GFunctionDef;
typedef GFunction                   = eu.ohmrun.glot.expr.GFunction;

typedef GFunctionArgCtr             = eu.ohmrun.glot.expr.GFunctionArg.GFunctionArgCtr;
typedef GFunctionArgDef             = eu.ohmrun.glot.expr.GFunctionArg.GFunctionArgDef;
typedef GFunctionArg                = eu.ohmrun.glot.expr.GFunctionArg;

typedef GFunctionKindCtr            = eu.ohmrun.glot.expr.GFunctionKind.GFunctionKindCtr;
typedef GFunctionKindSum            = eu.ohmrun.glot.expr.GFunctionKind.GFunctionKindSum;
typedef GFunctionKind               = eu.ohmrun.glot.expr.GFunctionKind;

typedef GMetadataCtr                = eu.ohmrun.glot.expr.GMetadata.GMetadataCtr;
typedef GMetadataDef                = eu.ohmrun.glot.expr.GMetadata.GMetadataDef;
typedef GMetadata                   = eu.ohmrun.glot.expr.GMetadata;

typedef GMetadataEntryCtr           = eu.ohmrun.glot.expr.GMetadataEntry.GMetadataEntryCtr;
typedef GMetadataEntryDef           = eu.ohmrun.glot.expr.GMetadataEntry.GMetadataEntryDef;
typedef GMetadataEntry              = eu.ohmrun.glot.expr.GMetadataEntry;

typedef GObjectFieldCtr             = eu.ohmrun.glot.expr.GObjectField.GObjectFieldCtr;
typedef GObjectFieldDef             = eu.ohmrun.glot.expr.GObjectField.GObjectFieldDef;
typedef GObjectField                = eu.ohmrun.glot.expr.GObjectField;

typedef GPropAccessCtr              = eu.ohmrun.glot.expr.GPropAccess.GPropAccessCtr;
typedef GPropAccessSum              = eu.ohmrun.glot.expr.GPropAccess.GPropAccessSum;
typedef GPropAccess                 = eu.ohmrun.glot.expr.GPropAccess;

typedef GQuoteStatusCtr             = eu.ohmrun.glot.expr.GQuoteStatus.GQuoteStatusCtr;
typedef GQuoteStatusSum             = eu.ohmrun.glot.expr.GQuoteStatus.GQuoteStatusSum;
typedef GQuoteStatus                = eu.ohmrun.glot.expr.GQuoteStatus;

typedef GStringLiteralKindCtr       = eu.ohmrun.glot.expr.GStringLiteralKind.GStringLiteralKindCtr;
typedef GStringLiteralKindSum       = eu.ohmrun.glot.expr.GStringLiteralKind.GStringLiteralKindSum;
typedef GStringLiteralKind          = eu.ohmrun.glot.expr.GStringLiteralKind;

typedef GTypeDefinitionCtr          = eu.ohmrun.glot.expr.GTypeDefinition.GTypeDefinitionCtr;
typedef GTypeDefinitionDef          = eu.ohmrun.glot.expr.GTypeDefinition.GTypeDefinitionDef;
typedef GTypeDefinition             = eu.ohmrun.glot.expr.GTypeDefinition;

typedef GTypeDefKindCtr             = eu.ohmrun.glot.expr.GTypeDefKind.GTypeDefKindCtr;
typedef GTypeDefKindSum             = eu.ohmrun.glot.expr.GTypeDefKind.GTypeDefKindSum;
typedef GTypeDefKind                = eu.ohmrun.glot.expr.GTypeDefKind;

typedef GTypeParamCtr               = eu.ohmrun.glot.expr.GTypeParam.GTypeParamCtr;
typedef GTypeParamSum               = eu.ohmrun.glot.expr.GTypeParam.GTypeParamSum;
typedef GTypeParam                  = eu.ohmrun.glot.expr.GTypeParam;

typedef GTypeParamDeclCtr           = eu.ohmrun.glot.expr.GTypeParamDecl.GTypeParamDeclCtr;
typedef GTypeParamDeclDef           = eu.ohmrun.glot.expr.GTypeParamDecl.GTypeParamDeclDef;
typedef GTypeParamDecl              = eu.ohmrun.glot.expr.GTypeParamDecl;

typedef GTypePathCtr                = eu.ohmrun.glot.expr.GTypePath.GTypePathCtr;
typedef GTypePathDef                = eu.ohmrun.glot.expr.GTypePath.GTypePathDef;
typedef GTypePath                   = eu.ohmrun.glot.expr.GTypePath;

typedef GUnopCtr                    = eu.ohmrun.glot.expr.GUnop.GUnopCtr;
typedef GUnopSum                    = eu.ohmrun.glot.expr.GUnop.GUnopSum;
typedef GUnop                       = eu.ohmrun.glot.expr.GUnop;

typedef GVarCtr                     = eu.ohmrun.glot.expr.GVar.GVarCtr;
typedef GVarDef                     = eu.ohmrun.glot.expr.GVar.GVarDef;
typedef GVar                        = eu.ohmrun.glot.expr.GVar;

class LiftAccessToGlot{
  #if macro
  static public function toGlot(self:Access):GAccess{
		return switch(self){
			case APrivate 			: GAPrivate;
			case APublic 				: GAPublic;
			case AStatic  			: GAStatic;
			case AOverride			: GAOverride;
			case ADynamic 			: GADynamic;
			case AInline  			: GAInline;
			case AMacro   			: GAMacro;
			case AFinal   			: GAFinal;
			case AExtern  			: GAExtern;
			case AAbstract			: GAAbstract;
			case AOverload			: GAOverload;
		}
	}
  #end
}
class LiftBinopToGlot{
  #if macro
  static public function toGlot(self:Binop):GBinop{
    return switch(self){
      case OpAdd             : GOpAdd;
      case OpMult            : GOpMult;
      case OpDiv             : GOpDiv;
      case OpSub             : GOpSub;
      case OpAssign          : GOpAssign;
      case OpEq              : GOpEq;
      case OpNotEq           : GOpNotEq;
      case OpGt              : GOpGt;
      case OpGte             : GOpGte;
      case OpLt              : GOpLt;
      case OpLte             : GOpLte;
      case OpAnd             : GOpAnd;
      case OpOr              : GOpOr;
      case OpXor             : GOpXor;
      case OpBoolAnd         : GOpBoolAnd;
      case OpBoolOr          : GOpBoolOr;
      case OpShl             : GOpShl;
      case OpShr             : GOpShr;
      case OpUShr            : GOpUShr;
      case OpMod             : GOpMod;
      case OpAssignOp(op)    : GOpAssignOp(toGlot(op,));
      case OpInterval        : GOpInterval;
      case OpArrow           : GOpArrow;
      case OpIn              : GOpIn;
      #if (haxe_ver > 4.205)
      case OpNullCoal        : GOpNullCoal;
      #end
    }
  }
  #end
}
class LiftCaseToGlot{
  #if macro
  static public function toGlot(self:Case):GCase{
    return @:privateAccess {
      values  : __.option(self.values).map(x -> x.map(y -> y.toGlot())).defv([]),
      guard   : __.option(self.guard).map(x -> x.toGlot()).defv(null),
      expr    : __.option(self.expr).map(x -> x.toGlot()).defv(null) 
    }
  }
  #end
}
class LiftCatchToGlot{
  #if macro
  static public function toGlot(self:Catch):GCatch{
    return {
      name  : self.name,
      expr  : self.expr.toGlot(),
      type  : __.option(self.type).map(x -> x.toGlot()).defv(null)
    };
  }
  #end
}
typedef GlotSpineDef  = stx.om.spine.glot.GlotSpine.GlotSpineDef;
typedef GlotSpine     = stx.om.spine.glot.GlotSpine;

class LiftGlotToSpine{
  static public function toSpine(self:GExpr):Upshot<GlotSpine,OMFailure>{
    return new stx.om.spine.glot.FromGlot().apply(self);
  }
}
class SpineToGlot{
  static public function fromSpine(self:Spine):GExpr{
    return new stx.om.spine.glot.ToGlot().apply(self);
  }
}
class LiftComplextTypeToGlot{
  #if macro
  static public function toGlot(self:ComplexType):GComplexType{
		return @:privateAccess switch(self){
			case TPath( p )             : GTPath( p.toGlot() );
			case TFunction( args , ret ): GTFunction( args.map(arg -> toGlot(arg,)) , toGlot(ret,) );
			case TAnonymous( fields  )  : GTAnonymous( fields.map(x -> x.toGlot())  );
			case TParent( t )           : GTParent( t.toGlot() );
			case TExtend( p , fields  ) : GTExtend( p.map(x -> x.toGlot()) , fields.map(x -> x.toGlot())  );
			case TOptional( t )         : GTOptional( t.toGlot() );
			case TNamed( n , t )        : GTNamed( n , t.toGlot() );
			case TIntersection(tl)      : GTIntersection(tl.map(x -> x.toGlot()));
		}		
	}
  #end
}

class LiftConstantToGlot{
  #if macro
  static public function toGlot(self:Constant):GConstant{
    return switch(self){
      #if (haxe_ver > 4.205) 
      case CInt(v, s)        : GCInt(v, s);       
      case CFloat(f, s)      : GCFloat(f, s);     
      #else
      case CInt(v)           : GCInt(v);
      case CFloat(f)         : GCFloat(f);     
      #end       
      case CString(s, kind)  : GCString(s, __.option(kind).map(x -> x.toGlot()).defv(null)); 
      case CIdent(s)         : GCIdent(s);        
      case CRegexp(r, opt)   : GCRegexp(r, opt);  
    }
  }
  #end
}
class LiftEFieldToGlot{
  #if macro
  static public function toGlot(self:haxe.macro.Expr.Field):GEField{
    return @:privateAccess {
      name      : self.name,
      kind      : self.kind.toGlot(),
      access    : __.option(self.access).map(x -> x.map(y -> y.toGlot())).defv([]),
      meta      : __.option(self.meta).map(x -> x.toGlot()).defv(null),
      doc       : self.doc
    }
  }
  #end
}
class LiftEFieldKindToGlot{
  #if macro
  static public function toGlot(self:haxe.macro.Expr.EFieldKind):GEFieldKind{
		return switch(self){
			case Normal 	: GNormal;
			case Safe 		: GSafe;
		}
	}
  #end
}
class LiftExprToGlot{
  #if macro
  static public function toGlot(self:haxe.macro.Expr):GExpr{
    final f = toGlot;
    return switch(self.expr){
      case EConst(c)                     : GEConst(c.toGlot());
      case EArray(e1, e2)                : GEArray(f(e1), f(e2));
      case EBinop(op, e1, e2)            : GEBinop(op.toGlot(), f(e1), f(e2));
      case EDisplay(e, _)                : toGlot(e);
      #if (haxe_ver > 4.205) 
      case EField(e, field, kind)        : GEField(f(e), field, __.option(kind).map(x -> x.toGlot()).defv(null));
      #else
      case EField(e, field)              : GEField(f(e), field);
      #end
      case EParenthesis(e)               : GEParenthesis(f(e));
      case EObjectDecl(fields)           : GEObjectDecl(fields.map(e -> e.toGlot()));
      case EArrayDecl(values)            : GEArrayDecl(values.map(e -> e.toGlot()));
      case ECall(e, params)              : GECall(f(e), params.map(e -> e.toGlot()));
      case ENew(t, params)               : GENew(t.toGlot(), params.map(e -> e.toGlot()));
      case EUnop(op, postFix, e)         : GEUnop(op.toGlot(), postFix, e.toGlot());
      case EVars(vars)                   : GEVars(vars.map(e -> LiftVarToGlot.toGlot(e)));
      case EFunction(kind, f)            : GEFunction(__.option(kind).map(x -> x.toGlot()).defv(null), f.toGlot());
      case EBlock(exprs)                 : GEBlock(exprs.map(e -> e.toGlot()));
      case EFor(i, eexpr)                : GEFor(i.toGlot(), eexpr.toGlot());
      case EIf(econd, eif, eelse)        : GEIf(econd.toGlot(), eif.toGlot(), __.option(eelse).map(x -> x.toGlot()).defv(null));
      case EWhile(econd, e, normalWhile) : GEWhile(econd.toGlot(), e.toGlot(), normalWhile);
      case ESwitch(e, cases, edef)       : GESwitch(e.toGlot(), cases.map(e -> e.toGlot()), __.option(edef).map(x -> x.toGlot()).defv(null));
      case ETry(e, catches)              : GETry(e.toGlot(), catches.map(e -> e.toGlot()));
      case EReturn(e)                    : GEReturn(__.option(e).map(x -> x.toGlot()).defv(null));
      case EBreak                        : GEBreak;
      case EContinue                     : GEContinue;
      case EUntyped(e)                   : GEUntyped(e.toGlot());
      case EThrow(e)                     : GEThrow(e.toGlot());
      case ECast(e, t)                   : GECast(e.toGlot(), __.option(t).map(x -> x.toGlot()).defv(null));
      case ETernary(econd, eif, eelse)   : GETernary(econd.toGlot(), eif.toGlot(), eelse.toGlot());
      case ECheckType(e, t)              : GECheckType(e.toGlot(), t.toGlot());
      case EMeta(s, e)                   : GEMeta(s.toGlot(), e.toGlot());
      case EIs(e, t)                     : GEIs(e.toGlot(), t.toGlot());
      case null                           : null;
    }
  }
  #end
}
class LiftFieldTypeToGlot{
  #if macro
  static public function toGlot(self:FieldType):GFieldType{
    return switch(self){
      case FVar( t  , e)            :  GFVar(
        __.option(t).map(ct -> ct.toGlot()).defv(null)  , 
        __.option(e).map(e -> e.toGlot()).defv(null))
      ;
      case FFun( f  )               :  GFFun( LiftFunctionToGlot.toGlot(f)  );
      case FProp( get , set , t, e) :  GFProp( 
        GPropAccess.fromString(get), 
        GPropAccess.fromString(set), 
        __.option(t).map(x -> x.toGlot()).defv(null) , 
        __.option(e).map(x -> x.toGlot()).defv(null)
      );
    } 
  }
  #end
}
class LiftFunctionToGlot{
  #if macro
  static public function toGlot(self:Function):GFunction{
    return @:privateAccess {
      args    : self.args.map(arg -> arg.toGlot()),
      ret     : __.option(self.ret).map(ret -> ret.toGlot()).defv(null),
      expr    : __.option(self.expr).map(x -> x.toGlot()).defv(null),
      params  : __.option(self.params).map(x -> x.map(y -> y.toGlot())).defv([])
    }
  }
  #end 
}
class LiftFunctionArgToGlot{
  #if macro
  static public function toGlot(self:FunctionArg):GFunctionArg{
    return {
      name    : self.name,
      type    : __.option(self.type).map(e -> e.toGlot()).defv(null),
      opt     : self.opt,
      value   : __.option(self.value).map(e -> e.toGlot()).defv(null),
      meta    : __.option(self.meta).map(x -> x.toGlot()).defv(null)
    }
  }
  #end
}
class LiftFunctionKindToGlot{
  #if macro
  static public function toGlot(self:FunctionKind):GFunctionKind{
		return switch(self){
			case FAnonymous           :		GFAnonymous;
			case FNamed(name, inlined):		GFNamed(name, inlined);
			case FArrow               :		GFArrow;
		}
	}
  #end
}
class LiftMetadataToGlot{
  #if macro
  static public function toGlot(self:Metadata):GMetadata{
    return @:privateAccess self.map(e -> e.toGlot());
  }
  #end
}
class LiftMetadataEntryToGlot{
  #if macro
  static public function toGlot(self:MetadataEntry):GMetadataEntry{
    return @:privateAccess {
      name    : self.name,
	    params  : __.option(self.params).map(x -> x.map(y -> y.toGlot())).defv([])
    };
  }
  #end
}
class LiftObjectFieldToGlot{
  #if macro
  static public function toGlot(self:ObjectField):GObjectField{
    return {
      field  : self.field,
      expr   : self.expr.toGlot(),
      quotes : __.option(self.quotes).map(x -> x.toGlot()).defv(null)
    }
  }
  #end
}
class LiftQuoteStatusToGlot{
  #if macro 
  static public function toGlot(self:QuoteStatus):GQuoteStatus{
		return switch(self){
			case Unquoted 	: GUnquoted;
			case Quoted 		: GQuoted;
		}
	}
  #end
}
class LiftStringLiteralKindToGlot{
  #if macro
  static public function toGlot(self:StringLiteralKind):GStringLiteralKind{
		return switch(self){
			case DoubleQuotes: GDoubleQuotes;
			case SingleQuotes: GSingleQuotes;
		}
	}
  #end
}
class LiftTypeDefinitionToGlot{
  #if macro
  static public function toGlot(self:haxe.macro.Expr.TypeDefinition):GTypeDefinition{
    __.log().debug('gtypedefinition.toGlot');
    return @:privateAccess {
      name        : self.name,
      pack        : self.pack,
      kind        : self.kind.toGlot(),
      fields      : self.fields.map(x -> x.toGlot()),
      params      : __.option(self.params).map(x -> x.map(y -> y.toGlot())).defv([]),
      meta        : __.option(self.meta).map( x -> x.toGlot()).defv([]),
      isExtern    : self.isExtern,
      doc         : self.doc
    }
  }
  #end
}
class LiftTypeDefKindToGlot{
  #if macro
  static public function toGlot(self:TypeDefKind):GTypeDefKind{
    return @:privateAccess switch(self){
      case TDEnum               : GTDEnum;
      case TDStructure          : GTDStructure;
      case TDClass( superClass , interfaces , isInterface , isFinal , isAbstract ) : 
        GTDClass(
          __.option(superClass).map(x -> x.toGlot()).defv(null),
          __.option(interfaces).map(x -> x.map(y -> y.toGlot())).defv([]),
          isInterface,
          isFinal,
          isAbstract
        );
      case TDAlias( t ) : GTDAlias(t.toGlot());
      case TDAbstract( tthis , from , to ) :
          GTDAbstract(
            __.option(tthis).map(x -> x.toGlot()).defv(null),
            __.option(from).map(x -> x.map(y -> y.toGlot())).defv([]),
            __.option(to).map(x -> x.map(y -> y.toGlot())).defv([])
          );
      case TDField(kind, access) : 
          GTDField(kind.toGlot(),access.map(x -> x.toGlot()));
    }
  }
  #end
}
class LiftTypeParamToGlot{
  #if macro
  static public function toGlot(self:TypeParam):GTypeParam{
    return switch(self){
      case TPType( t ) : GTPType(t.toGlot());
	    case TPExpr( e ) : GTPExpr(e.toGlot());
    }
  }
  #end
}
class GTypeParamDeclToGlot{
  #if macro
  static public function toGlot(self:TypeParamDecl):GTypeParamDecl{
    return @:privateAccess {
      name        : self.name,
      constraints : __.option(self.constraints).map(x -> x.map(y -> y.toGlot())).defv([]),
      params      : __.option(self.params).map(x -> x.map(y -> y.toGlot())).defv([]),
      meta        : __.option(self.meta).map(x -> x.map(y -> y.toGlot())).defv([]),
      #if (haxe_ver > 4.205) 
      defaultType : __.option(self.defaultType).map(x -> x.toGlot()).defv(null)
      #end
    };
  }
  #end
}
class LiftTypePathToGlot{
  #if macro
  static public function toGlot(self:TypePath):GTypePath{
    return @:privateAccess {
      name    : self.name,
      pack    : __.option(self.pack).map(x -> x).defv([]),
      params  : __.option(self.params).map(x -> x.map(y -> y.toGlot())).defv([]),
      sub     : self.sub
    }
  } 
  #end
}
class LiftUnopToGLot{
  #if macro
  static public function toGlot(self:Unop):GUnop{
    return switch(self){
      case OpIncrement     : GOpIncrement;
      case OpDecrement     : GOpDecrement;
      case OpNot           : GOpNot;
      case OpNeg           : GOpNeg;
      case OpNegBits       : GOpNegBits;
      case OpSpread        : GOpSpread;
    }
  }
  #end
}
class LiftVarToGlot{
  #if macro
  static public function toGlot(self:Var):GVar{
		return {
			name 				: self.name,
			type 				: __.option(self.type).map(x -> x.toGlot()).defv(null),
			expr 				: __.option(self.expr).map(x -> x.toGlot()).defv(null),
			isFinal 		: self.isFinal,
			isStatic 		: self.isStatic,
			meta 				: __.option(self.meta).map(x -> x.toGlot()).defv(null)
		}		
	}
  #end
}