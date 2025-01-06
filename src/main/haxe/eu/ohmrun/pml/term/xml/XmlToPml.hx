package eu.ohmrun.pml.term.xml;

private typedef MapItem = Tup2<PExpr<XmlData>,PExpr<XmlData>>;
private typedef MapMemo = { count : Int, rest : Cluster<Tup2<Option<String>,PExpr<XmlData>>> };

class XmlToPml{
  public function new(){}

  public function apply(xml:Xml):PExpr<XmlData>{
    function rec(xml:Xml):PExpr<XmlData>{
      //trace('rec');
      final type = xml.nodeType;
      //trace(type);
      return switch(type){
        case Element:
          //trace(xml);
          final assoc_data = xml.attributes().toIter().lfold(
            (next:String,memo:Cluster<Tup2<PExpr<XmlData>,PExpr<XmlData>>>) -> {
              trace(next);
              final val = xml.get(next);
              trace(val);
              return memo.snoc(tuple2(PLabel(next),PLabel(val)));
            },
            Cluster.unit()
          );
          final assoc = PAssoc(assoc_data);
          final rest = xml.iterator().toIter().lfold(
            (next:Xml,memo:MapMemo) -> {
              return switch(next.nodeType){
                case PCData : 
                  { count : memo.count + 1, rest : memo.rest.snoc(tuple2(None,PValue(XPCData(next.toString()))))};
                default     : 
                  trace(next.nodeType);
                  final name = next.nodeName;
                  trace(name);
                  final data = rec(next);
                  trace(data);
                  { count : memo.count, rest : memo.rest.snoc(tuple2(Some(name),data)) };
              }
            },
            { count : 0 , rest : Cluster.unit() }
          );
          final rhs = switch(rest.count){
            case 0 : 
              PAssoc(
                rest.rest.map(
                  (tup2) -> switch(tup2){
                    case tuple2(l,r) : tuple2(l.fold(
                      ok -> PLabel(ok),
                      () -> PEmpty
                    ),r);
                  }
                )
              );
            case 1 : 
              trace(rest.rest.size());
              switch(rest.rest.size()){
                case 1 : 
                  trace(rest.rest.head());
                  rest.rest.head().fold(
                    ok -> switch(ok){
                      case tuple2(None,x)     : x;
                      default                 : PEmpty;
                    },
                    () -> PEmpty
                  );
                default : PArray(rest.rest.map(
                  tup -> switch(tup){
                    case tuple2(Some(l),r)  : PGroup(Cons(PLabel(l),Cons(r,Nil)));
                    case tuple2(None,r)     : r;
                  }
                ));
              }
            default : PArray(rest.rest.map(
              tup -> switch(tup){
                case tuple2(Some(l),r)  : PGroup(Cons(PLabel(l),Cons(r,Nil)));
                case tuple2(None,r)     : r;
              }
            ));
          }
          assoc_data.length == 0 ? rhs : PGroup(Cons(assoc,Cons(rhs,Nil)));
          //trace(rest);
          //final data = PGroup(Cons(assoc,Cons(rest,Nil)));
          //data;
        case CData    : PValue(XCData(xml.toString()));
        case Comment  : PValue(XComment(xml.toString()));
        case DocType  : PValue(XDocType(xml.toString()));
        case Document :
          //trace(xml.frstChild());
          PArray(xml.iterator().toIter().lfold(
            (next:Xml,memo:Cluster<PExpr<XmlData>>) -> {
              trace(next);
              return memo.snoc(rec(next));
            },
            Cluster.unit()
          ));
        case PCData:
          PValue(XPCData(xml.toString()));
        case ProcessingInstruction:
          PValue(XProcessingInstruction(xml.toString()));
      }
    }
    return rec(xml);
  }
  public function strip_spaces(self:PExpr<XmlData>){
    static var r : EReg = ~/^\s+$/g;

    function rec(self:PExpr<XmlData>):Option<PExpr<XmlData>>{
      return switch(self){
        case PValue(XPCData(string))    : 
          r.match(string) ? None : Some(self);
        case PEmpty                       : Some(PEmpty);
        case PAssoc(map)                  : Some(PAssoc(map));
        case PSet(arr)                    : Some(PSet(arr.map_filter(rec)));
        case PArray(array)                : Some(PArray(array.map_filter(rec)));
        case PGroup(list)                 : Some(PGroup(list.map_filter(rec)));
        default                           : Some(self);
      }
    }
    return rec(self).defv(PEmpty);
  }
  // public function toAtom(self:PExpr<XmlData>):PExpr<Atom>{
  //   return swit
  // }
}