package todo.view;

import js.html.KeyboardEvent;
import js.html.InputElement;
import js.html.Event;
import scout.framework.Component;
import scout.framework.Api.*;

class TodoInput extends Component {

  @:prop var value:String = '';
  @:prop var inputClass:String;
  @:prop var onSave:(value:String)->Void;

  function updateValue(e:Event) {
    var input:InputElement = cast e.target;
    value = input.value;
  }

  function save(e:Event) {
    var input:InputElement = cast e.target;
    updateValue(e);
    var keyboardEvent:KeyboardEvent = cast e;
    if (keyboardEvent.key == 'Enter') {
      onSave(value);
      input.value = '';
      input.blur();
    }
  }

  override function render() return html('
    <div class="todo-input">
      <input 
        class="${inputClass}" 
        value="${value}"
        on:change="${updateValue}"
        on:keydown="${save}"
      />
    </div>
  ');

}
