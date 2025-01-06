package stx;

typedef Lapse<E>                    = stx.fail.Lapse<E>;
typedef LapseDef<E>                 = stx.fail.Lapse.LapseDef<E>;
typedef LapseCtr                    = stx.fail.Lapse.LapseCtr;
typedef Error<E>                    = stx.fail.Error<E>;
typedef ErrorCtr                    = stx.fail.Error.ErrorCtr;
typedef ErrorCls<E>                 = stx.fail.Error.ErrorCls<E>;
typedef ErrorApi<E>                 = stx.fail.Error.ErrorApi<E>;
typedef EmbedTypedErrorException    = stx.fail.EmbedTypedErrorException;
typedef DigestCls                   = stx.fail.Digest.DigestCls;
typedef Digest                      = stx.fail.Digest;
typedef IngestCls<E>                = stx.fail.Ingest.IngestCls<E>;
typedef Ingest<E>                   = stx.fail.Ingest<E>;
typedef Digests                     = stx.fail.Digests;
typedef Ingests<E>                  = stx.fail.Ingests<E>;
typedef Fault                       = stx.fail.Fault;
typedef Excepts<E>                  = stx.fail.Excepts<E>;

class Fail{
  /****/
  static public function Crack<E>(self:haxe.Exception):Error<E>{
    return ErrorCtr.instance.Crack(self);
  }
}