package stx.nano.lift;

class LiftContractToJsPromise{
  #if js
  static public function toJsPromise<T,E>(self:Contract<T,E>):js.lib.Promise<Upshot<Option<T>,Dynamic>>{
    return stx.nano.Contract.ContractLift.toJsPromise(self);
  }
  #end
}