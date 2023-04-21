package stx.fail;

enum ConfigFailureSum{
  E_Config(str:String);
  E_Config_Fs(data:FsFailure);
}
abstract ConfigFailure(ConfigFailureSum) from ConfigFailureSum to ConfigFailureSum{
  public function new(self) this = self;
  @:noUsing static public function lift(self:ConfigFailureSum):ConfigFailure return new ConfigFailure(self);

  public function prj():ConfigFailureSum return this;
  private var self(get,never):ConfigFailure;
  private function get_self():ConfigFailure return lift(this);

  @:from static public function fromFsFailure(self:FsFailure){
    return lift(E_Config_Fs(self));
  }
  @:from static public function fromNoise(self:tink.core.Noise){
    return lift(E_Config("E_Config"));
  }
}