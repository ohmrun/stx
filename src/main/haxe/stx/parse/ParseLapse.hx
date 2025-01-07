package stx.parse;

abstract ParseLapse(LapseDef<ParseFailure>) from Lapse<ParseFailure> to Lapse<ParseFailure>{
  public function new(value,?label:ParseFailureMessage,?crack,index,?pos){
    this = {
      value : value,
      label : '$label' ?? "FAIL",
      loc   : new LocCtr().Indexed(index,pos)
    }
  }
}