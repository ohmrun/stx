package eu.ohmrun;

using stx.Nano;

class Lang{
  static public function glot(wildcard:Wildcard){
    return new eu.ohmrun.glot.Module();  
  }
}

typedef GlotFailure         = stx.fail.GlotFailure;
typedef GSource             = eu.ohmrun.glot.GSource;


typedef GAccess             = eu.ohmrun.glot.expr.GAccess;
typedef GAccessSum          = eu.ohmrun.glot.expr.GAccess.GAccessSum;
typedef GAccessCtr          = eu.ohmrun.glot.expr.GAccess.GAccessCtr;

typedef GBinop              = eu.ohmrun.glot.expr.GBinop;
typedef GBinopSum           = eu.ohmrun.glot.expr.GBinop.GBinopSum;

typedef GCase               = eu.ohmrun.glot.expr.GCase;
typedef GCaseDef            = eu.ohmrun.glot.expr.GCase.GCaseDef;
typedef GCaseCtr            = eu.ohmrun.glot.expr.GCase.GCaseCtr;

typedef GCatch              = eu.ohmrun.glot.expr.GCatch;
typedef GCatchDef           = eu.ohmrun.glot.expr.GCatch.GCatchDef;
typedef GCatchCtr           = eu.ohmrun.glot.expr.GCatch.GCatchCtr;


typedef GComplexType        = eu.ohmrun.glot.expr.GComplexType;
typedef GComplexTypeSum     = eu.ohmrun.glot.expr.GComplexType.GComplexTypeSum;
typedef GComplexTypeCtr     = eu.ohmrun.glot.expr.GComplexType.GComplexTypeCtr;

typedef GConstant           = eu.ohmrun.glot.expr.GConstant;
typedef GConstantSum        = eu.ohmrun.glot.expr.GConstant.GConstantSum;
typedef GConstantCtr        = eu.ohmrun.glot.expr.GConstant.GConstantCtr;

typedef GExpr               = eu.ohmrun.glot.expr.GExpr;
typedef GExprSum            = eu.ohmrun.glot.expr.GExpr.GExprSum;
typedef GExprCtr            = eu.ohmrun.glot.expr.GExpr.GExprCtr;

typedef GField              = eu.ohmrun.glot.expr.GField;
typedef GFieldDef           = eu.ohmrun.glot.expr.GField.GFieldDef;
typedef GFieldCtr           = eu.ohmrun.glot.expr.GField.GFieldCtr;


#if (hax_ver > 4.205)
typedef GEFieldKind          = eu.ohmrun.glot.expr.GEFieldKind;
#end

typedef GFieldType          = eu.ohmrun.glot.expr.GFieldType;
typedef GFieldTypeSum       = eu.ohmrun.glot.expr.GFieldType.GFieldTypeSum;
typedef GFieldTypeCtr       = eu.ohmrun.glot.expr.GFieldType.GFieldTypeCtr;

typedef GFunction           = eu.ohmrun.glot.expr.GFunction;
typedef GFunctionDef        = eu.ohmrun.glot.expr.GFunction.GFunctionDef;
typedef GFunctionCtr        = eu.ohmrun.glot.expr.GFunction.GFunctionCtr;

typedef GFunctionKind       = eu.ohmrun.glot.expr.GFunctionKind;

typedef GFunctionArg        = eu.ohmrun.glot.expr.GFunctionArg;
typedef GFunctionArgDef     = eu.ohmrun.glot.expr.GFunctionArg.GFunctionArgDef;
typedef GFunctionArgCtr     = eu.ohmrun.glot.expr.GFunctionArg.GFunctionArgCtr;

typedef GMetadata           = eu.ohmrun.glot.expr.GMetadata;

typedef GMetadataEntry      = eu.ohmrun.glot.expr.GMetadataEntry;
typedef GMetadataEntryDef   = eu.ohmrun.glot.expr.GMetadataEntry.GMetadataEntryDef;
typedef GMetadataEntryCtr   = eu.ohmrun.glot.expr.GMetadataEntry.GMetadataEntryCtr;

