package sys;

import Sys;

class Debug{
  static public function apply(data:String){
    Sys.stderr().writeString(data);
  }
}