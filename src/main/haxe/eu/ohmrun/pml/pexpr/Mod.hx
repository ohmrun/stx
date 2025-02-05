package eu.ohmrun.pml.pexpr;

class Mod{
  /**
   * runs fn on the first layer of subexpressions only, re-adds anything `Accept(Some(x))`, shortcuts on `Reject(x)`
   * @param self 
   * @param fn 
   * @param PmlFailure> 
   */
  static public function mod<T,E>(self:PExpr<T>, fn:PExpr<T>->Upshot<Option<PExpr<T>>,E>):Upshot<Option<PExpr<T>>,E>{
		return switch(self){
			case 			PGroup(list)		: Upshot.bind_fold(
				list,
				function(next:PExpr<T>,memo:Option<LinkedList<PExpr<T>>>){
					return (fn(next)).map(
						opt -> opt.map(
							ok -> memo.fold(
								memo 	-> memo.snoc(ok),
								() 		-> LinkedList.unit().snoc(ok)
							)
						)
					);
				}
				,None
			).map(
				opt -> opt.map(PGroup)
			);
			case 			PArray(array)		: 
				Upshot.bind_fold(
					array,
					function(next:PExpr<T>,memo:Option<Cluster<PExpr<T>>>){
						return fn(next).map(
							opt -> opt.map(
								ok -> memo.fold(
									memo 	-> memo.snoc(ok),
									() 		-> Cluster.unit().snoc(ok)
								)
							)
						);
					}
					,None
				).map(
					opt -> opt.map(PArray)
				);
			case 			PSet(arr)				: 
				Upshot.bind_fold(
					arr,
					function(next:PExpr<T>,memo:Option<Cluster<PExpr<T>>>){
						return fn(next).map(
							opt -> opt.map(
								ok -> memo.fold(
									memo 	-> memo.snoc(ok),
									() 		-> Cluster.unit().snoc(ok)
								)
							)
						);
					}
					,None
				).map(
					opt -> opt.map(PSet)
				);
			case 			PAssoc(map)			:
				Upshot.bind_fold(
					map,
					function(next:Tup2<PExpr<T>,PExpr<T>>,memo:Option<Cluster<Tup2<PExpr<T>,PExpr<T>>>>){
						//trace('$next $memo');
						return (fn(PGroup(Cons(next.fst(),Cons(next.snd(),Nil)))))
							.flat_map(
								(r:Option<PExpr<T>>) -> (r.fold(
									ok -> switch(ok){
										case PGroup(Cons(x,Cons(y,Nil))) : 
											__.accept(Some(tuple2(x,y)));
										default : 
											__.reject(
												(f:Fault) -> f.to(
													pos -> 
													ErrorCtr.instance.Make(
														l -> l.Digest(
															'7c4af36c-7fd7-4acb-9382-155989d794e2',
															'must return PGroup(Cons(x,Cons(y,Nil))) but have $ok',
															null,
															_ -> Loc.fromPos(pos.toPos())
														).enlist()
													)
												)
											);
									},
									() -> __.accept(None)
								))
							).map(
								opt -> {
									return memo.fold(
										okI -> opt.map( ok -> okI.snoc(ok)).or(() -> Some(okI)),
										() 	-> opt.map( ok -> Cluster.unit().snoc(ok))
									);
								}
							);
					},
					None
				).map(
					opt -> opt.map(PAssoc)
				);
			default   								: __.accept(__.option(self));
		}
	}
}