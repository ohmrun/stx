package stx.nano;

import haxe.ds.IntMap;
import stx.alias.StdString;
import stx.alias.StdMath;

@:using(stx.nano.Chars.CharsLift)
@:forward abstract Chars(StdString) from StdString to StdString{
  @:noUsing static public function lift(self:StdString){
    return new Chars(self);
  }
  
  private function new(self) this = self;

  @:op(A + A)
  public function add(that:Chars){
    return this + that;
  }
}
class CharsLift{
  static public function existishness(str:Null<String>):Bool{
    return switch(str){
      case ""     : false;
      case null   : false;
      default     : true;
    }
  }
  /**
  Returns `true` if `v` is `'true'` or `'1'`, `false` if `'false'` or `'0'` and `d` otherwise.
  **/
  static public function parse_bool(self: Chars): Option<Bool> {
    var vLower = self.toLowerCase();

    return switch([vLower,self]){
      case ['false',_] | [_,'0']  : Some(false);
      case ['true',_] | [_,'1']   : Some(true);
      default                     : None;
    }
  }

  static public function parse_int(self: Chars):Option<Int> {
    return 
      Option.make(std.Std.parseInt(self))
        .filter(function(i) return !Math.isNaN(i));
  }
  static public function parse_float(self: Chars):Option<Float> {
    return 
      Option.make(std.Std.parseFloat(self))
    .filter(function(i) return !Math.isNaN(i));
  }
  /**
    Returns `true` if `frag` is at the beginning of `v`, `false` otherwise.
  **/
  static public function starts_with(self: Chars,frag: Chars): Bool {
    return if (self.length >= frag.length && frag == self.substr(0, frag.length)) true else false;
  }
  /**
    Returns `true` if `frag` is at the end of `v`, `false` otherwise.
  **/
  static public function ends_with(self: Chars,frag: Chars): Bool {
    return if (self.length >= frag.length && frag == self.substr(self.length - frag.length)) true else false;
  }
  /**
    Returns true if v contains s, false otherwise.
  **/
  static public function contains(self: Chars,substr: Chars): Bool {
    return self.indexOf(substr) != -1;
  }
  /**
    Returns a Chars where sub is replaced by by in s.
  **/
  static public function replace(self : Chars,sub : Chars, by : Chars) : Chars {
    return StringTools.replace(self, sub, by);
  }
  /**
    Surrounds `v`, prepending `l` and concating `r`.
  **/
  static public function brackets(self:Chars,l:Chars,r:Chars){
    return '$l$self$r';
  }
  /**
    prepend `before` on `str.`
  **/
  static public function prepend(self:Chars,before:Chars){
    return before + self;
  }
  /**
    concat `before` on `str.`
  **/
  static public function append(self:Chars,after:Chars){
    return self + after;
  }
  /**
    Get character code from `str` at index `i`.
  **/
  static public function cca(self:Chars,i:Int){
    return self.charCodeAt(i);
  }
  static public function at(self:Chars,i:Int):Chars{
    return self.charAt(i);
  }
  /**
    Returns an Array of `str` divided into sections of length `len`.
  **/
  static public function chunk(self: Chars,len: Int = 1): Array<Chars> {
    var start = 0;
    var end   = StdMath.round(StdMath.min(start + len,self.length));

    return if (end == 0) [];
    else {
      var prefix = self.substr(start, end);
      var rest   = self.substr(end);

      [prefix].concat(chunk(rest,len));
    }
  }
  /**
    Returns an Array of the characters of `str`.
  **/
  static public function chars(self: Chars): Array<Chars> {
    var a = [];

    for (i in 0...self.length) {
      a.push(self.charAt(i));
    }

    return a;
  }
  static function AlphaUpperAlphaPattern()  return ~/-([a-z])([A-Z])/g;
  /**
    Turns a slugged or underscored string into a camelCase string.
  **/
  // public function toCamelCase(self: Chars): Chars {
  //   return SepAlphaPattern.map(self, function(e) { return e.matched(2).toUpperCase(); });
  // }
  /**
    Replaces uppercased letters with prefix `sep` + lowercase.
  **/
  // public function fromCamelCase_with(self: Chars,sep: Chars="_"): Chars {
  //   return AlphaUpperAlphaPattern.map(self, function(e) { return e.matched(1) + sep + e.matched(2).toLowerCase(); });
  // }
  static public function PascalcaseToSnakecase(self:Chars){
    
  }
  /**
    Split `st` at `sep`.
  **/
  static public function split(self:Chars,sep:Chars):Cluster<Chars>{
    return self.split(sep);
  }
  /**
    Strip whitespace out of a string.
  **/
  static public function strip_white( self : Chars ) : Chars {
    var l = self.length;
    var i = 0;
    var sb = new StringBuf();
    while( i < l ) {
      if(!is_space(self,i))
        sb.add(self.charAt(i));
      i++;
    }
    return sb.toString();
  }
  /**
    Continues to replace `sub` with `by` until no more instances of `sub` exist.
  **/
  static public function replace_recurse( self : Chars, sub : Chars, by : Chars ) : Chars {
    if(sub.length == 0)
      return replace(self, sub, by);
    if(by.indexOf(sub) >= 0)
      throw "Infinite recursion";
    var ns : Chars = self.toString();
    var olen = 0;
    var nlen = ns.length;
    while(olen != nlen) {
      olen = ns.length;
      replace(  sub, by, ns );
      nlen = ns.length;
    }
    return ns;
  }
  /**
    Returns an iter of `value`.
  **/
  static public function toIter(self : Chars) : Iter<Chars> {
    var index = 0;
    return Iter.make({
        hasNext: function() {
            return index < self.length;
        },
        next: function() {
            return if (index < self.length) {
                self.substr(index++, 1);
            } else {
              throw Fault.make().digest((_:Digests) -> _.e_undefined());
            }
        }
    });
  }
  /*
  static public function camelCaseToDashes(value : Chars) : Chars {
    var regexp = new EReg("([a-zA-Z])(?=[A-Z])", "g");
    return regexp.replace(value, "$1-");
  }

  static public function camelCaseToLowerCase(value : Chars, ?separator : Chars = "_") : Chars {
    var reg = new EReg("([^\\A])([A-Z])", "g");
    return reg.replace(value, '$1${separator}$2').toLowerCase();
  }
  */
  // static public function camelCaseToUpperCase(value : Chars, ?separator : Chars = "_") : Chars {
  //   var reg = new EReg("([^\\A])([A-Z])", "g");
  //   return reg.replace(value, '$1${separator}$2').toUpperCase();
  // }
  //https://github.com/haxeui/haxeui-core/blob/d13a7570d522f03b31aa42be72a5ed66dc3d8738/haxe/ui/util/StringUtil.hx
  public static function uncapitalize_first_letter(self:Chars):Chars {
    self = self.substr(0, 1).toLowerCase() + self.substr(1, self.length);
    return self;
  }
  public static function capitalize_first_letter(self:Chars):Chars {
      self = self.substr(0, 1).toUpperCase() + self.substr(1, self.length);
      return self;
  }

