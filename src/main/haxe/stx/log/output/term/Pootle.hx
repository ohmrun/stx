package stx.log.output.term;

#if pootle
class Pootle implements OutputApi{
  private final delegate : eu.ohmrun.pootle.PortalLogger;
  public function new(?config:eu.ohmrun.pootle.PortalConfig){
    this.delegate = new eu.ohmrun.pootle.PortalLogger(config);
  }  
  public function render( v : Dynamic, infos : LogPosition,stamp : Stamp ) : Void{
    final pos = infos.toPosInfos();
          pos.customParams = pos.customParams.concat(stamp.toCustomParams());
    this.delegate.trace(v,pos);
  }
}
#end