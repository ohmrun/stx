package stx.makro.expr.type;

final Expr = __.makro().expr;

class EnumType extends Clazz{
  @:noUsing static public function getSimpleBinaryCases(e0,e1,uses:HTFunArgArray->HTFunArgArray->Option<HExpr>,pos){
    function prep(str:String,p:HTFunArg):HTFunArg return  { name : '${str}${p.name}', opt : p.opt, t : p.t };
    
    return getBinaryCases(
      e0,e1,
      function(lc:HEnumValueConstructor,rc:HEnumValueConstructor){
        var lhs = Expr.HExprdef.Call(
          LiftMethodRefToHExpr.toHExpr(lc.ref,pos),
          lc.args
          .map(prep.bind("l"))
          .map(
            (tfa) -> LiftConstantToHExpr.toHExpr(Constant.CIdent(tfa.name))
          )
        ).to_macro_at(pos);
        var rhs = Expr.HExprdef.Call(
          LiftHExpr.MethodRef.toHExpr(rc.ref,pos),
          rc.args
          .map(prep.bind("r"))
          .map(
            (tfa) -> LiftConstantToHExpr.toHExpr(Constant.CIdent(tfa.name))
          )
        ).to_macro_at(pos);

        return uses(lc.args,rc.args).map(
          function (e):Case return { values : [lhs.toExpr(),rhs.toExpr()],  expr : e.toExpr() }
        ).map(v->[v]).def(()->[]);
      },
      pos 
    );
  }
  @:noUsing static public function getBinaryCases(e0,e1,gen:HEnumValueConstructor->HEnumValueConstructor->Array<Case>,pos){
    var lparams = HEnumType._.getConstructors(e0);
    var rparams = HEnumType._.getConstructors(e1);
    var e0id    = HEnumType._.getMoniker(e0);
    var e1id    = HEnumType._.getMoniker(e1);

    var consl = lparams.toIter().map(
      (tp) -> HEnumValueConstructor.make(e0,e0id.call(tp.fst()),tp.snd())
    );
    var consr = rparams.toIter().map(
      (tp) -> HEnumValueConstructor.make(e0,e1id.call(tp.fst()),tp.snd())
    );

    var next = consl.map(
      (l) -> consr.map(
        (r) -> gen(l,r)
      )
    ).fold(
      (next,memo) -> next.fold(
        (next0,memo1:Array<Case>) -> memo1.concat(next0),
        memo
      ),
      []
    );
    Expr.HExprdef.Switch(
      Expr.HExprdef.ArrayDecl([HExpr.mark(pos),HExpr.mark(pos)]).to_macro_at(pos),
      next.prj(),
      HExpr.make(null,pos)
    ).to_macro_at(pos);
  }
  @:noUsing static public function getSwitch(e:HEnumType,gen:Unary<HEnumValueConstructor,Array<Case>>,pos):HExpr{
    var cons  = HEnumType._.getConstructors(e);    
    var cases = cons.toIter().map(Field.fromCouple).map(
          (c:Field<HTFunArgArray>) -> HEnumValueConstructor.make(e,HEnumType._.getMoniker(e).call(c.key),c.val)
        ).map(gen).fold(
          (next,memo:Array<Case>) ->  memo.concat(next),
          []
        );
    return Expr.HExprdef.Switch(
      HExpr.mark(pos),
      cases,
      HExpr.make(null,pos)
    ).to_macro_at(pos);
  }
  @:noUsing static public function getSimpleSwitch(e:StdEnumType,gen:HTFunArgArray->Option<HExpr>,pos):HExpr{
    return getSwitch(e,
      function(cons){
        var args = HExprArray.lift(cons.args.map(
          (tfp) -> {
            return LiftConstantToHExpr.toHExpr(Constant.CIdent(tfp.name));
          }
        ));
        trace(cons.ref);
        var call = Expr.HExprdef.Call(
          LiftHExpr.MethodRef.toHExpr(cons.ref,pos),
          args
        ).to_macro_at(pos);
        trace(call.show());

        var expr = gen(cons.args);

        return expr.map(
          function(case_expr):Case{
            return {
              values : [call.toExpr()],
              expr   : case_expr.toExpr()
            }
          }
        ).map((c) -> [c]).def(() -> []);
      }
    ,pos
    );
  }
  /**
   * Creates a switch for EnumType e, use the names of the HTFunArgArray to access the variables from HExpr
   * ref will be the $x in
   *  switch($x)...
   * HExpr will be the $expr in 
   *  case SomeEnumValue(a,b) : $expr
   * @param e 
   * @param handler 
   * @return StringMap<U>
   */
  @:noUsing static public function switcher<U>(e:StdEnumType,handler:Array<HTFunArg>->HExpr,pos,def):HExpr->HExpr{
    var each = HEnumType._.constructorHandler(e,
      handler.fn().split((x)->x)
    );
    var next = [];
    for(key => val in each){
      var case_call_source = val.snd();
      var case_call : HExprArray = HExprArray.lift(case_call_source.map(
        (v:HTFunArg) -> Moniker.make(v.name,[],None).toHExpr(pos)
      ));
      var head  = LiftMonikerToHExpr.toHExpr(Moniker.make(key,[],None),pos);
      var value = !case_call.is_defined() ? head : Expr.HExprdef.Call(head,case_call).to_macro_at(pos);
      var case_ : Case = {
        expr    : val.fst().toExpr(),
        values  : [value.toExpr()]
      }
      next.push(case_);
    }
    return (ref) -> Expr.HExprdef.Switch(
        ref,next,def
      ).to_macro_at(pos);
  }
}