package stx;

using stx.Pico;
using stx.Fail;
import stx.nano.*;

class Nano{
  static public function digests(wildcard:Wildcard):Digests{
    return wildcard;
  } 
  static public function stx<T>(wildcard:Wildcard):STX<T>{
    return STX;
  }
}
typedef VBlockDef<T>            = stx.nano.VBlock.VBlockDef<T>;
typedef VBlock<T>               = stx.nano.VBlock<T>;


typedef PledgeDef<T,E>          = stx.nano.Pledge.PledgeDef<T,E>;
typedef Pledge<T,E>             = stx.nano.Pledge<T,E>;

typedef Upshot<T,E>             = stx.nano.Upshot<T,E>;
typedef UpshotSum<T,E>          = stx.nano.Upshot.UpshotSum<T,E>;

typedef ByteSize                = stx.nano.ByteSize;
typedef Endianness              = stx.nano.Endianness;

// typedef Recursive<P>            = stx.nano.Recursive<P>;

// typedef Y<P, R>                 = stx.nano.Y<P,R>;
// typedef YDef<P, R>              = stx.nano.Y.YDef<P,R>;



typedef LiftTinkErrorToError        = stx.nano.lift.LiftTinkErrorToError;
typedef LiftErrorToUpshot           = stx.nano.lift.LiftErrorToRes;
typedef LiftErrorToReport           = stx.nano.lift.LiftErrorToReport;
typedef LiftErrorToAlert            = stx.nano.lift.LiftErrorToAlert;
typedef LiftFuture                  = stx.nano.lift.LiftFuture;
typedef LiftIMapToArrayKV           = stx.nano.lift.LiftIMapToArrayKV;
typedef LiftOptionNano              = stx.nano.lift.LiftOptionNano;
typedef LiftArrayNano               = stx.nano.lift.LiftArrayNano;
typedef LiftNano                    = stx.nano.lift.LiftNano;
typedef LiftErrToChunk              = stx.nano.lift.LiftErrToChunk;
typedef LiftResToChunk              = stx.nano.lift.LiftResToChunk;
typedef LiftOptionToChunk           = stx.nano.lift.LiftOptionToChunk;
typedef LiftTinkOutcomeToChunk      = stx.nano.lift.LiftTinkOutcomeToChunk;
typedef LiftIterableToIter          = stx.nano.lift.LiftIterableToIter;
typedef LiftArrayToIter             = stx.nano.lift.LiftArrayToIter;
typedef LiftIteratorToIter          = stx.nano.lift.LiftIteratorToIter;
typedef LiftMapToIter               = stx.nano.lift.LiftMapToIter;
typedef LiftMapToIterKV             = stx.nano.lift.LiftMapToIterKV;
typedef LiftStringMapToIter         = stx.nano.lift.LiftStringMapToIter;
typedef LiftStringMapToIterKV       = stx.nano.lift.LiftStringMapToIterKV;
typedef LiftJsPromiseToContract     = stx.nano.lift.LiftJsPromiseToContract;
typedef LiftContractToJsPromise     = stx.nano.lift.LiftContractToJsPromise;
typedef LiftJsPromiseToPledge       = stx.nano.lift.LiftJsPromiseToPledge;
typedef LiftFutureResToPledge       = stx.nano.lift.LiftFutureResToPledge;
typedef LiftError                   = stx.nano.lift.LiftError;
typedef LiftBytes                   = stx.nano.lift.LiftBytes;
typedef LiftPath                    = stx.nano.lift.LiftPath;

typedef ReportSum<E>            = stx.nano.ReportSum<E>;
typedef Report<E>               = stx.nano.Report<E>;
typedef Position                = stx.nano.Position;
typedef PositionLift            = stx.nano.Position.PositionLift;
typedef PrimitiveSum            = stx.nano.Primitive.PrimitiveSum;
typedef Primitive               = stx.nano.Primitive;

