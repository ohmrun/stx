package stx.assert.eq.term.fs.path;

using stx.Assert;

class Directory implements EqApi<stx.fs.path.Directory> extends Clazz{ 
  public function comply(lhs:stx.fs.path.Directory,rhs:stx.fs.path.Directory):Equaled{
    final drive_equal = new stx.assert.eq.term.fs.path.Drive().comply(lhs.drive,rhs.drive);
    return drive_equal.is_ok().if_else(
      () -> new stx.assert.eq.term.fs.path.Track().comply(lhs.track,rhs.track),
      () -> drive_equal
    );
  }
}