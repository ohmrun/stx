package sys.stx.io.input.term;

import stx.coroutine.pack.Tunnel.TunnelLift;

typedef KeyboardDef = InputDef;

@:using(stx.io.Input.InputLift)
@:using(sys.stx.io.input.term.Keyboard.KeyboardLift)
abstract Keyboard(KeyboardDef) from KeyboardDef to KeyboardDef{

  public inline function new(self:KeyboardDef) this = self;
  @:noUsing static inline public function lift(self:KeyboardDef):Keyboard return new Keyboard(self);

  public function prj():KeyboardDef return this;
  private var self(get,never):Keyboard;
  private function get_self():Keyboard return lift(this);

  static public function make(shell:ShellApi){
    function turn(stdin:InputDef):InputDef{
      return __.tran(
        function rec(x:InputRequest){
          return switch(x){
            case IReqValue(bs)                : switch(bs){
              case I8 : __.hold(
                (shell.byte().map(
                  x -> __.emit(IResValue(Packet.make(Byteal(NInt(x)),I8)),__.tran(rec))
                ))
              );
              default : TunnelLift.mod(stdin.provide(x).prj(),turn).prj();
            } 
            case x : TunnelLift.mod(stdin.provide(x),turn).prj();
          };
        }
      );
    }
    return lift(turn(shell.stdin()));
  }
}
class KeyboardLift{
  static public inline function lift(self:KeyboardDef):Keyboard{
    return Keyboard.lift(self);
  }
}