typedef SlotCls<T>              = stx.nano.Slot.SlotCls<T>;
typedef Slot<T>                 = stx.nano.Slot<T>;

typedef Unique<T>               = stx.nano.Unique<T>;
typedef KV<K,V>                 = stx.nano.KV<K,V>;
typedef KVDef<K,V>              = stx.nano.KV.KVDef<K,V>;
typedef Iter<T>                 = stx.nano.Iter<T>;

typedef StringableDef           = stx.nano.Stringable.StringableDef;
typedef Stringable              = stx.nano.Stringable;

typedef Defect<E>               = stx.nano.Defect<E>;
typedef DefectDef<E>            = stx.nano.Defect.DefectDef<E>;
typedef DefectApi<E>            = stx.nano.Defect.DefectApi<E>;
typedef DefectCls<E>            = stx.nano.Defect.DefectCls<E>;
/**
 * `Defect` type error with no associated information.
 */
typedef Scuttle                 = Defect<Nada>;
typedef Reaction<T>             = Outcome<T,Scuttle>;

typedef Resource                = stx.nano.Resource;
typedef LiftStringToResource    = stx.nano.lift.LiftStringToResource;

typedef ChunkSum<T,E>           = stx.nano.Chunk.ChunkSum<T,E>;
typedef Chunk<T,E>              = stx.nano.Chunk<T,E>;

typedef ContractDef<T,E>        = stx.nano.Contract.ContractDef<T,E>;
typedef Contract<T,E>           = stx.nano.Contract<T,E>;

typedef EnumValue               = stx.nano.EnumValue;
typedef Blob                    = stx.nano.Blob;
typedef Field<T>                = stx.nano.Field<T>;

typedef OneOrManySum<T>         = stx.nano.OneOrMany.OneOrManySum<T>;
typedef OneOrMany<T>            = stx.nano.OneOrMany<T>;
typedef CompilerTarget          = stx.nano.CompilerTarget;
typedef CompilerTargetSum       = stx.nano.CompilerTarget.CompilerTargetSum;
typedef Enum<T>                 = stx.nano.Enum<T>;
typedef Introspectable          = stx.nano.Introspectable;
typedef AlertDef<E>             = stx.nano.Alert.AlertDef<E>;
typedef Alert<E>                = stx.nano.Alert<E>;
typedef AlertTrigger<E>         = stx.nano.Alert.AlertTrigger<E>;
typedef Signal<T>               = stx.nano.Signal<T>;
//typedef Stream<T,E>             = stx.nano.Stream<T,E>;


typedef Char                    = stx.nano.Char;
typedef Chars                   = stx.nano.Chars;
typedef Ints                    = stx.nano.Ints;
typedef Numeric                 = stx.nano.Numeric;
typedef NumericSum              = stx.nano.Numeric.NumericSum;
typedef SprigSum                = stx.nano.Sprig.SprigSum;
typedef Sprig                   = stx.nano.Sprig;
typedef Floats                  = stx.nano.Floats;
typedef Math                    = stx.nano.Math;
typedef Bools                   = stx.nano.Bools;
typedef TimeStamp               = stx.nano.TimeStamp;
typedef TimeStampDef            = stx.nano.TimeStamp.TimeStampDef;
typedef LogicalClock            = stx.nano.LogicalClock;
typedef Cluster<T>              = stx.nano.Cluster<T>;
typedef ClusterDef<T>           = stx.nano.Cluster.ClusterDef<T>;
typedef Clustered<T>            = stx.nano.Clustered<T>;
typedef Roster<T>               = stx.nano.Roster<T>;
typedef Unfold<T,R>             = stx.nano.Unfold<T,R>;
typedef Counter                 = stx.nano.Counter;
typedef Json                    = stx.nano.Json;
typedef LiftOutcomeTDefect      = stx.nano.lift.LiftOutcomeTDefect;
typedef Xml                     = stx.nano.Xml;

