package stx.di.test;

@:stx.Dependencies.register(__)
class ConfigureDependencies extends stx.di.Assembly{
	
	public function main():Int{
		return 0;
	}
	public function test(i:Int):MonkeyType{
		return MonkeyMonkey;
	}
}