package sys.stx.asys;

class DeviceCtr{
  @:noUsing static public function unit(tag:STX<Device>){
    return Device.make0(Distro.unit());
  }
}