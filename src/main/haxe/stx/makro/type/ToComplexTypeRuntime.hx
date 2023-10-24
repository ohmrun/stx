package stx.makro.type;

/**
 * haxe.macro.TypeTools.toComplexType switches to an interpreter implementation in macro context and currently 
 * chokes with built values. Haxe 4.3.1
 */
class ToComplexTypeRuntime{
  static public function apply(type:HType){
    return toComplexType(type);
  }
  static function toField(cf:ClassField):haxe.macro.Expr.Field
		return {
			function varAccessToString(va:VarAccess, getOrSet:String):String
				return {
					switch (va) {
						case AccNormal | AccCtor: "default";
						case AccNo: "null";
						case AccNever: "never";
						case AccResolve: throw "Invalid TAnonymous";
						case AccCall: getOrSet;
						case AccInline: "default";
						case AccRequire(_, _): "default";
					}
				}
			var access = cf.isPublic ? [APublic] : [APrivate];
			if (cf.meta.has(":final")) {
				access.push(AFinal);
			}
			if (cf.params.length == 0)
				{
					name: cf.name,
					doc: cf.doc,
					access: access,
					kind: switch ([cf.kind, cf.type]) {
						case [FVar(read, write), ret]:
							FProp(varAccessToString(read, "get"), varAccessToString(write, "set"), toComplexType(ret), null);
						case [FMethod(_), TFun(args, ret)]:
							FFun({
								args: [
									for (a in args)
										{
											name: a.name,
											opt: a.opt,
											type: toComplexType(a.t),
										}
								],
								ret: toComplexType(ret),
								expr: null,
							});
						default:
							throw "Invalid TAnonymous";
					},
					pos: cf.pos,
					meta: cf.meta.get(),
				} else {
					throw "Invalid TAnonymous";
			}
		}

	/**
		Returns a syntax-level type corresponding to Type `t`.

		This function is mostly inverse to `ComplexTypeTools.toType`, but may
		lose some information on types that do not have a corresponding syntax
		version, such as monomorphs. In these cases, the result is null.

		If `t` is null, an internal exception is thrown.
	**/
	public static function toComplexType(type:Null<Type>):Null<ComplexType>
		return {
			switch (type) {
				case null:
					null;
				case TMono(_.get() => t):
					t == null ? null : toComplexType(t);
				case TEnum(_.get() => baseType, params):
					TPath(toTypePath(baseType, params));
				case TInst(_.get() => classType, params):
					switch (classType.kind) {
						case KTypeParameter(_):
							TPath({
								name: classType.name,
								pack: [],
							});
						default:
							TPath(toTypePath(classType, params));
					}
				case TType(_.get() => baseType, params):
					TPath(toTypePath(baseType, params));
				case TFun(args, ret):
					TFunction([for (a in args) a.opt ? nullable(toComplexType(a.t)) : toComplexType(a.t)], toComplexType(ret));
				case TAnonymous(_.get() => {fields: fields}):
					TAnonymous([for (cf in fields) toField(cf)]);
				case TDynamic(t):
					if (t == null) {
						macro:Dynamic;
					} else {
						var ct = toComplexType(t);
						macro:Dynamic<$ct>;
					}
				case TLazy(f):
					toComplexType(f());
				case TAbstract(_.get() => baseType, params):
					TPath(toTypePath(baseType, params));
				default:
					throw "Invalid type";
			}
    }
  static function toTypeParam(type:Type):TypeParam
    return {
      switch (type) {
        case TInst(_.get() => {kind: KExpr(e)}, _): TPExpr(e);
        case _: TPType(toComplexType(type));
      }
    }

  static function toTypePath(baseType:BaseType, params:Array<Type>):TypePath
    return {
      var module = baseType.module;
      {
        pack: baseType.pack,
        name: module.substring(module.lastIndexOf(".") + 1),
        sub: baseType.name,
        params: [for (t in params) toTypeParam(t)],
      }
    }
  static function nullable(complexType:ComplexType):ComplexType
    return macro:Null<$complexType>;
}