  public static function capitalize_hyphens(self:Chars):Chars {
      return capitalize_delim(self, "-");
  }

  public static function capitalize_delim(self:Chars, d:Chars):Chars {
      var r:String = self;
      var n:Int = r.indexOf(d);
      while (n != -1) {
          var before:String = r.substr(0, n);
          var after:String = r.substr(n + 1, r.length);
          r = before + capitalize_first_letter(after);
          n = r.indexOf(d, n + 1);
      }
      return r;
  }
  public static function to_dashes(self:Chars, toLower:Bool = true):Chars {
      var self = ~/([a-zA-Z])(?=[A-Z])/g.map(self, function(re:EReg):String {
          return '${re.matched(1)}-' ;
      });

      if (toLower == true) {
          self = self.toLowerCase();
      }

      return self;
  }

  public static function replace_vars(self:Chars, params:Map<String, Dynamic>):Chars {
      if (params != null) {
          for (k in params.keys()) {
              self = StringTools.replace(self, "${" + k + "}", params.get(k));
          }
      }
      return self;
  }

  static public function is_space(self : Chars, pos : Int ) : Bool {
    var c = self.charCodeAt( pos );
    return (c >= 9 && c <= 13) || c == 32;
  }
  static public function is_defined(self:Chars):Bool{
    return (self != '');
  }
  static public inline function chr(i:Int){
    return String.fromCharCode(i);
  }
  @thx
  static public function underscore(s : Chars):Chars {
    s = (~/::/g).replace(s, '/');
    s = (~/([A-Z]+)([A-Z][a-z])/g).replace(s, '$1_$2');
    s = (~/([a-z\d])([A-Z])/g).replace(s, '$1_$2');
    s = (~/-/g).replace(s, '_');
    return s.toLowerCase();
  }
  /**
  * Returns all characters from a that appear after the first occurence of sub, or,
  * if sub does not occur in a, empty string.
  **/
  static public function after(self: Chars,sub: Chars): Chars {
    var idx = self.indexOf(sub);
    if (idx < 0) return "";
    return self.substring(idx + sub.length, self.length);
  }
  /**
  * Returns all characters from a that appear before the first occurence of sub, or,
  * if sub does not occur in a, empty string.
  **/
  static public function before(self: Chars,sub: Chars): Chars {
    return self.substring(0, self.indexOf(sub));
  }
  static public function quote(str:Chars):Chars{
    return '\"$str\"';
  }
  static public function requote(self:Chars):Chars{
    return self.replace("\"","\\\"");
  }
  static public function truncate(self:Chars,int:Int):Chars{
    return self.substr(0,int);
  }
  static public function rdropn(self:Chars,int:Int):Chars{
    return self.substr(0,self.length-int);
  }
  static public function ldropn(self:Chars,int:Int):Chars{
    return self.substr(int);
  }

    /**
  * <pre><code>
  * >>> Int.of(" ").is_upper_case() == false
  * >>> Int.of("A").is_upper_case() == true
  * >>> Int.of("a").is_upper_case() == false
  * </code></pre>
  */
  static inline public function is_upper_case(self:Int):Bool
      return @:nullSafety(Off) CHAR_CASE_MAPPER.is_upper_case(self);
 
 // https://github.com/vegardit/haxe-strings/blob/a026c8c1d652d0197067659210d054c73de3453c/src/hx/strings/Int.hx#L569
  static final CHAR_CASE_MAPPER = new CharCaseMapper();
}
@:nullSafety(Off)
private class CharCaseMapper {
   final mapU2L = new IntMap<Int>();
   final mapL2U = new IntMap<Int>();


   function _addCaseMapping(lowerChar:Int, upperChar:Int) {
      // when multiple mappings exist we only use the first
      // upper for 0x69  (i) = 0x49 (I)
      // upper for 0x131 (ı) = 0x49 (I)
      if(!mapU2L.exists(upperChar)) mapU2L.set(upperChar, lowerChar);
      if(!mapL2U.exists(lowerChar)) mapL2U.set(lowerChar, upperChar);
   }

   inline
   public function is_lower_case(ch:Int):Bool
      return mapL2U.exists(ch);


   inline
   public function is_upper_case(ch:Int):Bool
      return mapU2L.exists(ch);


   #if !(lua||php) inline #end // TODO workaround for null-safety false positive
   public function toLowerCase(ch:Int):Int {
      final lowerChar = mapU2L.get(ch);
      return lowerChar == null ? ch : lowerChar;
   }


   #if !(lua||php) inline #end // TODO workaround for null-safety false positive
   public function toUpperCase(ch:Int):Int {
      final upperChar = mapL2U.get(ch);
      return upperChar == null ? ch : upperChar;
   }