typedef GObjectField        = eu.ohmrun.glot.expr.GObjectField;
typedef GObjectFieldDef     = eu.ohmrun.glot.expr.GObjectField.GObjectFieldDef;
typedef GObjectFieldCtr     = eu.ohmrun.glot.expr.GObjectField.GObjectFieldCtr;

typedef GPropAccess         = eu.ohmrun.glot.expr.GPropAccess;
typedef GPropAccessSum      = eu.ohmrun.glot.expr.GPropAccess.GPropAccessSum;
typedef GPropAccessCtr      = eu.ohmrun.glot.expr.GPropAccess.GPropAccessCtr;

typedef GQuoteStatus        = eu.ohmrun.glot.expr.GQuoteStatus;

typedef GStringLiteralKind  = eu.ohmrun.glot.expr.GStringLiteralKind;

typedef GTypeDefinition     = eu.ohmrun.glot.expr.GTypeDefinition;
typedef GTypeDefinitionDef  = eu.ohmrun.glot.expr.GTypeDefinition.GTypeDefinitionDef;
typedef GTypeDefinitionCtr  = eu.ohmrun.glot.expr.GTypeDefinition.GTypeDefinitionCtr;

typedef GTypeDefKind        = eu.ohmrun.glot.expr.GTypeDefKind;
typedef GTypeDefKindSum     = eu.ohmrun.glot.expr.GTypeDefKind.GTypeDefKindSum;
typedef GTypeDefKindCtr     = eu.ohmrun.glot.expr.GTypeDefKind.GTypeDefKindCtr;

typedef GTypeParam          = eu.ohmrun.glot.expr.GTypeParam;
typedef GTypeParamSum       = eu.ohmrun.glot.expr.GTypeParam.GTypeParamSum;
typedef GTypeParamCtr       = eu.ohmrun.glot.expr.GTypeParam.GTypeParamCtr;

typedef GTypeParamDecl      = eu.ohmrun.glot.expr.GTypeParamDecl;
typedef GTypeParamDeclDef   = eu.ohmrun.glot.expr.GTypeParamDecl.GTypeParamDeclDef;
typedef GTypeParamDeclCtr   = eu.ohmrun.glot.expr.GTypeParamDecl.GTypeParamDeclCtr;

typedef GTypePath           = eu.ohmrun.glot.expr.GTypePath;
typedef GTypePathDef        = eu.ohmrun.glot.expr.GTypePath.GTypePathDef;
typedef GTypePathCtr        = eu.ohmrun.glot.expr.GTypePath.GTypePathCtr;

typedef GUnop               = eu.ohmrun.glot.expr.GUnop;
typedef GUnopSum            = eu.ohmrun.glot.expr.GUnop.GUnopSum;

typedef GVar                = eu.ohmrun.glot.expr.GVar;
typedef GVarDef             = eu.ohmrun.glot.expr.GVar.GVarDef;
typedef GVarCtr             = eu.ohmrun.glot.expr.GVar.GVarCtr;

// class LiftPrimitiveToExpr(self:Primitive):GExpr{
//   final cons = GConstant.__;
//   return switch(self){
//     case PNull                        : cons.Ident('null').toGExpr();
//     case PBool(b)                     : cons.Ident(b).toExpr();
//     case PSprig(Byteal(NInt(int)))    : cons.Int(int).toGExpr();
//     case PSprig(Byteal(NInt64(int)))  :
//          __.glot().expr().Make()  
//     NFloat(f:Float);
//   }
// }

// typedef GRef<T> = {
//   public function get():T;
//   public function toString():String;
// }
// enum GType {
//   GTMono(t:GRef<Null<GType>>);
//   GTEnum(t:GRef<EnumType>, params:Array<GType>);
//   GTInst(t:GRef<GClassType>, params:Array<GType>);
//   GTType(t:GRef<GDefType>, params:Array<GType>);
//   GTFun(args:Array<{name:String, opt:Bool, t:GType}>, ret:GType);
//   GTAnonymous(a:GRef<GAnonType>);
//   GTDynamic(t:Null<GType>);
//   GTLazy(f:Void->GType);
//   GTAbstract(t:GRef<GAbstractType>, params:Array<Type>);
// }

