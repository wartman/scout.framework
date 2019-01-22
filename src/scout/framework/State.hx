package scout.framework;

interface StateObject<T> extends Observable<T> {
  public function get():T;
  public function set(value:T):Void; 
}

@:forward
abstract State<T>(StateObject<T>) to Observable<T> {

  @:from public static function ofObservable<T:Observable<M>, M>(value:T):State<T> {
    return cast new StateOfObservable(value);
  }

  @:from public static function ofDynamic<T:Dynamic>(value:T):State<T> {
    return new State(value);
  }

  public function new(?value:T) {
    this = new SimpleState(value);
  }

}

private class SimpleState<T> implements StateObject<T> {

  var value:T;
  final signal:Signal<T> = new Signal();

  public function new(?value:T) {
    this.value = value;
  }

  public function set(value:T) {
    if (this.value == value) {
      return;
    }
    this.value = value;
    signal.dispatch(this.value);
  }

  public function get():T {
    return this.value;
  }

  public function observe(cb:(value:T)->Void) {
    return signal.add(cb);
  }

}

private class StateOfObservable<T:Observable<M>, M> implements StateObject<T> {

  var value:T;
  var lastSlot:Signal.SignalSlot<M>;
  final signal:Signal<T> = new Signal();

  public function new(?value:T) {
    if (value != null) {
      this.value = value;
      lastSlot = value.observe(_ -> signal.dispatch(value));
    }
  }

  public function set(value:T) {
    if (this.value == value) {
      return;
    }
    this.value = value;
    if (lastSlot != null) {
      lastSlot.remove();
    }
    if (value != null) {
      lastSlot = value.observe(_ -> signal.dispatch(value));
    }
    signal.dispatch(value);
  }

  public function get():T {
    return value;
  }

  public function observe(cb:(value:T)->Void) {
    return signal.add(cb);
  }

}