   inline
   public function new() {
      // https://www.ibm.com/support/knowledgecenter/ssw_ibm_i_71/nls/rbagslowtoupmaptable.htm
      _addCaseMapping(0x0061, 0x0041);
      _addCaseMapping(0x0062, 0x0042);
      _addCaseMapping(0x0063, 0x0043);
      _addCaseMapping(0x0064, 0x0044);
      _addCaseMapping(0x0065, 0x0045);
      _addCaseMapping(0x0066, 0x0046);
      _addCaseMapping(0x0067, 0x0047);
      _addCaseMapping(0x0068, 0x0048);
      _addCaseMapping(0x0069, 0x0049);
      _addCaseMapping(0x006A, 0x004A);
      _addCaseMapping(0x006B, 0x004B);
      _addCaseMapping(0x006C, 0x004C);
      _addCaseMapping(0x006D, 0x004D);
      _addCaseMapping(0x006E, 0x004E);
      _addCaseMapping(0x006F, 0x004F);
      _addCaseMapping(0x0070, 0x0050);
      _addCaseMapping(0x0071, 0x0051);
      _addCaseMapping(0x0072, 0x0052);
      _addCaseMapping(0x0073, 0x0053);
      _addCaseMapping(0x0074, 0x0054);
      _addCaseMapping(0x0075, 0x0055);
      _addCaseMapping(0x0076, 0x0056);
      _addCaseMapping(0x0077, 0x0057);
      _addCaseMapping(0x0078, 0x0058);
      _addCaseMapping(0x0079, 0x0059);
      _addCaseMapping(0x007A, 0x005A);
      _addCaseMapping(0x00E0, 0x00C0);
      _addCaseMapping(0x00E1, 0x00C1);
      _addCaseMapping(0x00E2, 0x00C2);
      _addCaseMapping(0x00E3, 0x00C3);
      _addCaseMapping(0x00E4, 0x00C4);
      _addCaseMapping(0x00E5, 0x00C5);
      _addCaseMapping(0x00E6, 0x00C6);
      _addCaseMapping(0x00E7, 0x00C7);
      _addCaseMapping(0x00E8, 0x00C8);
      _addCaseMapping(0x00E9, 0x00C9);
      _addCaseMapping(0x00EA, 0x00CA);
      _addCaseMapping(0x00EB, 0x00CB);
      _addCaseMapping(0x00EC, 0x00CC);
      _addCaseMapping(0x00ED, 0x00CD);
      _addCaseMapping(0x00EE, 0x00CE);
      _addCaseMapping(0x00EF, 0x00CF);
      _addCaseMapping(0x00F0, 0x00D0);
      _addCaseMapping(0x00F1, 0x00D1);
      _addCaseMapping(0x00F2, 0x00D2);
      _addCaseMapping(0x00F3, 0x00D3);
      _addCaseMapping(0x00F4, 0x00D4);
      _addCaseMapping(0x00F5, 0x00D5);
      _addCaseMapping(0x00F6, 0x00D6);
      _addCaseMapping(0x00F8, 0x00D8);
      _addCaseMapping(0x00F9, 0x00D9);
      _addCaseMapping(0x00FA, 0x00DA);
      _addCaseMapping(0x00FB, 0x00DB);
      _addCaseMapping(0x00FC, 0x00DC);
      _addCaseMapping(0x00FD, 0x00DD);
      _addCaseMapping(0x00FE, 0x00DE);
      _addCaseMapping(0x00FF, 0x0178);
      _addCaseMapping(0x0101, 0x0100);
      _addCaseMapping(0x0103, 0x0102);
      _addCaseMapping(0x0105, 0x0104);
      _addCaseMapping(0x0107, 0x0106);
      _addCaseMapping(0x0109, 0x0108);
      _addCaseMapping(0x010B, 0x010A);
      _addCaseMapping(0x010D, 0x010C);
      _addCaseMapping(0x010F, 0x010E);
      _addCaseMapping(0x0111, 0x0110);
      _addCaseMapping(0x0113, 0x0112);
      _addCaseMapping(0x0115, 0x0114);
      _addCaseMapping(0x0117, 0x0116);
      _addCaseMapping(0x0119, 0x0118);
      _addCaseMapping(0x011B, 0x011A);
      _addCaseMapping(0x011D, 0x011C);
      _addCaseMapping(0x011F, 0x011E);
      _addCaseMapping(0x0121, 0x0120);
      _addCaseMapping(0x0123, 0x0122);
      _addCaseMapping(0x0125, 0x0124);
      _addCaseMapping(0x0127, 0x0126);
      _addCaseMapping(0x0129, 0x0128);
      _addCaseMapping(0x012B, 0x012A);
      _addCaseMapping(0x012D, 0x012C);
      _addCaseMapping(0x012F, 0x012E);
      _addCaseMapping(0x0131, 0x0049);
      _addCaseMapping(0x0133, 0x0132);
      _addCaseMapping(0x0135, 0x0134);
      _addCaseMapping(0x0137, 0x0136);
      _addCaseMapping(0x013A, 0x0139);
      _addCaseMapping(0x013C, 0x013B);
      _addCaseMapping(0x013E, 0x013D);
      _addCaseMapping(0x0140, 0x013F);
      _addCaseMapping(0x0142, 0x0141);
      _addCaseMapping(0x0144, 0x0143);
      _addCaseMapping(0x0146, 0x0145);
      _addCaseMapping(0x0148, 0x0147);
      _addCaseMapping(0x014B, 0x014A);
      _addCaseMapping(0x014D, 0x014C);
      _addCaseMapping(0x014F, 0x014E);
      _addCaseMapping(0x0151, 0x0150);
      _addCaseMapping(0x0153, 0x0152);
      _addCaseMapping(0x0155, 0x0154);
      _addCaseMapping(0x0157, 0x0156);
      _addCaseMapping(0x0159, 0x0158);
      _addCaseMapping(0x015B, 0x015A);
      _addCaseMapping(0x015D, 0x015C);
      _addCaseMapping(0x015F, 0x015E);
      _addCaseMapping(0x0161, 0x0160);
      _addCaseMapping(0x0163, 0x0162);
      _addCaseMapping(0x0165, 0x0164);
      _addCaseMapping(0x0167, 0x0166);
      _addCaseMapping(0x0169, 0x0168);
      _addCaseMapping(0x016B, 0x016A);
      _addCaseMapping(0x016D, 0x016C);
      _addCaseMapping(0x016F, 0x016E);
      _addCaseMapping(0x0171, 0x0170);
      _addCaseMapping(0x0173, 0x0172);
      _addCaseMapping(0x0175, 0x0174);
      _addCaseMapping(0x0177, 0x0176);
      _addCaseMapping(0x017A, 0x0179);
      _addCaseMapping(0x017C, 0x017B);
      _addCaseMapping(0x017E, 0x017D);
      _addCaseMapping(0x0183, 0x0182);
      _addCaseMapping(0x0185, 0x0184);
      _addCaseMapping(0x0188, 0x0187);
      _addCaseMapping(0x018C, 0x018B);
      _addCaseMapping(0x0192, 0x0191);
      _addCaseMapping(0x0199, 0x0198);
      _addCaseMapping(0x01A1, 0x01A0);
      _addCaseMapping(0x01A3, 0x01A2);
      _addCaseMapping(0x01A5, 0x01A4);
      _addCaseMapping(0x01A8, 0x01A7);
      _addCaseMapping(0x01AD, 0x01AC);
      _addCaseMapping(0x01B0, 0x01AF);
      _addCaseMapping(0x01B4, 0x01B3);
      _addCaseMapping(0x01B6, 0x01B5);
      _addCaseMapping(0x01B9, 0x01B8);
      _addCaseMapping(0x01BD, 0x01BC);
      _addCaseMapping(0x01C6, 0x01C4);
      _addCaseMapping(0x01C9, 0x01C7);
      _addCaseMapping(0x01CC, 0x01CA);
      _addCaseMapping(0x01CE, 0x01CD);
      _addCaseMapping(0x01D0, 0x01CF);
      _addCaseMapping(0x01D2, 0x01D1);
      _addCaseMapping(0x01D4, 0x01D3);
      _addCaseMapping(0x01D6, 0x01D5);
      _addCaseMapping(0x01D8, 0x01D7);
      _addCaseMapping(0x01DA, 0x01D9);
      _addCaseMapping(0x01DC, 0x01DB);
      _addCaseMapping(0x01DF, 0x01DE);
      _addCaseMapping(0x01E1, 0x01E0);
      _addCaseMapping(0x01E3, 0x01E2);
      _addCaseMapping(0x01E5, 0x01E4);
      _addCaseMapping(0x01E7, 0x01E6);
      _addCaseMapping(0x01E9, 0x01E8);
      _addCaseMapping(0x01EB, 0x01EA);
      _addCaseMapping(0x01ED, 0x01EC);
      _addCaseMapping(0x01EF, 0x01EE);
      _addCaseMapping(0x01F3, 0x01F1);
      _addCaseMapping(0x01F5, 0x01F4);
      _addCaseMapping(0x01FB, 0x01FA);
      _addCaseMapping(0x01FD, 0x01FC);
      _addCaseMapping(0x01FF, 0x01FE);
      _addCaseMapping(0x0201, 0x0200);
      _addCaseMapping(0x0203, 0x0202);
      _addCaseMapping(0x0205, 0x0204);
      _addCaseMapping(0x0207, 0x0206);
      _addCaseMapping(0x0209, 0x0208);
      _addCaseMapping(0x020B, 0x020A);
      _addCaseMapping(0x020D, 0x020C);
      _addCaseMapping(0x020F, 0x020E);
      _addCaseMapping(0x0211, 0x0210);
      _addCaseMapping(0x0213, 0x0212);
      _addCaseMapping(0x0215, 0x0214);
      _addCaseMapping(0x0217, 0x0216);
      _addCaseMapping(0x0253, 0x0181);
      _addCaseMapping(0x0254, 0x0186);
      _addCaseMapping(0x0257, 0x018A);
      _addCaseMapping(0x0258, 0x018E);
      _addCaseMapping(0x0259, 0x018F);
      _addCaseMapping(0x025B, 0x0190);
      _addCaseMapping(0x0260, 0x0193);
      _addCaseMapping(0x0263, 0x0194);
      _addCaseMapping(0x0268, 0x0197);
      _addCaseMapping(0x0269, 0x0196);
      _addCaseMapping(0x026F, 0x019C);
      _addCaseMapping(0x0272, 0x019D);
      _addCaseMapping(0x0275, 0x019F);
      _addCaseMapping(0x0283, 0x01A9);
      _addCaseMapping(0x0288, 0x01AE);
      _addCaseMapping(0x028A, 0x01B1);
      _addCaseMapping(0x028B, 0x01B2);
      _addCaseMapping(0x0292, 0x01B7);
      _addCaseMapping(0x039C, 0x00B5); // http://www.fileformat.info/info/unicode/char/b5/index.htm
      _addCaseMapping(0x03AC, 0x0386);
      _addCaseMapping(0x03AD, 0x0388);
      _addCaseMapping(0x03AE, 0x0389);
      _addCaseMapping(0x03AF, 0x038A);
      _addCaseMapping(0x03B1, 0x0391);
      _addCaseMapping(0x03B2, 0x0392);
      _addCaseMapping(0x03B3, 0x0393);
      _addCaseMapping(0x03B4, 0x0394);
      _addCaseMapping(0x03B5, 0x0395);
      _addCaseMapping(0x03B6, 0x0396);
      _addCaseMapping(0x03B7, 0x0397);
      _addCaseMapping(0x03B8, 0x0398);
      _addCaseMapping(0x03B9, 0x0399);
      _addCaseMapping(0x03BA, 0x039A);
      _addCaseMapping(0x03BB, 0x039B);
      _addCaseMapping(0x03BC, 0x039C);
      _addCaseMapping(0x03BD, 0x039D);
      _addCaseMapping(0x03BE, 0x039E);
      _addCaseMapping(0x03BF, 0x039F);
      _addCaseMapping(0x03C0, 0x03A0);
      _addCaseMapping(0x03C1, 0x03A1);
      _addCaseMapping(0x03C3, 0x03A3);
      _addCaseMapping(0x03C4, 0x03A4);
      _addCaseMapping(0x03C5, 0x03A5);
      _addCaseMapping(0x03C6, 0x03A6);
      _addCaseMapping(0x03C7, 0x03A7);
      _addCaseMapping(0x03C8, 0x03A8);
      _addCaseMapping(0x03C9, 0x03A9);
      _addCaseMapping(0x03CA, 0x03AA);
      _addCaseMapping(0x03CB, 0x03AB);
      _addCaseMapping(0x03CC, 0x038C);
      _addCaseMapping(0x03CD, 0x038E);
      _addCaseMapping(0x03CE, 0x038F);
      _addCaseMapping(0x03E3, 0x03E2);
      _addCaseMapping(0x03E5, 0x03E4);
      _addCaseMapping(0x03E7, 0x03E6);
      _addCaseMapping(0x03E9, 0x03E8);
      _addCaseMapping(0x03EB, 0x03EA);
      _addCaseMapping(0x03ED, 0x03EC);
      _addCaseMapping(0x03EF, 0x03EE);
      _addCaseMapping(0x0430, 0x0410);
      _addCaseMapping(0x0431, 0x0411);
      _addCaseMapping(0x0432, 0x0412);
      _addCaseMapping(0x0433, 0x0413);
      _addCaseMapping(0x0434, 0x0414);
      _addCaseMapping(0x0435, 0x0415);
      _addCaseMapping(0x0436, 0x0416);
      _addCaseMapping(0x0437, 0x0417);
      _addCaseMapping(0x0438, 0x0418);
      _addCaseMapping(0x0439, 0x0419);
      _addCaseMapping(0x043A, 0x041A);
      _addCaseMapping(0x043B, 0x041B);
      _addCaseMapping(0x043C, 0x041C);
      _addCaseMapping(0x043D, 0x041D);
      _addCaseMapping(0x043E, 0x041E);
      _addCaseMapping(0x043F, 0x041F);
      _addCaseMapping(0x0440, 0x0420);
      _addCaseMapping(0x0441, 0x0421);
      _addCaseMapping(0x0442, 0x0422);
      _addCaseMapping(0x0443, 0x0423);
      _addCaseMapping(0x0444, 0x0424);
      _addCaseMapping(0x0445, 0x0425);
      _addCaseMapping(0x0446, 0x0426);
      _addCaseMapping(0x0447, 0x0427);
      _addCaseMapping(0x0448, 0x0428);
      _addCaseMapping(0x0449, 0x0429);
      _addCaseMapping(0x044A, 0x042A);
      _addCaseMapping(0x044B, 0x042B);
      _addCaseMapping(0x044C, 0x042C);
      _addCaseMapping(0x044D, 0x042D);
      _addCaseMapping(0x044E, 0x042E);
      _addCaseMapping(0x044F, 0x042F);
      _addCaseMapping(0x0451, 0x0401);
      _addCaseMapping(0x0452, 0x0402);
      _addCaseMapping(0x0453, 0x0403);
      _addCaseMapping(0x0454, 0x0404);
      _addCaseMapping(0x0455, 0x0405);
      _addCaseMapping(0x0456, 0x0406);
      _addCaseMapping(0x0457, 0x0407);
      _addCaseMapping(0x0458, 0x0408);
      _addCaseMapping(0x0459, 0x0409);
      _addCaseMapping(0x045A, 0x040A);
      _addCaseMapping(0x045B, 0x040B);
      _addCaseMapping(0x045C, 0x040C);
      _addCaseMapping(0x045E, 0x040E);
      _addCaseMapping(0x045F, 0x040F);
      _addCaseMapping(0x0461, 0x0460);
      _addCaseMapping(0x0463, 0x0462);
      _addCaseMapping(0x0465, 0x0464);
      _addCaseMapping(0x0467, 0x0466);
      _addCaseMapping(0x0469, 0x0468);
      _addCaseMapping(0x046B, 0x046A);
      _addCaseMapping(0x046D, 0x046C);
      _addCaseMapping(0x046F, 0x046E);
      _addCaseMapping(0x0471, 0x0470);
      _addCaseMapping(0x0473, 0x0472);
      _addCaseMapping(0x0475, 0x0474);
      _addCaseMapping(0x0477, 0x0476);
      _addCaseMapping(0x0479, 0x0478);
      _addCaseMapping(0x047B, 0x047A);
      _addCaseMapping(0x047D, 0x047C);
      _addCaseMapping(0x047F, 0x047E);
      _addCaseMapping(0x0481, 0x0480);
      _addCaseMapping(0x0491, 0x0490);
      _addCaseMapping(0x0493, 0x0492);
      _addCaseMapping(0x0495, 0x0494);
      _addCaseMapping(0x0497, 0x0496);
      _addCaseMapping(0x0499, 0x0498);
      _addCaseMapping(0x049B, 0x049A);
      _addCaseMapping(0x049D, 0x049C);
      _addCaseMapping(0x049F, 0x049E);
      _addCaseMapping(0x04A1, 0x04A0);
      _addCaseMapping(0x04A3, 0x04A2);
      _addCaseMapping(0x04A5, 0x04A4);
      _addCaseMapping(0x04A7, 0x04A6);
      _addCaseMapping(0x04A9, 0x04A8);
      _addCaseMapping(0x04AB, 0x04AA);
      _addCaseMapping(0x04AD, 0x04AC);
      _addCaseMapping(0x04AF, 0x04AE);
      _addCaseMapping(0x04B1, 0x04B0);
      _addCaseMapping(0x04B3, 0x04B2);
      _addCaseMapping(0x04B5, 0x04B4);
      _addCaseMapping(0x04B7, 0x04B6);
      _addCaseMapping(0x04B9, 0x04B8);
      _addCaseMapping(0x04BB, 0x04BA);
      _addCaseMapping(0x04BD, 0x04BC);
      _addCaseMapping(0x04BF, 0x04BE);
      _addCaseMapping(0x04C2, 0x04C1);
      _addCaseMapping(0x04C4, 0x04C3);
      _addCaseMapping(0x04C8, 0x04C7);
      _addCaseMapping(0x04CC, 0x04CB);
      _addCaseMapping(0x04D1, 0x04D0);
      _addCaseMapping(0x04D3, 0x04D2);
      _addCaseMapping(0x04D5, 0x04D4);
      _addCaseMapping(0x04D7, 0x04D6);
      _addCaseMapping(0x04D9, 0x04D8);
      _addCaseMapping(0x04DB, 0x04DA);
      _addCaseMapping(0x04DD, 0x04DC);
      _addCaseMapping(0x04DF, 0x04DE);
      _addCaseMapping(0x04E1, 0x04E0);
      _addCaseMapping(0x04E3, 0x04E2);
      _addCaseMapping(0x04E5, 0x04E4);
      _addCaseMapping(0x04E7, 0x04E6);
      _addCaseMapping(0x04E9, 0x04E8);
      _addCaseMapping(0x04EB, 0x04EA);
      _addCaseMapping(0x04EF, 0x04EE);
      _addCaseMapping(0x04F1, 0x04F0);
      _addCaseMapping(0x04F3, 0x04F2);
      _addCaseMapping(0x04F5, 0x04F4);
      _addCaseMapping(0x04F9, 0x04F8);
      _addCaseMapping(0x0561, 0x0531);
      _addCaseMapping(0x0562, 0x0532);
      _addCaseMapping(0x0563, 0x0533);
      _addCaseMapping(0x0564, 0x0534);
      _addCaseMapping(0x0565, 0x0535);
      _addCaseMapping(0x0566, 0x0536);
      _addCaseMapping(0x0567, 0x0537);
      _addCaseMapping(0x0568, 0x0538);
      _addCaseMapping(0x0569, 0x0539);
      _addCaseMapping(0x056A, 0x053A);
      _addCaseMapping(0x056B, 0x053B);
      _addCaseMapping(0x056C, 0x053C);
      _addCaseMapping(0x056D, 0x053D);
      _addCaseMapping(0x056E, 0x053E);
      _addCaseMapping(0x056F, 0x053F);
      _addCaseMapping(0x0570, 0x0540);
      _addCaseMapping(0x0571, 0x0541);
      _addCaseMapping(0x0572, 0x0542);
      _addCaseMapping(0x0573, 0x0543);
      _addCaseMapping(0x0574, 0x0544);
      _addCaseMapping(0x0575, 0x0545);
      _addCaseMapping(0x0576, 0x0546);
      _addCaseMapping(0x0577, 0x0547);
      _addCaseMapping(0x0578, 0x0548);
      _addCaseMapping(0x0579, 0x0549);
      _addCaseMapping(0x057A, 0x054A);
      _addCaseMapping(0x057B, 0x054B);
      _addCaseMapping(0x057C, 0x054C);
      _addCaseMapping(0x057D, 0x054D);
      _addCaseMapping(0x057E, 0x054E);
      _addCaseMapping(0x057F, 0x054F);
      _addCaseMapping(0x0580, 0x0550);
      _addCaseMapping(0x0581, 0x0551);
      _addCaseMapping(0x0582, 0x0552);
      _addCaseMapping(0x0583, 0x0553);
      _addCaseMapping(0x0584, 0x0554);
      _addCaseMapping(0x0585, 0x0555);
      _addCaseMapping(0x0586, 0x0556);
      _addCaseMapping(0x10D0, 0x10A0);
      _addCaseMapping(0x10D1, 0x10A1);
      _addCaseMapping(0x10D2, 0x10A2);
      _addCaseMapping(0x10D3, 0x10A3);
      _addCaseMapping(0x10D4, 0x10A4);
      _addCaseMapping(0x10D5, 0x10A5);
      _addCaseMapping(0x10D6, 0x10A6);
      _addCaseMapping(0x10D7, 0x10A7);
      _addCaseMapping(0x10D8, 0x10A8);
      _addCaseMapping(0x10D9, 0x10A9);
      _addCaseMapping(0x10DA, 0x10AA);
      _addCaseMapping(0x10DB, 0x10AB);
      _addCaseMapping(0x10DC, 0x10AC);
      _addCaseMapping(0x10DD, 0x10AD);
      _addCaseMapping(0x10DE, 0x10AE);
      _addCaseMapping(0x10DF, 0x10AF);
      _addCaseMapping(0x10E0, 0x10B0);
      _addCaseMapping(0x10E1, 0x10B1);
      _addCaseMapping(0x10E2, 0x10B2);
      _addCaseMapping(0x10E3, 0x10B3);
      _addCaseMapping(0x10E4, 0x10B4);
      _addCaseMapping(0x10E5, 0x10B5);
      _addCaseMapping(0x10E6, 0x10B6);
      _addCaseMapping(0x10E7, 0x10B7);
      _addCaseMapping(0x10E8, 0x10B8);
      _addCaseMapping(0x10E9, 0x10B9);
      _addCaseMapping(0x10EA, 0x10BA);
      _addCaseMapping(0x10EB, 0x10BB);
      _addCaseMapping(0x10EC, 0x10BC);
      _addCaseMapping(0x10ED, 0x10BD);
      _addCaseMapping(0x10EE, 0x10BE);
      _addCaseMapping(0x10EF, 0x10BF);
      _addCaseMapping(0x10F0, 0x10C0);
      _addCaseMapping(0x10F1, 0x10C1);
      _addCaseMapping(0x10F2, 0x10C2);
      _addCaseMapping(0x10F3, 0x10C3);
      _addCaseMapping(0x10F4, 0x10C4);
      _addCaseMapping(0x10F5, 0x10C5);
      _addCaseMapping(0x1E01, 0x1E00);
      _addCaseMapping(0x1E03, 0x1E02);
      _addCaseMapping(0x1E05, 0x1E04);
      _addCaseMapping(0x1E07, 0x1E06);
      _addCaseMapping(0x1E09, 0x1E08);
      _addCaseMapping(0x1E0B, 0x1E0A);
      _addCaseMapping(0x1E0D, 0x1E0C);
      _addCaseMapping(0x1E0F, 0x1E0E);
      _addCaseMapping(0x1E11, 0x1E10);
      _addCaseMapping(0x1E13, 0x1E12);
      _addCaseMapping(0x1E15, 0x1E14);
      _addCaseMapping(0x1E17, 0x1E16);
      _addCaseMapping(0x1E19, 0x1E18);
      _addCaseMapping(0x1E1B, 0x1E1A);
      _addCaseMapping(0x1E1D, 0x1E1C);
      _addCaseMapping(0x1E1F, 0x1E1E);
      _addCaseMapping(0x1E21, 0x1E20);
      _addCaseMapping(0x1E23, 0x1E22);
      _addCaseMapping(0x1E25, 0x1E24);
      _addCaseMapping(0x1E27, 0x1E26);
      _addCaseMapping(0x1E29, 0x1E28);
      _addCaseMapping(0x1E2B, 0x1E2A);
      _addCaseMapping(0x1E2D, 0x1E2C);
      _addCaseMapping(0x1E2F, 0x1E2E);
      _addCaseMapping(0x1E31, 0x1E30);
      _addCaseMapping(0x1E33, 0x1E32);
      _addCaseMapping(0x1E35, 0x1E34);
      _addCaseMapping(0x1E37, 0x1E36);
      _addCaseMapping(0x1E39, 0x1E38);
      _addCaseMapping(0x1E3B, 0x1E3A);
      _addCaseMapping(0x1E3D, 0x1E3C);
      _addCaseMapping(0x1E3F, 0x1E3E);
      _addCaseMapping(0x1E41, 0x1E40);
      _addCaseMapping(0x1E43, 0x1E42);
      _addCaseMapping(0x1E45, 0x1E44);
      _addCaseMapping(0x1E47, 0x1E46);
      _addCaseMapping(0x1E49, 0x1E48);
      _addCaseMapping(0x1E4B, 0x1E4A);
      _addCaseMapping(0x1E4D, 0x1E4C);
      _addCaseMapping(0x1E4F, 0x1E4E);
      _addCaseMapping(0x1E51, 0x1E50);
      _addCaseMapping(0x1E53, 0x1E52);
      _addCaseMapping(0x1E55, 0x1E54);
      _addCaseMapping(0x1E57, 0x1E56);
      _addCaseMapping(0x1E59, 0x1E58);
      _addCaseMapping(0x1E5B, 0x1E5A);
      _addCaseMapping(0x1E5D, 0x1E5C);
      _addCaseMapping(0x1E5F, 0x1E5E);
      _addCaseMapping(0x1E61, 0x1E60);
      _addCaseMapping(0x1E63, 0x1E62);
      _addCaseMapping(0x1E65, 0x1E64);
      _addCaseMapping(0x1E67, 0x1E66);
      _addCaseMapping(0x1E69, 0x1E68);
      _addCaseMapping(0x1E6B, 0x1E6A);
      _addCaseMapping(0x1E6D, 0x1E6C);
      _addCaseMapping(0x1E6F, 0x1E6E);
      _addCaseMapping(0x1E71, 0x1E70);
      _addCaseMapping(0x1E73, 0x1E72);
      _addCaseMapping(0x1E75, 0x1E74);
      _addCaseMapping(0x1E77, 0x1E76);
      _addCaseMapping(0x1E79, 0x1E78);
      _addCaseMapping(0x1E7B, 0x1E7A);
      _addCaseMapping(0x1E7D, 0x1E7C);
      _addCaseMapping(0x1E7F, 0x1E7E);
      _addCaseMapping(0x1E81, 0x1E80);
      _addCaseMapping(0x1E83, 0x1E82);
      _addCaseMapping(0x1E85, 0x1E84);
      _addCaseMapping(0x1E87, 0x1E86);
      _addCaseMapping(0x1E89, 0x1E88);
      _addCaseMapping(0x1E8B, 0x1E8A);
      _addCaseMapping(0x1E8D, 0x1E8C);
      _addCaseMapping(0x1E8F, 0x1E8E);
      _addCaseMapping(0x1E91, 0x1E90);
      _addCaseMapping(0x1E93, 0x1E92);
      _addCaseMapping(0x1E95, 0x1E94);
      _addCaseMapping(0x1EA1, 0x1EA0);
      _addCaseMapping(0x1EA3, 0x1EA2);
      _addCaseMapping(0x1EA5, 0x1EA4);
      _addCaseMapping(0x1EA7, 0x1EA6);
      _addCaseMapping(0x1EA9, 0x1EA8);
      _addCaseMapping(0x1EAB, 0x1EAA);
      _addCaseMapping(0x1EAD, 0x1EAC);
      _addCaseMapping(0x1EAF, 0x1EAE);
      _addCaseMapping(0x1EB1, 0x1EB0);
      _addCaseMapping(0x1EB3, 0x1EB2);
      _addCaseMapping(0x1EB5, 0x1EB4);
      _addCaseMapping(0x1EB7, 0x1EB6);
      _addCaseMapping(0x1EB9, 0x1EB8);
      _addCaseMapping(0x1EBB, 0x1EBA);
      _addCaseMapping(0x1EBD, 0x1EBC);
      _addCaseMapping(0x1EBF, 0x1EBE);
      _addCaseMapping(0x1EC1, 0x1EC0);
      _addCaseMapping(0x1EC3, 0x1EC2);
      _addCaseMapping(0x1EC5, 0x1EC4);
      _addCaseMapping(0x1EC7, 0x1EC6);
      _addCaseMapping(0x1EC9, 0x1EC8);
      _addCaseMapping(0x1ECB, 0x1ECA);
      _addCaseMapping(0x1ECD, 0x1ECC);
      _addCaseMapping(0x1ECF, 0x1ECE);
      _addCaseMapping(0x1ED1, 0x1ED0);
      _addCaseMapping(0x1ED3, 0x1ED2);
      _addCaseMapping(0x1ED5, 0x1ED4);
      _addCaseMapping(0x1ED7, 0x1ED6);
      _addCaseMapping(0x1ED9, 0x1ED8);
      _addCaseMapping(0x1EDB, 0x1EDA);
      _addCaseMapping(0x1EDD, 0x1EDC);
      _addCaseMapping(0x1EDF, 0x1EDE);
      _addCaseMapping(0x1EE1, 0x1EE0);
      _addCaseMapping(0x1EE3, 0x1EE2);
      _addCaseMapping(0x1EE5, 0x1EE4);
      _addCaseMapping(0x1EE7, 0x1EE6);
      _addCaseMapping(0x1EE9, 0x1EE8);
      _addCaseMapping(0x1EEB, 0x1EEA);
      _addCaseMapping(0x1EED, 0x1EEC);
      _addCaseMapping(0x1EEF, 0x1EEE);
      _addCaseMapping(0x1EF1, 0x1EF0);
      _addCaseMapping(0x1EF3, 0x1EF2);
      _addCaseMapping(0x1EF5, 0x1EF4);
      _addCaseMapping(0x1EF7, 0x1EF6);
      _addCaseMapping(0x1EF9, 0x1EF8);
      _addCaseMapping(0x1F00, 0x1F08);
      _addCaseMapping(0x1F01, 0x1F09);
      _addCaseMapping(0x1F02, 0x1F0A);
      _addCaseMapping(0x1F03, 0x1F0B);
      _addCaseMapping(0x1F04, 0x1F0C);
      _addCaseMapping(0x1F05, 0x1F0D);
      _addCaseMapping(0x1F06, 0x1F0E);
      _addCaseMapping(0x1F07, 0x1F0F);
      _addCaseMapping(0x1F10, 0x1F18);
      _addCaseMapping(0x1F11, 0x1F19);
      _addCaseMapping(0x1F12, 0x1F1A);
      _addCaseMapping(0x1F13, 0x1F1B);
      _addCaseMapping(0x1F14, 0x1F1C);
      _addCaseMapping(0x1F15, 0x1F1D);
      _addCaseMapping(0x1F20, 0x1F28);
      _addCaseMapping(0x1F21, 0x1F29);
      _addCaseMapping(0x1F22, 0x1F2A);
      _addCaseMapping(0x1F23, 0x1F2B);
      _addCaseMapping(0x1F24, 0x1F2C);
      _addCaseMapping(0x1F25, 0x1F2D);
      _addCaseMapping(0x1F26, 0x1F2E);
      _addCaseMapping(0x1F27, 0x1F2F);
      _addCaseMapping(0x1F30, 0x1F38);
      _addCaseMapping(0x1F31, 0x1F39);
      _addCaseMapping(0x1F32, 0x1F3A);
      _addCaseMapping(0x1F33, 0x1F3B);
      _addCaseMapping(0x1F34, 0x1F3C);
      _addCaseMapping(0x1F35, 0x1F3D);
      _addCaseMapping(0x1F36, 0x1F3E);
      _addCaseMapping(0x1F37, 0x1F3F);
      _addCaseMapping(0x1F40, 0x1F48);
      _addCaseMapping(0x1F41, 0x1F49);
      _addCaseMapping(0x1F42, 0x1F4A);
      _addCaseMapping(0x1F43, 0x1F4B);
      _addCaseMapping(0x1F44, 0x1F4C);
      _addCaseMapping(0x1F45, 0x1F4D);
      _addCaseMapping(0x1F51, 0x1F59);
      _addCaseMapping(0x1F53, 0x1F5B);
      _addCaseMapping(0x1F55, 0x1F5D);
      _addCaseMapping(0x1F57, 0x1F5F);
      _addCaseMapping(0x1F60, 0x1F68);
      _addCaseMapping(0x1F61, 0x1F69);
      _addCaseMapping(0x1F62, 0x1F6A);
      _addCaseMapping(0x1F63, 0x1F6B);
      _addCaseMapping(0x1F64, 0x1F6C);
      _addCaseMapping(0x1F65, 0x1F6D);
      _addCaseMapping(0x1F66, 0x1F6E);
      _addCaseMapping(0x1F67, 0x1F6F);
      _addCaseMapping(0x1F80, 0x1F88);
      _addCaseMapping(0x1F81, 0x1F89);
      _addCaseMapping(0x1F82, 0x1F8A);
      _addCaseMapping(0x1F83, 0x1F8B);
      _addCaseMapping(0x1F84, 0x1F8C);
      _addCaseMapping(0x1F85, 0x1F8D);
      _addCaseMapping(0x1F86, 0x1F8E);
      _addCaseMapping(0x1F87, 0x1F8F);
      _addCaseMapping(0x1F90, 0x1F98);
      _addCaseMapping(0x1F91, 0x1F99);
      _addCaseMapping(0x1F92, 0x1F9A);
      _addCaseMapping(0x1F93, 0x1F9B);
      _addCaseMapping(0x1F94, 0x1F9C);
      _addCaseMapping(0x1F95, 0x1F9D);
      _addCaseMapping(0x1F96, 0x1F9E);
      _addCaseMapping(0x1F97, 0x1F9F);
      _addCaseMapping(0x1FA0, 0x1FA8);
      _addCaseMapping(0x1FA1, 0x1FA9);
      _addCaseMapping(0x1FA2, 0x1FAA);
      _addCaseMapping(0x1FA3, 0x1FAB);
      _addCaseMapping(0x1FA4, 0x1FAC);
      _addCaseMapping(0x1FA5, 0x1FAD);
      _addCaseMapping(0x1FA6, 0x1FAE);
      _addCaseMapping(0x1FA7, 0x1FAF);
      _addCaseMapping(0x1FB0, 0x1FB8);
      _addCaseMapping(0x1FB1, 0x1FB9);
      _addCaseMapping(0x1FD0, 0x1FD8);
      _addCaseMapping(0x1FD1, 0x1FD9);
      _addCaseMapping(0x1FE0, 0x1FE8);
      _addCaseMapping(0x1FE1, 0x1FE9);
      _addCaseMapping(0x24D0, 0x24B6);
      _addCaseMapping(0x24D1, 0x24B7);
      _addCaseMapping(0x24D2, 0x24B8);
      _addCaseMapping(0x24D3, 0x24B9);
      _addCaseMapping(0x24D4, 0x24BA);
      _addCaseMapping(0x24D5, 0x24BB);
      _addCaseMapping(0x24D6, 0x24BC);
      _addCaseMapping(0x24D7, 0x24BD);
      _addCaseMapping(0x24D8, 0x24BE);
      _addCaseMapping(0x24D9, 0x24BF);
      _addCaseMapping(0x24DA, 0x24C0);
      _addCaseMapping(0x24DB, 0x24C1);
      _addCaseMapping(0x24DC, 0x24C2);
      _addCaseMapping(0x24DD, 0x24C3);
      _addCaseMapping(0x24DE, 0x24C4);
      _addCaseMapping(0x24DF, 0x24C5);
      _addCaseMapping(0x24E0, 0x24C6);
      _addCaseMapping(0x24E1, 0x24C7);
      _addCaseMapping(0x24E2, 0x24C8);
      _addCaseMapping(0x24E3, 0x24C9);
      _addCaseMapping(0x24E4, 0x24CA);
      _addCaseMapping(0x24E5, 0x24CB);
      _addCaseMapping(0x24E6, 0x24CC);
      _addCaseMapping(0x24E7, 0x24CD);
      _addCaseMapping(0x24E8, 0x24CE);
      _addCaseMapping(0x24E9, 0x24CF);
      _addCaseMapping(0xFF41, 0xFF21);
      _addCaseMapping(0xFF42, 0xFF22);
      _addCaseMapping(0xFF43, 0xFF23);
      _addCaseMapping(0xFF44, 0xFF24);
      _addCaseMapping(0xFF45, 0xFF25);
      _addCaseMapping(0xFF46, 0xFF26);
      _addCaseMapping(0xFF47, 0xFF27);
      _addCaseMapping(0xFF48, 0xFF28);
      _addCaseMapping(0xFF49, 0xFF29);
      _addCaseMapping(0xFF4A, 0xFF2A);
      _addCaseMapping(0xFF4B, 0xFF2B);
      _addCaseMapping(0xFF4C, 0xFF2C);
      _addCaseMapping(0xFF4D, 0xFF2D);
      _addCaseMapping(0xFF4E, 0xFF2E);
      _addCaseMapping(0xFF4F, 0xFF2F);
      _addCaseMapping(0xFF50, 0xFF30);
      _addCaseMapping(0xFF51, 0xFF31);
      _addCaseMapping(0xFF52, 0xFF32);
      _addCaseMapping(0xFF53, 0xFF33);
      _addCaseMapping(0xFF54, 0xFF34);
      _addCaseMapping(0xFF55, 0xFF35);
      _addCaseMapping(0xFF56, 0xFF36);
      _addCaseMapping(0xFF57, 0xFF37);
      _addCaseMapping(0xFF58, 0xFF38);
      _addCaseMapping(0xFF59, 0xFF39);
      _addCaseMapping(0xFF5A, 0xFF3A);
   }
}