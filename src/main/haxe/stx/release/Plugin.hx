package stx.release;

import haxe.ds.Option;
import hxml.Hxml;
import haxe.Json;
using Lambda;
import sys.FileSystem;
import sys.io.File;
import haxe.io.Path;
import haxe.macro.Context;
import haxe.macro.Compiler;
import haxe.macro.Expr;

class Plugin{
  static macro public function use(){
    trace('stx.release.Plugin.use()');
    // for(arg in Sys.args()){
    //   trace(arg);
    // }
    final t = Context.typeof(macro stx.release.Plugin);
    switch(t){
      case TType(t, params):
        final tI      = t.get();
        var s         = Std.string(tI.pos);
            s         = s.substr(5,s.length - 6);
        //trace(s);
        final a       = s.split(":");
        final f       = a[0];
        //trace(f);
        final d       = Path.directory(f);
        final p       = new Path(d);
        final sep     = p.backslash ? "\\" : "/";
        final aI      = d.split(sep).slice(0,-5);
        var nx        = absolute_path_of(sep,aI);
        //trace(nx);
        final dirs    = FileSystem.readDirectory(nx).filter(
          s -> {
            return switch(s){
              case null                                 : false;
              case 'src'                                : false;
              case x if (StringTools.startsWith(x,".")) : false;
              default   : 
                final path        = Path.join([nx,s]);
                final is_dir      = FileSystem.isDirectory(path);
                switch(is_dir){
                  case true : 
                    trace(path);
                    final read        = FileSystem.readDirectory(path);
                    //trace(read);
                    final has_haxelib = read.exists(
                      (str:String) -> {
                        //trace(str);
                        return str == "haxelib.json";
                      }
                    );
                    //trace(has_haxelib);
                    has_haxelib;
                  default : false;
                }
            }
          }
        ).map(
          s -> Path.join([nx,s])
        );
        for(dir in dirs){
          //trace(dir);
          final contents = FileSystem.readDirectory(dir);
          final haxelib  = File.getContent(Path.join([dir,'haxelib.json']));
          final haxelibj = Json.parse(haxelib);
          final hxlib_cp = switch(Reflect.field(haxelibj,"classPath")){
            case null : dir;
            case x    : Path.join([dir,absolute_path_of(sep,x.split(sep))]);
          }
          final hxlib_name    =  switch(Reflect.field(haxelibj,"name")){
            case null : throw 'No haxelib name found in $dir';
            case x    : x;
          }
          final hxlib_version =  switch(Reflect.field(haxelibj,"version")){
            case null : throw 'No haxelib version found in $dir';
            case x    : x;
          }
          trace(hxlib_cp);
          Compiler.addClassPath(hxlib_cp);
          Compiler.define(hxlib_name,hxlib_version);
        }
        for(dir in dirs){
          //trace(dir);
          final contents = FileSystem.readDirectory(dir);
          final haxelib  = File.getContent(Path.join([dir,'haxelib.json']));
          final haxelibj = Json.parse(haxelib);
          final hxlib_cp = switch(Reflect.field(haxelibj,"classPath")){
            case null : dir;
            case x    : Path.join([dir,absolute_path_of(sep,x.split(sep))]);
          }
          final has_extra_params = contents.exists(
            s -> s == "extraParams.hxml"
          );
          if(has_extra_params){
            final extra_params_loc  = Path.join([dir,'extraParams.hxml']);
            final extra_params_dat  = File.read(extra_params_loc).readAll().toString();
            trace(extra_params_dat);
            final args              = Hxml.parseHXML(extra_params_dat);
            trace('$dir $args');
            for(arg in args[0].prj()){
              trace(arg);
              switch(arg){
                case HxmlArgument.Comment(_)        : 
                case HxmlArgument.ClassPath(path)   :
                case HxmlArgument.Macro(str)        : 
                  final expr    = str;
                  final parser  = new hscript.Parser();
                  final ast     = parser.parseString(expr);
                  var cls       = Type.getClass('haxe.macro.Context');
                  final interp  = new hscript.Interp();
                  function locals(){
                    for(str in Type.getClassFields(cls)){
                      final field = Reflect.field(cls,str);
                      interp.variables.set(str,field);
                    }
                  }
                  locals();
                  cls = Type.getClass('haxe.macro.Compiler');
                  locals();
                  switch(ast){
                    case ECall(expr,args) : 
                      final module = efield_module(efield_path(expr));
                      switch(module){
                        case Some(arr) : 
                          trace(arr);
                          final path            = [];
                          final vals = arr.map(
                            x -> ({
                              str   : x,
                              obj   : {}
                            }:{str : String, obj : Dynamic})
                          );
                          for(i in 0...vals.length){
                            final set = vals[i];
                            path.push(set.str);
                            if(path.length == 1){
                              interp.variables.set(path.join("."),set.obj);
                            }else if(i < vals.length -1){
                              final prv = vals[i-1];
                              Reflect.setField(prv.obj,set.str,set.obj);
                            }else{
                              final prv = vals[i-1];
                              trace(set.str);
                              final o : Dynamic   = {};
                              trace(arr.join("."));
                              final module = arr.join(".");
                              trace(hxlib_cp);
                              final cp = Context.getClassPath();
                                    cp.push(hxlib_cp);
                              Compiler.include("",true,[],cp,true);
                              final cls           = Type.resolveClass(module);
                              if(cls == null){
                                throw "SHIT";
                              }
                              for(str in Type.getClassFields(cls)){
                                Reflect.setField(o,str,Reflect.field(cls,str));
                              }
                              trace(o);
                              Reflect.setField(prv.obj,set.str,o);
                            }
                           // if()
                           trace(set);
                          }
                          
                        default : 
                      }
                    default : 
                  }
                  interp.execute(ast);
                case HxmlArgument.Define(def)       : 
                  //Context.
                default : 
              }
            }
          }
        }
      default : throw "FATAL: Plugin should be TTYpe";
    }

    //Compiler.addClassPath('')    
    return macro {};
  }
  static function efield_path(expr:hscript.Expr){
    final arr = [];
    function rec(e:hscript.Expr){
      switch (e){
        case EField(expr,name) :
          arr.unshift(name);
          rec(expr);
        case EIdent(name):
          arr.unshift(name);
        default : throw 'Unsupported Expression $expr';
      }
    }
    rec(expr);
    return arr;
  }
  static function efield_module(arr:Array<String>){
    final arr =  Lambda.fold(
      Lambda.fold(arr,
      (nxt,mmo) -> switch(mmo[mmo.length - 1]){
        case Some(x)  : mmo;
        case None     :
          final sub       = nxt.substr(0,1);
          final is_upper  = sub.toUpperCase() == sub.substr(0,1);
          if(is_upper){
            mmo.push(Some(nxt));
            mmo;
          }else{
            mmo.push(Some(nxt));
            mmo.push(None);
            mmo;
          }
      },
      [None]
    ),
      (nxt,mmo:Array<String>) -> {
        switch(nxt){
          case Some(s) : mmo.push(s);
          default:
        }
        return mmo;
      },
      []
    );
    return switch(arr.length){
      case 0  : None;
      case 1  : None;
      default : Some(arr);
    }
  }
  static function absolute_path_of(sep:String,arr:Array<String>){
    var nx        = Path.join(arr);
    if(sep == "/"){
      nx = '/$nx';
    }
    return nx;
  }
}