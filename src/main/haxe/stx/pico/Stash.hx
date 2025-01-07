package stx.pico;

import haxe.ds.StringMap;

class Stash<T>{
  private final data : StringMap<T>;
  public function new(){
    this.data = new StringMap();
  }
  public function stash(self:T){
    final uuid = new Uuid("xxxxx");
    this.data.set(uuid.toString(),self);
    return uuid;
  }
  public function remove(uuid:String){
    final has = this.data.exists(uuid);
    this.data.remove(uuid);
    return has;
  }
  public function has(uuid:String){
    return this.data.exists(uuid);
  }
  public  function get(uuid:String){
    return this.data.get(uuid);
  }
}