// typedef GAnonType = {
//   var fields:Array<GClassField>;
//   var status:GAnonStatus;
// }
// enum GAnonStatus {
//   GAClosed;
//   GAOpened;
//   GAConst;
//   GAExtend(tl:GRef<Array<GType>>);
//   GAClassStatics(t:GRef<GClassType>);
//   GAEnumStatics(t:GRef<EnumType>);
//   GAAbstractStatics(t:GRef<GAbstractType>);
// }
// typedef GTypeParameter = {
//   var name:String;
//   var t:GType;
//   var ?defaultType:Null<GType>;
// }
// typedef ClassField = {
//   var name:String;
//   var type:GType;
//   var isPublic:Bool;
//   var isExtern:Bool;
//   var isFinal:Bool;
//   var isAbstract:Bool;
//   var params:Array<GTypeParameter>;
//   var meta:GMetaAccess;
//   var kind:GFieldKind;
//   var doc:Null<String>;
//   var overloads:GRef<Array<GClassField>>;
// }

// typedef GEnumField = {
//   var name:String;
//   var type:GType;
//   var index:Int;
//   var doc:Null<String>;
//   var params:Array<GTypeParameter>;
// }
// enum ClassKind {
//   GKNormal;
//   GKTypeParameter(constraints:Array<GType>);
//   GKModuleFields(module:String);
//   GKExpr(expr:Expr);
//   GKGeneric;
//   GKGenericInstance(cl:GRef<GClassType>, params:Array<GType>);
//   //GKMacroType;
//   GKAbstractImpl(a:GRef<GAbstractType>);
//   GKGenericBuild;
// }
// typedef GBaseType = {
//   var pack:Array<String>;
//   var name:String;
//   var module:String;
//   var isPrivate:Bool;
//   var isExtern:Bool;
//   var params:Array<GTypeParameter>;
//   var meta:GMetaAccess;
//   var doc:Null<String>;
//   function exclude():Void;
// }

// typedef GClassType = GBaseType & {
//   /**
//     The kind of the class.
//   **/
//   var kind:ClassKind;

//   /**
//     If true the type is an interface, otherwise it is a class.
//   **/
//   var isInterface:Bool;

//   /**
//     If true the class is final and cannot be extended.
//   **/
//   var isFinal:Bool;

//   /**
//     If true the class is abstract and cannot be instantiated directly.
//   **/
//   var isAbstract:Bool;

//   /**
//     The parent class and its type parameters, if available.
//   **/
//   var superClass:Null<{t:Ref<ClassType>, params:Array<Type>}>;

//   /**
//     The implemented interfaces and their type parameters.
//   **/
//   var interfaces:Array<{t:Ref<ClassType>, params:Array<Type>}>;

//   /**
//     The member fields of the class.
//   **/
//   var fields:Ref<Array<ClassField>>;

//   /**
//     The static fields of the class.
//   **/
//   var statics:Ref<Array<ClassField>>;

//   // var dynamic : Null<Type>;
//   // var arrayAccess : Null<Type>;

//   /**
//     The constructor of the class, if available.
//   **/
//   var constructor:Null<Ref<ClassField>>;

//   /**
//     The `__init__` expression of the class, if available.
//   **/
//   var init:Null<TypedExpr>;

//   /**
//     The list of fields that have override status.
//   **/
//   var overrides:Array<Ref<ClassField>>;
// }

// /**
//   Represents an enum type.
// */
// typedef EnumType = BaseType & {
//   /**
//     The available enum constructors.
//   **/
//   var constructs:Map<String, EnumField>;

//   /**
//     An ordered list of enum constructor names.
//   **/
//   var names:Array<String>;
// }

// /**
//   Represents a typedef.
// */
// typedef DefType = BaseType & {
//   /**
//     The target type of the typedef.
//   **/
//   var type:Type;
// }

// /**
//   Represents an abstract type.
// */
// typedef AbstractType = BaseType & {
//   /**
//     The underlying type of the abstract.
//   **/
//   var type:Type;

//   /**
//     The implementation class of the abstract, if available.
//   **/
//   var impl:Null<Ref<ClassType>>;

//   /**
//     The defined binary operators of the abstract.
//   **/
//   var binops:Array<{op:Expr.Binop, field:ClassField}>;