typedef Receipt<T,E>            = stx.nano.Receipt<T,E>;
typedef ReceiptDef<T,E>         = stx.nano.Receipt.ReceiptDef<T,E>;
typedef ReceiptApi<T,E>         = stx.nano.Receipt.ReceiptApi<T,E>;
typedef ReceiptCls<T,E>         = stx.nano.Receipt.ReceiptCls<T,E>;
typedef Accrual<T,E>            = stx.nano.Accrual<T,E>;
typedef AccrualDef<T,E>         = stx.nano.Accrual.AccrualDef<T,E>;

typedef Ledger<I,O,E>           = stx.nano.Ledger<I,O,E>;
typedef LedgerDef<I,O,E>        = stx.nano.Ledger.LedgerDef<I,O,E>;
typedef Equity<I,O,E>           = stx.nano.Equity<I,O,E>;
typedef EquityDef<I,O,E>        = stx.nano.Equity.EquityDef<I,O,E>;
typedef EquityCls<I,O,E>        = stx.nano.Equity.EquityCls<I,O,E>;
typedef EquityApi<I,O,E>        = stx.nano.Equity.EquityApi<I,O,E>;

typedef Coord                   = stx.nano.Coord;
typedef CoordSum                = stx.nano.Coord.CoordSum;

typedef Tup2<L,R>               = stx.nano.Tup2<L,R>;

typedef Triple<A,B,C>           = stx.nano.Triple<A,B,C>;
typedef TripleDef<A,B,C>        = stx.nano.Triple.TripleDef<A,B,C>;

typedef Retry                   = stx.nano.Retry;

typedef FPath               = stx.nano.FPath;
typedef Unspecified         = stx.nano.Unspecified;
typedef Timer               = stx.nano.Timer;

typedef APPDef<P,R>         = stx.nano.APP.APPDef<P,R>;
typedef APP<P,R>            = stx.nano.APP<P,R>;

typedef IdentDef            = stx.nano.Ident.IdentDef;
typedef Ident               = stx.nano.Ident;
typedef Way                 = stx.nano.Way;

typedef Ensemble<T>         = stx.nano.Ensemble<T>;
typedef EnsembleDef<T>      = stx.nano.Ensemble.EnsembleDef<T>;

typedef IterKV<K,V>         = stx.nano.IterKV<K,V>;
typedef IterKVDef<K,V>      = stx.nano.IterKV.IterKVDef<K,V>;

typedef Enquire<P>          = stx.nano.Enquire<P>;
typedef EnquireDef<P>       = stx.nano.Enquire.EnquireDef<P>;

typedef Cell<P>             = stx.nano.Cell<P>;
typedef CellDef<P>          = stx.nano.Cell.CellDef<P>;

typedef Trivalent           = stx.nano.Trivalent;
typedef TrivalentSum        = stx.nano.Trivalent.TrivalentSum;

typedef NuggetApi<P>        = stx.nano.Nugget.NuggetApi<P>;
typedef NuggetCls<P>        = stx.nano.Nugget.NuggetCls<P>;
typedef Nugget<P>           = stx.nano.Nugget<P>;

typedef Absorbable<P>       = stx.nano.Nugget.Absorbable<P>;
typedef Producable<P>       = stx.nano.Nugget.Producable<P>;

typedef Register            = stx.nano.Register;
typedef Knuckle             = stx.nano.Knuckle;
typedef KnuckleSum          = stx.nano.Knuckle.KnuckleSum;

typedef Junction<T>         = stx.nano.Junction<T>;
typedef JunctionSum<T>      = stx.nano.Junction.JunctionSum<T>;
typedef JunctionCtr<T>      = stx.nano.Junction.JunctionCtr<T>;

