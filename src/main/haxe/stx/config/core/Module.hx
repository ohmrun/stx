package stx.config.core;

class Module extends Clazz{
  public function new(){
    super();
  }  
  public function Directory():DirectoryDef{
    return stx.config.term.Directory.unit().prj();
  }
  public function File():FileDef{
    return stx.config.term.File.unit();
  }
  public function Resource():ResourceDef{
    return stx.config.term.Resource.unit();
  }
  //public function load()
}