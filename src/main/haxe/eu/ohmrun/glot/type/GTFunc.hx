package eu.ohmrun.glot.type;


typedef GTFunc = {
    var args:Cluster<{v:GTVar, value:Null<GTypedExpr>}>;
    var t:GType;
    var expr:GTypedExpr;
  }