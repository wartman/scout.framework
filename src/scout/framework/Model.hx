package scout.framework;

@:autoBuild(scout.framework.macro.ModelBuilder.build())
interface Model extends Observable<Model> {
  public var id(get, set):Int;
}
