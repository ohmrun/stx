package sys.log.logger;

#if (sys || nodejs)
class File extends Custom{
  public function new(archive:sys.io.FileOutput){
    super(
      logic,
      __.option(format).defv(new stx.log.core.Format.FormatCls()),
      new stx.log.output.term.File(archive)
    );
  }
  override private function do_apply(value:Value<Dynamic>):Continuation<Upshot<String,LogFailure>,Value<Dynamic>>{
    return Continuation.lift(
      (fn:Value<Dynamic>->Upshot<String,LogFailure>) -> {
        var result = __.accept(this.format.print(value) + "\n");
        return result;
      }
    );
  }
}
#end