//   /**
//     The defined unary operators of the abstract.
//   **/
//   var unops:Array<{op:Expr.Unop, postFix:Bool, field:ClassField}>;

//   /**
//     The available implicit from-casts of the abstract.

//     @see https://haxe.org/manual/types-abstract-implicit-casts.html
//   **/
//   var from:Array<{t:Type, field:Null<ClassField>}>;

//   /**
//     The available implicit to-casts of the abstract.

//     @see https://haxe.org/manual/types-abstract-implicit-casts.html
//   **/
//   var to:Array<{t:Type, field:Null<ClassField>}>;

//   /**
//     The defined array-access fields of the abstract.
//   **/
//   var array:Array<ClassField>;

//   /**
//     The method used for resolving unknown field access, if available.
//   **/
//   var resolve:Null<ClassField>;

//   /**
//     The method used for resolving unknown field access, if available.
//   **/
//   var resolveWrite:Null<ClassField>;
// }

// /**
//   MetaAccess is a wrapper for the `Metadata` array. It can be used to add
//   metadata to and remove metadata from its origin.
// **/
// typedef MetaAccess = {
//   /**
//     Return the wrapped `Metadata` array.

//     Modifying this array has no effect on the origin of `this` MetaAccess.
//     The `add` and `remove` methods can be used for that.
//   **/
//   function get():Expr.Metadata;

//   /**
//     Extract metadata entries by given `name`.

//     If there's no metadata with such name, empty array `[]` is returned.

//     If `name` is null, compilation fails with an error.
//   **/
//   function extract(name:String):Array<Expr.MetadataEntry>;

//   /**
//     Adds the metadata specified by `name`, `params` and `pos` to the origin
//     of `this` MetaAccess.

//     Metadata names are not unique during compilation, so this method never
//     overwrites a previous metadata.

//     If a `Metadata` array is obtained through a call to `get`, a subsequent
//     call to `add` has no effect on that array.

//     If any argument is null, compilation fails with an error.
//   **/
//   function add(name:String, params:Array<Expr>, pos:Expr.Position):Void;

//   /**
//     Removes all `name` metadata entries from the origin of `this`
//     MetaAccess.

//     This method might clear several metadata entries of the same name.

//     If a `Metadata` array is obtained through a call to `get`, a subsequent
//     call to `remove` has no effect on that array.

//     If `name` is null, compilation fails with an error.
//   **/
//   function remove(name:String):Void;

//   /**
//     Tells if the origin of `this` MetaAccess has a `name` metadata entry.

//     If `name` is null, compilation fails with an error.
//   **/
//   function has(name:String):Bool;
// }

// /**
//   Represents a field kind.
// */
// enum FieldKind {
//   /**
//     A variable of property, depending on the `read` and `write` values.
//   **/
//   FVar(read:VarAccess, write:VarAccess);

//   /**
//     A method
//   **/
//   FMethod(k:MethodKind);
// }

// /**
//   Represents the variable accessor.
// */
// enum VarAccess {
//   /**
//     Normal access (`default`).
//   **/
//   AccNormal;

//   /**
//     Private access (`null`).
//   **/
//   AccNo;

//   /**
//     No access (`never`).
//   **/
//   AccNever;

//   /**
//     Unused.
//   **/
//   AccResolve;

//   /**
//     Access through accessor function (`get`, `set`, `dynamic`).
//   **/
//   AccCall;

//   /**
//     Inline access (`inline`).
//   **/
//   AccInline;

//   /**
//     Failed access due to a `@:require` metadata.
//   **/
//   AccRequire(r:String, ?msg:String);

//   /**
//     Access is only allowed from the constructor.
//   **/
//   AccCtor;
// }

// /**
//   Represents the method kind.
// */
// enum MethodKind {
//   /**
//     A normal method.
//   **/
//   MethNormal;

//   /**
//     An inline method.

//     @see https://haxe.org/manual/class-field-inline.html
//   **/
//   MethInline;

//   /**
//     A dynamic, rebindable method.

//     @see https://haxe.org/manual/class-field-dynamic.html
//   **/
//   MethDynamic;

//   /**
//     A macro method.
//   **/
//   MethMacro;
// }

