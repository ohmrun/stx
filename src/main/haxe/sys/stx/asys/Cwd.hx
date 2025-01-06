package sys.stx.asys;

import stx.fs.path.Raw.RawLift;

class Cwd implements CwdApi extends Clazz{
  public function pop():Attempt<HasDevice,Directory,FsFailure>{
    __.log().debug(Sys.getCwd());
    return 
      Path.parse(Sys.getCwd())
      .attempt(RawLift.toDirectory)
      .errata(E_Fs_Path);
  }
  public function put(dir:Directory):Command<HasDevice,FsFailure>{
    return Command.fromFun1Report(
      (env:HasDevice) -> {
        var val = Report.unit();
        try{
          Sys.setCwd(dir.canonical(env.device.sep));
        }catch(e:Dynamic){
          val = Report.pure(__.fault().of(E_Fs_CannotSetWorkingDirectory(dir.canonical(env.device.sep),e)));
        }
        return val;
      }
    );
  }
}