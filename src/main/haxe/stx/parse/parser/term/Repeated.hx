package stx.parse.parser.term;

/**
  Parses delegation `number` times, if delegation parse fails while `x < number`, `Repeated` will fail.
  If `number + 1` delegation attempt succeeds, `Repeated` will fail.
**/
class Repeated<I,O> extends Base<I,Array<O>,Parser<I,O>>{
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
    //__.assert(pos).expect().exists().errata( e -> e.fault().of(E_Parse_UndefinedParseDelegate)).crunch(delegation);
    #end
  }
  override public function apply(inputI:ParseInput<I>):ParseResult<I,Array<O>>{
    var count = 0;
    function rec(inputII:ParseInput<I>,arr:Array<O>):ParseResult<I,Array<O>>{
      final res = delegation.apply(inputII);
      #if debug
      __.log().trace('$delegation');
      __.log().trace('${res.error}');
      __.log().trace('$arr');
      __.log().blank(count);
      __.log().blank(res.is_ok());
      #end
      return switch(res.is_ok()){
        case true : 
          if (count > number){
            #if debug
            __.log().debug('Should repeat $number times, but repeated $count times');
            #end
            inputI.no(E_Parse_OutOfBounds);
          }else{
            count++;
            #if debug __.log().trace('${res.value}'); #end 
            switch(res.value){
              case Some(x) : arr.push(x); null;
              default : 
            }
            #if debug
            __.log().debug('${res}');
            #end
            return rec(res.asset,arr);
          }
        case false : 
          if(res.is_fatal()){
            #if debug
            __.log().debug('failed many ${delegation}');
            #end
            inputI.fatal(E_Parse_OutOfBounds).defect(res.error);
          }else{
            #if debug __.log().trace(_ -> _.thunk( () -> arr)); #end
            if(count == number){
              res.asset.ok(arr); 
            }else{
              #if debug
              __.log().debug('Should repeat $number times, but repeated $count times');
              #end
              inputI.no();
            }
          }
      }
    }
    return rec(inputI,[]);
  }
}