package stx.data.store;

class Serialize{
  /**
    I don't trust reuse with the internal state, soz.
  **/
  @:noUsing static public function encode<T>(v:T):String{
    var serializer          = new haxe.Serializer();
        serializer.useCache = true;
        serializer.serialize(v);
    return serializer.toString();
  }
  @:noUsing static public function decode<T>(string:String):T{
    return haxe.Unserializer.run(string);
  }
}