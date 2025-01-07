package stx.log.output.term;

class File implements OutputApi{
  final archive : sys.io.FileOutput;
  public function new(archive:sys.io.FileOutput){
    this.archive = archive;
  }
  public function render( v : Dynamic, infos : LogPosition, stamp : Stamp ) : Void{
    archive.writeString('$v');
  }
}