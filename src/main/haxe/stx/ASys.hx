package stx;

using stx.Pico;


class ASys{
  static public function asys(wildcard:Wildcard){
    return new stx.asys.Module();
  }
}
class LiftASys{
}

typedef LiftParseErrorInfoToPathParseFailure  = stx.fail.lift.LiftParseErrorInfoToPathParseFailure;
typedef ASysFailure                           = stx.fail.ASysFailure;
typedef ASysFailureSum                        = stx.fail.ASysFailure.ASysFailureSum;
typedef Distro                                = stx.asys.Distro;
typedef DeviceApi                             = stx.asys.DeviceApi;
typedef HasDevice                             = stx.asys.HasDevice;
typedef HasDeviceApi                          = stx.asys.HasDeviceApi;
typedef ShellApi                              = stx.asys.ShellApi;
typedef ExitCode                              = stx.asys.ExitCode;
typedef ConsoleApi                            = stx.asys.ConsoleApi;
typedef EnvApi                                = stx.asys.EnvApi;
typedef UserApi                               = stx.asys.UserApi;
typedef SystemApi                             = stx.asys.SystemApi;
typedef CwdApi                                = stx.asys.CwdApi;
  