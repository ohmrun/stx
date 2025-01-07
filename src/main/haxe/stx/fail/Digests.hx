package stx.fail;

abstract Digests(Wildcard) from Wildcard{
  // static public function e_digest_uuid_reserved<E>(self:Digests,uuid):Error<E>{
  //   return new stx.fail.digest.term.EDigestUUIDReserved(uuid);
  // }
  static public function e_resource_not_found<E>(self:Digests,name):CTR<Pos,Digest>{
    return stx.fail.digest.term.EResourceNotFound.make.bind(name);
  }
  static public function e_no_field<E>(self:Digests,name):CTR<Pos,Digest>{
    return stx.fail.digest.term.ENoField.make.bind(name);
  }
  static public function e_undefined<E>(self:Digests):CTR<Pos,Digest>{
    return stx.fail.digest.term.EUndefined.make;
  }
  static public function e_tink_error<E>(self:Digests,msg,code,?pos):CTR<Pos,Digest>{
    return stx.fail.digest.term.ETinkError.make.bind(msg,code);
  }
  static public function e_unimplemented<E>(self:Digests,name):CTR<Pos,Digest>{
    return stx.fail.digest.term.EUnimplemented.make.bind(name);
  }
  #if js
  static public function e_js_error<E>(self:Digests,error:js.lib.Error):CTR<Pos,Digest>{
    return stx.fail.digest.term.EJsError.make.bind(error);
  }
  #end 
}