// /**
//   Represents typed constant.
// */
// enum TConstant {
//   /**
//     An `Int` literal.
//   **/
//   TInt(i:Int);

//   /**
//     A `Float` literal, represented as String to avoid precision loss.
//   **/
//   TFloat(s:String);

//   /**
//     A `String` literal.
//   **/
//   TString(s:String);

//   /**
//     A `Bool` literal.
//   **/
//   TBool(b:Bool);

//   /**
//     The constant `null`.
//   **/
//   TNull;

//   /**
//     The constant `this`.
//   **/
//   TThis;

//   /**
//     The constant `super`.
//   **/
//   TSuper;
// }

// /**
//   Represents a variable in the typed AST.
// */
// typedef TVar = {
//   /**
//     The unique ID of the variable.
//   **/
//   public var id(default, never):Int;

//   /**
//     The name of the variable.
//   **/
//   public var name(default, never):String;

//   /**
//     The type of the variable.
//   **/
//   public var t(default, never):Type;

//   /**
//     Whether or not the variable has been captured by a closure.
//   **/
//   public var capture(default, never):Bool;

//   /**
//     Special information which is internally used to keep track of closure.
//     information
//   **/
//   public var extra(default, never):Null<{params:Array<TypeParameter>, expr:Null<TypedExpr>}>;

//   /**
//     The metadata of the variable.
//   **/
//   public var meta(default, never):Null<MetaAccess>;
// }

// /**
//   Represents a module type. These are the types that can be declared in a Haxe
//   module and which are passed to the generators (except `TTypeDecl`).
// */
// enum ModuleType {
//   /**
//     A class.
//   **/
//   TClassDecl(c:Ref<ClassType>);

//   /**
//     An enum.
//   **/
//   TEnumDecl(e:Ref<EnumType>);

//   /**
//     A typedef.
//   **/
//   TTypeDecl(t:Ref<DefType>);

//   /**
//     An abstract.
//   **/
//   TAbstract(a:Ref<AbstractType>);
// }

// /**
//   Represents a function in the typed AST.
// */
// typedef TFunc = {
//   /**
//     A list of function arguments identified by an argument variable `v` and
//     an optional initialization `value`.
//   **/
//   var args:Array<{v:TVar, value:Null<TypedExpr>}>;

//   /**
//     The return type of the function.
//   **/
//   var t:Type;

//   /**
//     The expression of the function body.
//   **/
//   var expr:TypedExpr;
// }

// /**
//   Represents the kind of field access in the typed AST.
// */
// enum FieldAccess {
//   /**
//     Access of field `cf` on a class instance `c` with type parameters
//     `params`.
//   **/
//   FInstance(c:Ref<ClassType>, params:Array<Type>, cf:Ref<ClassField>);

//   /**
//     Static access of a field `cf` on a class `c`.
//   **/
//   FStatic(c:Ref<ClassType>, cf:Ref<ClassField>);

//   /**
//     Access of field `cf` on an anonymous structure.
//   **/
//   FAnon(cf:Ref<ClassField>);

//   /**
//     Dynamic field access of a field named `s`.
//   **/
//   FDynamic(s:String);

//   /**
//     Closure field access of field `cf` on a class instance `c` with type
//     parameters `params`.
//   **/
//   FClosure(c:Null<{c:Ref<ClassType>, params:Array<Type>}>, cf:Ref<ClassField>);

//   /**
//     Field access to an enum constructor `ef` of enum `e`.
//   **/
//   FEnum(e:Ref<EnumType>, ef:EnumField);
// }

// /**
//   Represents kind of a node in the typed AST.
// */
// enum TypedExprDef {
//   /**
//     A constant.
//   **/
//   TConst(c:TConstant);

//   /**
//     Reference to a local variable `v`.
//   **/
//   TLocal(v:TVar);

//   /**
//     Array access `e1[e2]`.
//   **/
//   TArray(e1:TypedExpr, e2:TypedExpr);

//   /**
//     Binary operator `e1 op e2`.
//   **/
//   TBinop(op:Expr.Binop, e1:TypedExpr, e2:TypedExpr);

//   /**
//     Field access on `e` according to `fa`.
//   **/
//   TField(e:TypedExpr, fa:FieldAccess);

