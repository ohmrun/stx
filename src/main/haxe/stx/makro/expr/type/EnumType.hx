package stx.makro.expr.type;

class EnumType{
  @:noUsing static public function getSimpleBinaryCases(e0,e1,uses:HTFunArgCluster->HTFunArgCluster->Option<HExpr>,pos){
    function prep(str:String,p:TFunParam):TFunParam return  { name : '${str}${p.name}', opt : p.opt, t : p.t };
    
    return getBinaryCases(
      e0,e1,
      function(lc:HEnumValueConstructor,rc:HEnumValueConstructor){
        var lhs = HExprDef.ECall(
          LiftMethodRefToHExpr.toHExpr(lc.ref,pos),
          lc.args
          .map(prep.bind("l"))
          .map(
            (tfa) -> LiftConstantToHExpr.toHExpr(Constant.CIdent(tfa.name))
          )
        ).to_macro_at(pos);
        var rhs = HExprDef.ECall(
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
    var lparams = getConstructors(e0);
    var rparams = getConstructors(e1);
    var e0id    = getModule(e0);
    var e1id    = getModule(e1);

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
    HExprDef.ESwitch(
      HExprDef.EArrayDecl([HExpr.mark(pos),HExpr.mark(pos)]).to_macro_at(pos),
      next.prj(),
      HExpr.unit(pos)
    ).to_macro_at(pos);
  }
  @:noUsing static public function getSwitch(e:EnumType,gen:Unary<HEnumValueConstructor,Array<Case>>,pos):HExpr{
    var cons  = getConstructors(e);    
    var cases = cons.toIter().map(Field.fromCouple).map(
          (c:Field<TFunParamArray>) -> EnumValueConstructor.make(e,getModule(e).call(c.key),c.val)
        ).map(gen).fold(
          (next,memo:Array<Case>) ->  memo.concat(next),
          []
        );
    return HExprDef.ESwitch(
      HExpr.mark(pos),
      cases,
      HExpr.unit(pos)
    ).to_macro_at(pos);
  }
  @:noUsing static public function getSimpleSwitch(e:EnumType,gen:HTFunArgCluster->Option<HExpr>,pos):HExpr{
    return getSwitch(e,
      function(cons){
        var args = HExprCluster.lift(cons.args.map(
          (tfp) -> {
            return LiftConstantToHExpr.toHExpr(Constant.CIdent(tfp.name));
          }
        ));
        trace(cons.ref);
        var call = HExprDef.ECall(
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
   * Creates a switch for EnumType e, use the names of the TFunParamArray to access the variables from HExpr
   * ref will be the $x in
   *  switch($x)...
   * HExpr will be the $expr in 
   *  case SomeEnumValue(a,b) : $expr
   * @param e 
   * @param handler 
   * @return StringMap<U>
   */
  @:noUsing static public function switcher<U>(e:EnumType,handler:Array<HTFunArg>->HExpr,pos,def):HExpr->HExpr{
    var each = constructorHandler(e,
      handler.fn().split((x)->x)
    );
    var next = [];
    for(key => val in each){
      var case_call_source = val.snd();
      var case_call : HExprCluster = case_call_source.map(
        (v:TFunArg) -> LiftMakro.toModule(v.name).map(x -> LiftModuleToHExpr.toHExpr(x,pos)).force()
      );
      var head  = LiftModuleToHExpr.toHExpr(LiftMakro.toModule(key).force(),pos);
      var value = !case_call.is_defined() ? head : HExprDef.ECall(head,case_call).to_macro_at(pos);
      var case_ : Case = {
        expr    : val.fst().toExpr(),
        values  : [value.toExpr()]
      }
      next.push(case_);
    }
    return (ref) -> HExprDef.ESwitch(
        ref,next,def
      ).to_macro_at(pos);
  }
}