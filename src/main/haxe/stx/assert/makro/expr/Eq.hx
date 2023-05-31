package stx.assert.makro.expr;

import stx.assert.makro.expr.eq.*;

/**
 * Constructors for `Eq` instances in the `stx.makro.expr` namespace.
 */
class Eq extends Clazz{
  @:isVar public var Metadata(get,null):stx.assert.makro.expr.eq.Metadata;
  private function get_Metadata():stx.assert.makro.expr.eq.Metadata{
    return __.option(this.Metadata).def(() -> this.Metadata = new stx.assert.makro.expr.eq.Metadata());
  }
  @:isVar public var HMetadata(get,null):HMetadata;
  private function get_HMetadata():HMetadata{
    return __.option(this.HMetadata).def(() -> this.HMetadata = new HMetadata());
  }
  @:isVar public var HMetadataEntry(get,null):HMetadataEntry;
  private function get_HMetadataEntry():HMetadataEntry{
    return __.option(this.HMetadataEntry).def(() -> this.HMetadataEntry = new HMetadataEntry());
  }
  @:isVar public var HComplexType(get,null):HComplexType;
  private function get_HComplexType():HComplexType{
    return __.option(this.HComplexType).def(() -> this.HComplexType = new HComplexType());
  }
  @:isVar public var HField(get,null):HField;
  private function get_HField():HField{
    return __.option(this.HField).def(() -> this.HField = new HField());
  }
  @:isVar public var HAccess(get,null):HAccess;
  private function get_HAccess():HAccess{
    return __.option(this.HAccess).def(() -> this.HAccess = new HAccess());
  }
  @:isVar public var HExprdef(get,null):HExprdef;
  private function get_HExprdef():HExprdef{
    return __.option(this.HExprdef).def(() -> this.HExprdef = new HExprdef());
  }
  @:isVar public var HFieldType(get,null):HFieldType;
  private function get_HFieldType():HFieldType{
    return __.option(this.HFieldType).def(() -> this.HFieldType = new HFieldType());
  }
  @:isVar public var Expr(get,null):stx.assert.makro.expr.eq.Expr;
  private function get_Expr():stx.assert.makro.expr.eq.Expr{
    return __.option(this.Expr).def(() -> this.Expr = new stx.assert.makro.expr.eq.Expr());
  }
  @:isVar public var StringLiteralKind(get,null):stx.assert.makro.expr.eq.StringLiteralKind;
  private function get_StringLiteralKind():stx.assert.makro.expr.eq.StringLiteralKind{
    return __.option(this.StringLiteralKind).def(() -> this.StringLiteralKind = new stx.assert.makro.expr.eq.StringLiteralKind());
  }
  @:isVar public var HStringLiteralKind(get,null):stx.assert.makro.expr.eq.HStringLiteralKind;
  private function get_HStringLiteralKind():stx.assert.makro.expr.eq.HStringLiteralKind{
    return __.option(this.HStringLiteralKind).def(() -> this.HStringLiteralKind = new stx.assert.makro.expr.eq.HStringLiteralKind());
  }
  @:isVar public var HTypePath(get,null):HTypePath;
  private function get_HTypePath():HTypePath{
    return __.option(this.HTypePath).def(() -> this.HTypePath = new HTypePath());
  }
  @:isVar public var HTypeParam(get,null):HTypeParam;
  private function get_HTypeParam():HTypeParam{
    return __.option(this.HTypeParam).def(() -> this.HTypeParam = new HTypeParam());
  }
  @:isVar public var HTypeParamDecl(get,null):HTypeParamDecl;
  private function get_HTypeParamDecl():HTypeParamDecl{
    return __.option(this.HTypeParamDecl).def(() -> this.HTypeParamDecl = new HTypeParamDecl());
  }
  @:isVar public var HFunction(get,null):HFunction;
  private function get_HFunction():HFunction{
    return __.option(this.HFunction).def(() -> this.HFunction = new HFunction());
  }
  @:isVar public var HPropAccess(get,null):HPropAccess;
  private function get_HPropAccess():HPropAccess{
    return __.option(this.HPropAccess).def(() -> this.HPropAccess = new HPropAccess());
  }
  @:isVar public var HFunctionArg(get,null):HFunctionArg;
  private function get_HFunctionArg():HFunctionArg{
    return __.option(this.HFunctionArg).def(() -> this.HFunctionArg = new HFunctionArg());
  }
  @:isVar public var Position(get,null):stx.assert.makro.expr.eq.Position;
  private function get_Position():stx.assert.makro.expr.eq.Position{
    return __.option(this.Position).def(() -> this.Position = new stx.assert.makro.expr.eq.Position());
  }
  @:isVar public var QuoteStatus(get,null):stx.assert.makro.expr.eq.QuoteStatus;
  private function get_QuoteStatus():stx.assert.makro.expr.eq.QuoteStatus{
    return __.option(this.QuoteStatus).def(() -> this.QuoteStatus = new stx.assert.makro.expr.eq.QuoteStatus());
  }
  @:isVar public var HQuoteStatus(get,null):stx.assert.makro.expr.eq.HQuoteStatus;
  private function get_HQuoteStatus():stx.assert.makro.expr.eq.HQuoteStatus{
    return __.option(this.HQuoteStatus).def(() -> this.HQuoteStatus = new stx.assert.makro.expr.eq.HQuoteStatus());
  }
  @:isVar public var HFunctionKind(get,null):HFunctionKind;
  private function get_HFunctionKind():HFunctionKind{
    return __.option(this.HFunctionKind).def(() -> this.HFunctionKind = new HFunctionKind());
  }
  @:isVar public var HVar(get,null):HVar;
  private function get_HVar():HVar{
    return __.option(this.HVar).def(() -> this.HVar = new HVar());
  }
  @:isVar public var HCatch(get,null):HCatch;
  private function get_HCatch():HCatch{
    return __.option(this.HCatch).def(() -> this.HCatch = new HCatch());
  }
  @:isVar public var Unop(get,null):stx.assert.makro.expr.eq.Unop;
  private function get_Unop():stx.assert.makro.expr.eq.Unop{
    return __.option(this.Unop).def(() -> this.Unop = new stx.assert.makro.expr.eq.Unop());
  }
  @:isVar public var HConstant(get,null):HConstant;
  private function get_HConstant():HConstant{
    return __.option(this.HConstant).def(() -> this.HConstant = new HConstant());
  }
  @:isVar public var Binop(get,null):stx.assert.makro.expr.eq.Binop;
  private function get_Binop():stx.assert.makro.expr.eq.Binop{
    return __.option(this.Binop).def(() -> this.Binop = new stx.assert.makro.expr.eq.Binop());
  }
  @:isVar public var HObjectField(get,null):HObjectField;
  private function get_HObjectField():HObjectField{
    return __.option(this.HObjectField).def(() -> this.HObjectField = new HObjectField());
  }
  @:isVar public var HCase(get,null):HCase;
  private function get_HCase():HCase{
    return __.option(this.HCase).def(() -> this.HCase = new HCase());
  }
  @:isVar public var EFieldKind(get,null):stx.assert.makro.expr.eq.EFieldKind;
  private function get_EFieldKind():stx.assert.makro.expr.eq.EFieldKind{
    return __.option(this.EFieldKind).def(() -> this.EFieldKind = new stx.assert.makro.expr.eq.EFieldKind());
  }
}