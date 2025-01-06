package stx.parse.parser.term;

/**
  Will only continue delegate parses `number` times.
  Will not attempt delegate parse beyond.
**/
class RepeatedOnly<I,O> extends Base<I,Array<O>,Parser<I,O>>{
  final number : Int;

  public function new(delegation:Parser<I,O>,number:Int,?id:Pos){
    this.number = number;
    //__.assert(this.number).gt_eq(1);

    #if debug
    __.assert().that(id).exists(delegation);
    #end
    super(delegation,id);
    this.tag = switch (delegation.tag){
      case Some(v)  : Some('($v)*');
      default       : None;
    }
  }
  override public function check(){
    #if debug
    // __.assert(pos).expect().exists().errata( e -> e.fault().of(E_Parse_UndefinedParseDelegate)).crunch(delegation);
    #end
  }
  public function apply(inputI:ParseInput<I>):ParseResult<I,Array<O>>{
    var count = 0;
    function rec(inputII:ParseInput<I>,arr:Array<O>){
      final res = delegation.apply(inputII);
      #if debug
      __.log().trace('$delegation');
      __.log().trace('${res.error}');
      __.log().trace('$arr');
      #end
      __.log().blank(count);
      __.log().blank(res.is_ok());
      return switch(res.is_ok()){
        case true : 
          count++;
          #if debug __.log().trace('${res.value}'); #end 
          switch(res.value){
            case Some(x)  : arr.push(x); null;
            default       : 
          }
          if (count == number){
            res.asset.ok(arr); 
          }else{
            __.log().debug('${res}');
            return rec(res.asset,arr);
          }
        case false : 
          if(res.is_fatal()){
            __.log().debug('failed many ${delegation}');
            inputI.fatal(E_Parse_OutOfBounds).defect(res.error);
          }else{
            #if debug __.log().trace(_ -> _.thunk( () -> arr)); #end
            if(count == number){
              inputII.ok(arr); 
            }else{
              __.log().debug('Should repeat $number times, but repeated $count times');
              inputI.no();
            }
          }
      }
    }
    return rec(inputI,[]);
  }
}