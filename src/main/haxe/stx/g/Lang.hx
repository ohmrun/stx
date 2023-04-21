package stx.g;

class Lang{
  static public function g(wildcard:Wildcard){
    return new stx.g.lang.Module();  
  }
}

typedef GFailure            = stx.fail.GFailure;
typedef GSource             = stx.g.lang.GSource;


typedef GAccess             = stx.g.lang.expr.GAccess;
typedef GAccessSum          = stx.g.lang.expr.GAccess.GAccessSum;
typedef GAccessCtr          = stx.g.lang.expr.GAccess.GAccessCtr;

typedef GBinop              = stx.g.lang.expr.GBinop;
typedef GBinopSum           = stx.g.lang.expr.GBinop.GBinopSum;

typedef GCase               = stx.g.lang.expr.GCase;
typedef GCaseDef            = stx.g.lang.expr.GCase.GCaseDef;
typedef GCaseCtr            = stx.g.lang.expr.GCase.GCaseCtr;

typedef GCatch              = stx.g.lang.expr.GCatch;
typedef GCatchDef           = stx.g.lang.expr.GCatch.GCatchDef;
typedef GCatchCtr           = stx.g.lang.expr.GCatch.GCatchCtr;


typedef GComplexType        = stx.g.lang.expr.GComplexType;
typedef GComplexTypeSum     = stx.g.lang.expr.GComplexType.GComplexTypeSum;
typedef GComplexTypeCtr     = stx.g.lang.expr.GComplexType.GComplexTypeCtr;

typedef GConstant           = stx.g.lang.expr.GConstant;
typedef GConstantSum        = stx.g.lang.expr.GConstant.GConstantSum;
typedef GConstantCtr        = stx.g.lang.expr.GConstant.GConstantCtr;

typedef GExpr               = stx.g.lang.expr.GExpr;
typedef GExprSum            = stx.g.lang.expr.GExpr.GExprSum;
typedef GExprCtr            = stx.g.lang.expr.GExpr.GExprCtr;

typedef GField              = stx.g.lang.expr.GField;
typedef GFieldDef           = stx.g.lang.expr.GField.GFieldDef;
typedef GFieldCtr           = stx.g.lang.expr.GField.GFieldCtr;


#if (hax_ver > 4.205)
typedef GEFieldKind          = stx.g.lang.expr.GEFieldKind;
#end

typedef GFieldType          = stx.g.lang.expr.GFieldType;
typedef GFieldTypeSum       = stx.g.lang.expr.GFieldType.GFieldTypeSum;
typedef GFieldTypeCtr       = stx.g.lang.expr.GFieldType.GFieldTypeCtr;

typedef GFunction           = stx.g.lang.expr.GFunction;
typedef GFunctionDef        = stx.g.lang.expr.GFunction.GFunctionDef;
typedef GFunctionCtr        = stx.g.lang.expr.GFunction.GFunctionCtr;

typedef GFunctionKind       = stx.g.lang.expr.GFunctionKind;

typedef GFunctionArg        = stx.g.lang.expr.GFunctionArg;
typedef GFunctionArgDef     = stx.g.lang.expr.GFunctionArg.GFunctionArgDef;
typedef GFunctionArgCtr     = stx.g.lang.expr.GFunctionArg.GFunctionArgCtr;

typedef GMetadata           = stx.g.lang.expr.GMetadata;

typedef GMetadataEntry      = stx.g.lang.expr.GMetadataEntry;
typedef GMetadataEntryDef   = stx.g.lang.expr.GMetadataEntry.GMetadataEntryDef;
typedef GMetadataEntryCtr   = stx.g.lang.expr.GMetadataEntry.GMetadataEntryCtr;

typedef GObjectField        = stx.g.lang.expr.GObjectField;
typedef GObjectFieldDef     = stx.g.lang.expr.GObjectField.GObjectFieldDef;
typedef GObjectFieldCtr     = stx.g.lang.expr.GObjectField.GObjectFieldCtr;

typedef GPropAccess         = stx.g.lang.expr.GPropAccess;
typedef GPropAccessSum      = stx.g.lang.expr.GPropAccess.GPropAccessSum;
typedef GPropAccessCtr      = stx.g.lang.expr.GPropAccess.GPropAccessCtr;

typedef GQuoteStatus        = stx.g.lang.expr.GQuoteStatus;

typedef GStringLiteralKind  = stx.g.lang.expr.GStringLiteralKind;

typedef GTypeDefinition     = stx.g.lang.expr.GTypeDefinition;
typedef GTypeDefinitionDef  = stx.g.lang.expr.GTypeDefinition.GTypeDefinitionDef;
typedef GTypeDefinitionCtr  = stx.g.lang.expr.GTypeDefinition.GTypeDefinitionCtr;

typedef GTypeDefKind        = stx.g.lang.expr.GTypeDefKind;
typedef GTypeDefKindSum     = stx.g.lang.expr.GTypeDefKind.GTypeDefKindSum;
typedef GTypeDefKindCtr     = stx.g.lang.expr.GTypeDefKind.GTypeDefKindCtr;

typedef GTypeParam          = stx.g.lang.expr.GTypeParam;
typedef GTypeParamSum       = stx.g.lang.expr.GTypeParam.GTypeParamSum;
typedef GTypeParamCtr       = stx.g.lang.expr.GTypeParam.GTypeParamCtr;

typedef GTypeParamDecl      = stx.g.lang.expr.GTypeParamDecl;
typedef GTypeParamDeclDef   = stx.g.lang.expr.GTypeParamDecl.GTypeParamDeclDef;
typedef GTypeParamDeclCtr   = stx.g.lang.expr.GTypeParamDecl.GTypeParamDeclCtr;

typedef GTypePath           = stx.g.lang.expr.GTypePath;
typedef GTypePathDef        = stx.g.lang.expr.GTypePath.GTypePathDef;
typedef GTypePathCtr        = stx.g.lang.expr.GTypePath.GTypePathCtr;

typedef GUnop               = stx.g.lang.expr.GUnop;
typedef GUnopSum            = stx.g.lang.expr.GUnop.GUnopSum;

typedef GVar                = stx.g.lang.expr.GVar;
typedef GVarDef             = stx.g.lang.expr.GVar.GVarDef;
typedef GVarCtr             = stx.g.lang.expr.GVar.GVarCtr;

// class LiftPrimitiveToExpr(self:Primitive):GExpr{
//   final cons = GConstant.__;
//   return switch(self){
//     case PNull                        : cons.Ident('null').toGExpr();
//     case PBool(b)                     : cons.Ident(b).toExpr();
//     case PSprig(Byteal(NInt(int)))    : cons.Int(int).toGExpr();
//     case PSprig(Byteal(NInt64(int)))  :
//          __.g().expr().Make()  
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
