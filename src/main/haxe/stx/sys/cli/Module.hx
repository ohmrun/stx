package stx.sys.cli;

using stx.Parse;

class Module extends Clazz{
  public function spec(){
    return Spec.__;
  }
  public function apply(spec:Spec){
    return stx.sys.cli.SysCliParser.reply().flat_map(
      x -> spec.reply().apply(x.reader()).toUpshot().errate(
        x -> E_Cli_Parse(x)
      )
    );
  }
}