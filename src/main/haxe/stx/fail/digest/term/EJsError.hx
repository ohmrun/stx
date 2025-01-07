package stx.fail.digest.term;

#if js
  class EJsError extends DigestCls{
    @:noUsing static public function make(error,pos){
      return new EJsError(error,pos);
    }
    public function new(error:js.lib.Error,?pos){
      super(
        error.name,
        error.message,
        LocCtr.instance.Available(pos)
      );
    }
  }
#end