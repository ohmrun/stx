package sys;

import Sys;

/**
 * Write to stderr
 */
class Debug{
  static public function apply(data:String){
    Sys.stderr().writeString(data);
  }
}