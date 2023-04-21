package stx.makro.di;


class Util{

    #if macro
    static public inline function print(d:Dynamic,?pos:haxe.PosInfos){
        trace(d);
    }
    #elseif js
    static public function print(d:Dynamic,?pos:haxe.PosInfos){
        //untyped console.log(d);
    }
    #elseif php
    static public function print(d:Dynamic,?pos:haxe.PosInfos){
        var v = Std.string(d);
        //untyped __php__("log_message('debug',$v)");
    }
    #else
    static public function print(d:Dynamic,?pos:haxe.PosInfos){
        std.Sys.println(Std.string(d));
    }
    #end
}