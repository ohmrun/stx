package eu.ohmrun.glot.type;

enum GTypedExprdef {
	GTConst(c:TConstant);
	GTLocal(v:GTVar);
	GTArray(e1:GTypedExpr, e2:GTypedExpr);
	GTBinop(op:GBinop, e1:GTypedExpr, e2:GTypedExpr);
	GTField(e:GTypedExpr, fa:GFieldAccess);
	GTTypeExpr(m:GModuleType);
	GTParenthesis(e:GTypedExpr);
	GTObjectDecl(fields:Cluster<{name:String, expr:GTypedExpr}>);
	GTArrayDecl(el:Cluster<GTypedExpr>);
	GTCall(e:GTypedExpr, el:Cluster<GTypedExpr>);
	GTNew(c:GRef<GClassType>, params:Cluster<GType>, el:Cluster<GTypedExpr>);
	GTUnop(op:GUnop, postFix:Bool, e:GTypedExpr);
	GTFunction(tfunc:GTFunc);
	GTVar(v:GTVar, expr:Null<GTypedExpr>);
	GTBlock(el:Cluster<GTypedExpr>);
	GTFor(v:GTVar, e1:GTypedExpr, e2:GTypedExpr);
	GTIf(econd:GTypedExpr, eif:GTypedExpr, eelse:Null<GTypedExpr>);
	GTWhile(econd:GTypedExpr, e:GTypedExpr, normalWhile:Bool);
	GTSwitch(e:GTypedExpr, cases:Cluster<{values:Cluster<GTypedExpr>, expr:GTypedExpr}>, edef:Null<GTypedExpr>);
	GTTry(e:GTypedExpr, catches:Cluster<{v:GTVar, expr:GTypedExpr}>);
	GTReturn(e:Null<GTypedExpr>);
	GTBreak;
	GTContinue;
	GTThrow(e:GTypedExpr);
	GTCast(e:GTypedExpr, m:Null<GModuleType>);
	GTMeta(m:GMetadataEntry, e1:GTypedExpr);
	GTEnumParameter(e1:GTypedExpr, ef:GEnumField, index:Int);
	GTEnumIndex(e1:GTypedExpr);
	GTIdent(s:String);
}
