package stx.makro.di.core;

import tink.priority.Queue;

interface AssemblyApi{
  public function react(di:stx.makro.di.DI):Void;
  public function apply(q:Queue<AssemblyApi>):Void;
}