typedef PrimitiveType       = stx.nano.PrimitiveType;
typedef PrimitiveTypeSum    = stx.nano.PrimitiveType.PrimitiveTypeSum;
typedef PrimitiveTypeCtr    = stx.nano.PrimitiveType.PrimitiveTypeCtr;

typedef Record<T>                 = stx.nano.Record<T>;
typedef RecordDef<T>              = stx.nano.Record.RecordDef<T>;

typedef Generator<T>              = stx.nano.Generator<T>;

typedef PartialFunction<P,R>      = stx.nano.PartialFunction<P,R>;
typedef PartialFunctionApi<P,R>   = stx.nano.PartialFunction.PartialFunctionApi<P,R>;
typedef PartialFunctionCls<P,R>   = stx.nano.PartialFunction.PartialFunctionCls<P,R>;

typedef PartialFunctions<P,R>     = stx.nano.PartialFunctions<P,R>;
typedef PartialFunctionsDef<P,R>  = stx.nano.PartialFunctions.PartialFunctionsDef<P,R>;


typedef Work                                    = stx.nano.Work;
typedef Bang                                    = stx.nano.Work.Bang;
typedef Cycle                                   = stx.nano.Cycle;
typedef CYCLED                                  = stx.nano.Cycle.CYCLED;
typedef CycleState                              = stx.nano.Cycle.CycleState;
typedef Cycler                                  = stx.nano.Cycle.Cycler;

class LiftPos{
  @:noUsing static public function lift(pos:Pos):stx.nano.Position{
    return new stx.nano.Position(pos);
  }
}
enum abstract UNIMPLEMENTED(String){
  var UNIMPLEMENTED;
}
class LiftEnumValue{
  @:noUsing static public function lift(self:stx.alias.StdEnumValue):std.EnumValue{
    return stx.nano.EnumValue.lift(self);
  }
}
class Couples{
  static public function cat<Ti,Tii>(self:Couple<Ti,Tii>):Cluster<Either<Ti,Tii>>{
    return stx.pico.Couple.CoupleLift.decouple(self,(l,r) -> [Left(l),Right(r)]);
  }
  static public function toTup2<Ti,Tii>(self:Couple<Ti,Tii>):Tup2<Ti,Tii>{
    return stx.pico.Couple.CoupleLift.decouple(self,Tup2.tuple2);
  }
  static public function tup<Ti,Tii>(self:Couple<Ti,Tii>):Tup2<Ti,Tii>{
    return stx.pico.Couple.CoupleLift.decouple(self,Tup2.tuple2);
  }
}class LiftFutureToSlot{
  static public inline function toSlot<T>(ft:tink.core.Future<T>,?pos:Pos):stx.nano.Slot<T>{
    return stx.nano.Slot.Guard(ft,pos);
  }
}
class LiftLazyFutureToSlot{
  static public inline function toSlot<T>(fn:Void -> tink.core.Future<T>):stx.nano.Slot<T>{
    return stx.nano.Slot.Guard(fn());
  }
}
// class LiftStringableToString{
//   static public function toString(str:Stringable):String{
//     //trace("STRINGABLE");
//     return str.toString();
//   }
// }
class LiftTToString{
  /**
   * Run `Std.string` on anything.
   * @param self `T`
   * @return `String`
   */
  static public function toString<T>(self:T):String{
    //trace("ANYTHING");
    return Std.string(self);
  }
}
class Maps{
  static public function map_into<K,Vi,Vii>(self:Map<K,Vi>,fn:Vi -> Vii,memo:Map<K,Vii>):Map<K,Vii>{
    for(k => v in self){
      memo.set(k,fn(v));
    }
    return memo;
  }
}
// class PicoNano{
//   // static public function Option(pico:Pico):Stx<stx.pico.Option.Tag>{
//   //   return __.stx();
//   // }
// }
class LiftArrayToCluster{
  static public inline function toCluster<T>(self:Array<T>):stx.nano.Cluster<T>{
    return stx.nano.Cluster.lift(self);
  }
}
