package scout.framework;

import scout.framework.Signal;

interface Observable<T> {
  public function observe(cb:(value:T)->Void):SignalSlot<T>;
}
