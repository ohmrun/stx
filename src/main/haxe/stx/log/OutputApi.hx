package stx.log;

interface OutputApi{
  public function render( v : Dynamic, infos : LogPosition, stamp : Stamp ) : Void;
}