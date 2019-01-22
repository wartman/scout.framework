package todo.model;

import scout.framework.Model;

class Todo implements Model {
  
  @:prop var label:String;
  @:prop var completed:Bool = false;
  @:prop var editing:Bool = false;

  @:transition
  public function update(label:String) {
    this.label = label;
    editing = false;
  }

}
