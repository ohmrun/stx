package stx.asys;

enum abstract Distro(String){
  
  var Windows;
  var Linux;
  var BSD;
  var Mac;

  @:noUsing static public function unit(){
    return new Distro(Sys.systemName());
  }
  public function new(system_name:String){
    this = switch(system_name){
      case "Windows"  : "Windows"; 
      case "Linux"    : "Linux";
      case "BSD"      : "BSD";
      case "Mac"      : "Mac";
      case x          :  throw __.fault().digest((_:stx.fail.Digests) -> _.e_unknown_distro(x));
    }
  }
  public function is_windows(){
    return this == "Windows";
  }
}