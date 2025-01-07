package stx.fail;

/**
 * Class for packing a typed error in a block for routing out of a subsystem.
 * See `stx.pico.Embed` 
 */
class EmbedTypedErrorException extends Exception{
  public final embed : Void->Void;
  public function new(embed:Void->Void,?message:String, ?previous:Exception, ?native:Any){
    super(message,previous,native);
    this.embed = embed;
  }
}