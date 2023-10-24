package stx.makro.type;

/**
 * Sometimes the head is the interesting bit, sometimes it's a bit lower down.
 */
class HFace{
  public final head         : HType;
  public var face(get,null) : HType;
  
  public function new(head,?face){
    this.head = head;
    this.face = face;
  }
  public function get_face(){
    return this.face == null ? head : face;
  }
}