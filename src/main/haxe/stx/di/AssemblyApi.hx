package stx.di;

import tink.priority.Queue;

interface AssemblyApi{
  public function react(di:stx.di.DI):Void;
  public function apply(q:Queue<AssemblyApi>):Void;
}