package eu.ohmrun;

using stx.Nano;

class Halva{
  static public function halva(wildcard:Wildcard){
    return new eu.ohmrun.halva.Module();
  }
}
typedef HalvaFailure 			              = stx.fail.HalvaFailure;
typedef HalvaFailureSum 	              = stx.fail.HalvaFailure.HalvaFailureSum;

// typedef Account<T> 			                = eu.ohmrun.halva.Account<T>;
// typedef AccountCtr<T> 			            = eu.ohmrun.halva.Account.AccountCtr<T>;
// typedef AccountDef<T> 	                = eu.ohmrun.halva.Account.AccountDef<T>;

typedef Accretion<T> 			              = eu.ohmrun.halva.Accretion<T>;
typedef AccretionApi<T> 	              = eu.ohmrun.halva.Accretion.AccretionApi<T>;
typedef AccretionCls<T> 	              = eu.ohmrun.halva.Accretion.AccretionCls<T>;

// typedef Journal<T> 			                = eu.ohmrun.halva.Journal<T>;
// typedef JournalSum<T> 	                = eu.ohmrun.halva.Journal.JournalSum<T>;
// typedef JournalCtr<T> 	                = eu.ohmrun.halva.Journal.JournalCtr<T>;


// typedef Storage<T> 			                = eu.ohmrun.halva.Storage<T>;
// typedef StorageDef<T> 	                = eu.ohmrun.halva.Storage.StorageDef<T>;

// typedef Item<T> 			                = eu.ohmrun.halva.lvar.Item<T>;
// typedef ItemSum<T> 	                = eu.ohmrun.halva.lvar.Item.ItemSum<T>;

// typedef EvaluationState 			        = eu.ohmrun.halva.EvaluationState;
// typedef EvaluationStateSum 	        = eu.ohmrun.halva.EvaluationState.EvaluationStateSum;

// typedef EvaluationContext 			      = eu.ohmrun.halva.EvaluationContext;
// typedef EvaluationContextDef 	      = eu.ohmrun.halva.EvaluationContext.EvaluationContextDef;

typedef LVarSum<T>                      = eu.ohmrun.halva.LVar.LVarSum<T>;
typedef LVar<T>                         = eu.ohmrun.halva.LVar<T>;


typedef ThresholdSet<T>                 = eu.ohmrun.halva.ThresholdSet<T>;
typedef ThresholdSets                   = eu.ohmrun.halva.ThresholdSet.ThresholdSets;

typedef AggregationApi<K,V>                   = eu.ohmrun.halva.Aggregation.AggregationApi<K,V>;
typedef AggregationCls<K,V>                   = eu.ohmrun.halva.Aggregation.AggregationCls<K,V>;
typedef Aggregation<K,V>                      = eu.ohmrun.halva.Aggregation.AggregationCls<K,V>;


//typedef LVarOp<T>                       = eu.ohmrun.halva.LVarOp<T>;
//typedef ActivationSet<T>                = eu.ohmrun.halva.ActivationSet<T>;

class StubItemComparable{
}
