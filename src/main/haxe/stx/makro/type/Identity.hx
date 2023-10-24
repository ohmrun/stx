package stx.makro.type;

enum IdentitySum {
	TAwkward;
	TLambda(args:Array<Field<Identity>>,ret:Identity);
	TAnon(arr:Array<Field<Identity>>);
	TParametrised(t:Identity, params:Array<Identity>);
	TIdentity(ident:Moniker);
	TComposed(first:Identity, other:Identity);
}

@:using(stx.makro.type.Identity.IdentityLift)
abstract Identity(IdentitySum) from IdentitySum to IdentitySum{
	static public var _(default,never) = IdentityLift;
  public function new(self:IdentitySum) this = self;

  public function is_anonymous(){
    return switch(this){
      case TLambda(_,_), TAnon(_) : true;
      default : false;
    }
  }
}
class IdentityLift{
  // static public function monoid():Monoid<Identity> {
	// 	return {
	// 		unit: function() return TAwkward,
	// 		plus: function(l, r) return TComposed(l, r)
	// 	}
	// }
	static public function toUniquePath(v:Identity):String{
		var f = toUniquePath;
		return switch(v){
			case TAwkward: "Awkward";
			case TLambda(args,ret): 
				var id 		= toString(v);
				var name 	= stx.Makro.anons.get(id);
				'Func_$name';
			case TAnon(arr):
				var id 		= toString(v);
				var name 	= stx.Makro.anons.get(id);
				'Anon_$name';
			case TParametrised(id,rst):
				var ags = rst.map(f).join("_");
				'${f(id)}_$ags';
			case TIdentity(id):
				stx.makro.type.core.Moniker._.to_name(id);
			case TComposed(first,other):
				'${f(first)}_${f(other)}';
				
		}
	}
	static var dlm : String = "__X__";
  static public function toString(v:Identity):String {
		return switch (v) {
			case TAwkward:
				"?";
      case TLambda(args, ret):
        var nxt = args.map(
          (kv) -> '${kv.key}:${toString(kv.val)}'
        ).join(",");
        var lst = toString(ret);
				'function(${nxt}):$lst';
			case TAnon(arr):
        var nxt = arr.map(
          (kv) -> '${kv.key}:${toString(kv.val)}'
        );
				'{${nxt.join(",")}}';
			case TParametrised(t, params):
				'${toString(t)}<${params.map(toString).join(',')}>';
			case TIdentity(ident):
				stx.makro.type.core.Moniker._.canonical(ident);
			case TComposed(first, other):
				'${toString(first)}${toString(other)}';
		}
	}
	static public function toRuntimeString(v:Identity):Option<String>{
		return switch (v) {
			case TAwkward							: None;
			case TLambda(_,_)					: None;
			case TAnon(_)							: None;
			case TParametrised(t,_)		: Some('$t');
			case TIdentity(id)				: Some('$id');
			case TComposed(fst,_)			: toRuntimeString(fst);
		}
	}
	static public function getTypeIdentity(type:HType):Identity{
		var f = getTypeIdentity;
		final base = switch(type){
			case TInst(t,[]):
				type.getMoniker().map(TIdentity).defv(TAwkward);	
			case TInst(t, arr):
				type.getMoniker().map(
					TIdentity.fn().then(TParametrised.bind(_,arr.map(f))).prj()
				).defv(TAwkward);
			case TAbstract(t, []):
				var abs = t.get();
				if (type == abs.type) {
					type.getMoniker().map(TIdentity).defv(TAwkward);
				} else {
					type.getMoniker().map(
						TIdentity.fn().then(TComposed.bind(_,f(abs.type))).prj()
					).defv(TAwkward);
				}
			case TAbstract(t, arr):
				var abs = t.get();
				if (type == abs.type) {
					type.getMoniker().map(
						TIdentity.fn().then(TParametrised.bind(_,arr.map(f))).prj()
					).defv(TAwkward);
				} else {
					type.getMoniker().map(
						TIdentity.fn().then(
							TComposed.bind(_,f(abs.type))
						).then(
							TParametrised.bind(_,arr.map(f))
						).prj()
					).defv(TAwkward);
				}
			case TEnum(t, []):
				type.getMoniker().map(TIdentity).defv(TAwkward);
			case TEnum(t, arr):
				type.getMoniker().map(
					TIdentity.fn().then(TParametrised.bind(_,arr.map(f))).prj()
				).defv(TAwkward);
			case TFun(args, ret):
				var arr : Array<Field<Identity>> = 
					args
					.map(
						function (arg):Field<Identity>{
							return Field.make(arg.name,f(arg.t));
						}
					);
				TLambda(
					arr, 
					f(ret)
				);
			case TAnonymous(t):
				var o = t.get();
				TAnon(o.fields.map((cf) -> Field.fromCouple(__.couple(cf.name, f(cf.type))) ));
			case TDynamic(null):
				throw E_MakroType_TDynamicNull;
			case TDynamic(v):
				f(v);
			case TLazy(fn):
				f(fn());
			case TMono(t):
				switch (t.get()) {
					case null:
						TAwkward;//TODO is this right?
					case a: f(a);
				}
			case TType(t, []):
				type.getMoniker().map(TIdentity).defv(TAwkward);
			case TType(t, arr):
				type.getMoniker().map(
					TIdentity.fn().then(TParametrised.bind(_,arr.map(f)))
				).defv(TAwkward);
		}
		//final rest = self.g
		return base;
	}

	static public function getMonikerIdentity(t:ModuleType):Identity{
		return TIdentity(HBaseType._.getMoniker(HModuleType._.getBaseType(t)));
  }
}