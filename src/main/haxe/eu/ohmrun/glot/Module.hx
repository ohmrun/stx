package eu.ohmrun.glot;

class Module extends Clazz{
  #if macro
  public function to_macro_at(){
    return GExpr.__;
  }  
  #end
  public function type(){
    return GTypeDefinition.__;
  }
  public function field(){
    return GField.__;
  }
  public function field_type(){
    return GFieldType.__;
  }
  public function function_arg(){
    return GFunctionArg.__;
  }
  public function complex_type(){
    return GComplexType.__;
  }
  public function ctype(){
    return GComplexType.__;
  }
  public function expr(){
    return GExpr.__;
  }
  public function const(){
    return GConstant.__;
  }
  public function type_path(){
    return GTypePath.__;
  }
  public function method(){
    return GFunction.__;
  }
  }