//   /**
//     Reference to a module type `m`.
//   **/
//   TTypeExpr(m:ModuleType);

//   /**
//     Parentheses `(e)`.
//   **/
//   TParenthesis(e:TypedExpr);

//   /**
//     An object declaration.
//   **/
//   TObjectDecl(fields:Array<{name:String, expr:TypedExpr}>);

//   /**
//     An array declaration `[el]`.
//   **/
//   TArrayDecl(el:Array<TypedExpr>);

//   /**
//     A call `e(el)`.
//   **/
//   TCall(e:TypedExpr, el:Array<TypedExpr>);

//   /**
//     A constructor call `new c<params>(el)`.
//   **/
//   TNew(c:Ref<ClassType>, params:Array<Type>, el:Array<TypedExpr>);

//   /**
//     An unary operator `op` on `e`:

//     * e++ (op = OpIncrement, postFix = true)
//     * e-- (op = OpDecrement, postFix = true)
//     * ++e (op = OpIncrement, postFix = false)
//     * --e (op = OpDecrement, postFix = false)
//     * -e (op = OpNeg, postFix = false)
//     * !e (op = OpNot, postFix = false)
//     * ~e (op = OpNegBits, postFix = false)
//   **/
//   TUnop(op:Expr.Unop, postFix:Bool, e:TypedExpr);

//   /**
//     A function declaration.
//   **/
//   TFunction(tfunc:TFunc);

//   /**
//     A variable declaration `var v` or `var v = expr`.
//   **/
//   TVar(v:TVar, expr:Null<TypedExpr>);

//   /**
//     A block declaration `{el}`.
//   **/
//   TBlock(el:Array<TypedExpr>);

//   /**
//     A `for` expression.
//   **/
//   TFor(v:TVar, e1:TypedExpr, e2:TypedExpr);

//   /**
//     An `if(econd) eif` or `if(econd) eif else eelse` expression.
//   **/
//   TIf(econd:TypedExpr, eif:TypedExpr, eelse:Null<TypedExpr>);

//   /**
//     Represents a `while` expression.
//     When `normalWhile` is `true` it is `while (...)`.
//     When `normalWhile` is `false` it is `do {...} while (...)`.
//   **/
//   TWhile(econd:TypedExpr, e:TypedExpr, normalWhile:Bool);

//   /**
//     Represents a `switch` expression with related cases and an optional
//     `default` case if edef != null.
//   **/
//   TSwitch(e:TypedExpr, cases:Array<{values:Array<TypedExpr>, expr:TypedExpr}>, edef:Null<TypedExpr>);

//   /**
//     Represents a `try`-expression with related catches.
//   **/
//   TTry(e:TypedExpr, catches:Array<{v:TVar, expr:TypedExpr}>);

//   /**
//     A `return` or `return e` expression.
//   **/
//   TReturn(e:Null<TypedExpr>);

//   /**
//     A `break` expression.
//   **/
//   TBreak;

//   /**
//     A `continue` expression.
//   **/
//   TContinue;

//   /**
//     A `throw e` expression.
//   **/
//   TThrow(e:TypedExpr);

//   /**
//     A `cast e` or `cast (e, m)` expression.
//   **/
//   TCast(e:TypedExpr, m:Null<ModuleType>);

//   /**
//     A `@m e1` expression.
//   **/
//   TMeta(m:Expr.MetadataEntry, e1:TypedExpr);

//   /**
//     Access to an enum parameter (generated by the pattern matcher).
//   **/
//   TEnumParameter(e1:TypedExpr, ef:EnumField, index:Int);

//   /**
//     Access to an enum index (generated by the pattern matcher).
//   **/
//   TEnumIndex(e1:TypedExpr);

//   /**
//     An unknown identifier.
//   **/
//   TIdent(s:String);
// }

// /**
//   Represents a typed AST node.
// */
// typedef TypedExpr = {
//   /**
//     The expression kind.
//   **/
//   var expr:TypedExprDef;

//   /**
//     The position of the expression.
//   **/
//   var pos:Expr.Position;

//   /**
//     The type of the expression.
//   **/
//   var t:Type;
// }
