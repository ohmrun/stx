package stx.makro.def;

@:using(stx.makro.def.HClassTypeDefKind.HClassTypeDefKindLift)
@:forward abstract HClassTypeDefKind(TypeDefKind) from TypeDefKind to TypeDefKind{
  @:noUsing static public function lift(self:TypeDefKind){
    return new HClassTypeDefKind(self);
  }
  public function new(self) this = self;
  
  @:noUsing static public function make(?super_class:TypePath,?interfaces,?is_interface=false,?is_final=false):HClassTypeDefKind{
    return lift(TDClass(super_class,__.option(interfaces).defv([]),is_interface,is_final));
  }
}
class HClassTypeDefKindLift{

}