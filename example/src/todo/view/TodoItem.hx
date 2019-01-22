package todo.view;

import js.html.Event;
import scout.framework.Component;
import scout.framework.Api.*;
import todo.model.Todo;
import todo.model.Store;

class TodoItem extends Component {

  @:prop var todo:Todo;
  @:prop var store:Store;

  function removeTodo(e:Event) {
    e.preventDefault();
    store.todos.remove(todo);
  }

  override function render() return isVisible() ? html('
    <li class="${getClass()}" id="Todo-${todo.id}">
      ${if (todo.editing) new TodoInput({
        value: todo.label,
        inputClass: 'edit',
        onSave: saveTodo
      }) else html('
        <div class="view" on:dblclick="${startEditing}">
          <input
            class="toggle" 
            type="checkbox" 
            is:checked="${todo.completed}" 
            on:click="${toggleCompleted}"
          />
          <label>${todo.label}</label>
          <button class="destroy" on:click="${removeTodo}"></button>
        </div>
      ')}
    </li>
  ') : html('');

  @:observe(store.props.visible)
  @:observe(todo.props.completed)
  @:observe(todo.props.editing)
  function doUpdate(_:Dynamic) {
    update();
  }

  function startEditing(e:Event) {
    for (t in store.todos) t.editing = false;
    todo.editing = true;
  }

  function saveTodo(value:String) {
    todo.label = value;
    todo.editing = false;
    update();
  }

  function isVisible() return switch (store.visible) {
    case VisibleAll: true;
    case VisibleCompleted: todo.completed;
    case VisiblePending: !todo.completed;
  }

  function getClass() {
    return todo.editing ? 'todo-item editing' : 'todo-item';
  }

  function toggleCompleted(e:Event) {
    todo.completed = !todo.completed;
  }

}
