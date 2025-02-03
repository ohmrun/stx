package sys;

import Sys;

/**
 * Write to stderr
 */
class Debug{
  static public function apply(data:Null<String>){
    switch(data){
      case  null : 
      default :     Sys.stderr().writeString(data);
    }
  }
}