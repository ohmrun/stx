package stx.parse.term;

import stx.parse.Parsers.*;

@:note("neko throws without explicit typing of input.content.data")
@:access(stx.parse) class Literal extends ParserCls<String,String>{
  
  override public function apply(input:ParseInput<String>):ParseResult<String,String>{
    var all  : String = input.content.data;
    var data : String = all.substr(input.offset);
    var code = StringTools.fastCodeAt;
    var has  = Range;
    var q    = 34;
    var fst  = code(data,0);
    if(fst == 39){
      q = 39;
    }
    var ok     = q == fst;
    var idx    = 1;
    var failed = false;

    #if debug
    __.log().trace(ok);
    #end
    //trace(ok);
    if(ok){
      while(true){
        #if debug__.log().blank(data); #end
        final val = code(data,idx);
        #if debug
        __.log().trace('$val ${data.substr(idx,1)}');
        #end
        switch(val){
          case 92 :  
            if(code(data,idx+1) == q){
              #if debug __.log().trace('step over'); #end
              idx+=2;
            }else{
              idx+=1;
            }
          case x if (x == q) : 
            idx+=1;
            break;
          #if !static
          case null : 
            failed = true;
            break;
          #end
          default : 
            idx++;
        }
      }
    }else{
      failed = true;
    }
    return if(failed){
      input.no(E_Parse_EmptyInput);
    }else{
      var out : String = input.take(idx);
        out = out.substr(1,out.length-2);
      idx > 1 ? input.drop(idx).ok(out) : input.no(E_Parse_Failed); 
    }
  }
}