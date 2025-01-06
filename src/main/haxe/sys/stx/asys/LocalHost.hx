package sys.stx.asys;

@:forward abstract LocalHost(DeviceApi) from DeviceApi to DeviceApi{
  static public var instance(get,null) : LocalHost;
  static private function get_instance(){
    return instance == null ? instance = new LocalHost() : instance;
  }
  private function new(){
    this = Device.make0(__.asys().Distro().unit());
  }
  static public function unit():LocalHost{
    return new LocalHost();
  }
}