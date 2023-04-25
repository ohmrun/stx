package stx.show.showable.term;

import String as TString;

class String extends ShowableCls<TString>{
  public function show(self:TString,state:State):Upshot<Response,ShowFailure>{
    // final string          = '$self';
    // final length          = string.length;
    // final width_remaining = state.width_remaining;
    
    // final layout  = function rec(node){
    //   return switch(node){
    //     case None                   : rec(Some(LBlock));
    //     case Some(LBlock)           : 
    //       //__.accept(LBlock);
    //       final has_horizontal_room = (width_remaining - length) >= 0;
    //       if(true){
    //         state.respond(length,1,Some(string),None,[].imm(),LBlock);
    //       }else{
    //         rec(Some(LEscape(LBlock)));
    //       }
    //     case Some(LEscape(LBlock)) : 
    //       final has_complete_horizontal_room = (state.options.width - length) >= 0;
    //         if(has_complete_horizontal_room){
    //           state.respond(length,1,Some(string),None,[].imm(),LEscape(LBlock));
    //         }else{
    //           final lines     = [];
    //           final iterator = (string:Chars).iterator();
    //           var   n        = 0;
    //           var   s        = '';
    //           for (i in iterator){
    //             if(n >= state.options.width){
    //               lines.push(s);
    //               s = '';
    //               n = 0;
    //             }else{
    //               s = s + i;
    //               n = n + 1;
    //             }
    //           }
    //           if(s != ''){
    //             lines.push(s);
    //           }
    //           final width = lines.length > 0 ? state.options.width : string.length;
    //           state.respond(
    //             width,
    //             lines.length,
    //             Some(lines.join("\n")),
    //             None,
    //             [].imm(),
    //             LBlock
    //           );
    //         }
    //       //__.accept(Some(LEscape(LBlock)));
    //     default                   : rec(Some(LBlock));
    //     //__.reject(__.fault().of(E_Show_DoesNotSupportLayout(node)));
    //   }
    // }
    // return __.accept(rec(state.request.node));
    return throw UNIMPLEMENTED;
  }
}