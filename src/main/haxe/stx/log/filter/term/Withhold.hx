package stx.log.filter.term;

class Withhold<T> extends Filter<T>{
  public function new(){
    new stx.log.global.config.IsFilteringWithTags().value = true;
    super();
  }
  override public function apply(value:Value<Dynamic>){
    final info = value.source;
    return Report.make(stx.fail.Error.ErrorCtr.instance.Value(E_Log_Zero));
  }
  public function canonical(){
    return 'Withhold';
  }
}