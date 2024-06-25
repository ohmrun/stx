package stx.fs.path.lift;


import stx.fs.path.Raw.RawLift;

class LiftAttemptHasDeviceRaw{
  #if (sys || nodejs)
  static public function toTrack(self:Attempt<HasDevice,Raw,PathFailure>){
    return self.attempt(RawLift.toTrack);
  }
  static public function toDirectory(self:Attempt<HasDevice,Raw,PathFailure>){
    return self.attempt(RawLift.toDirectory);
  }
  static public function toJourney(self:Attempt<HasDevice,Raw,PathFailure>){
    return self.attempt(RawLift.toJourney);
  }
  static public function toAttachment(self:Attempt<HasDevice,Raw,PathFailure>){
    return self.attempt(RawLift.toAttachment);
  }
  static public function toArchive(self:Attempt<HasDevice,Raw,PathFailure>){
    return self.attempt(RawLift.toArchive);
  }
  #end
}
