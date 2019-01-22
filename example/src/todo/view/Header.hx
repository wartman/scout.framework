package todo.view;

import scout.framework.Component;
import scout.framework.Api.html;
import todo.model.Store;
import todo.model.Todo;

class Header extends Component {

  @:prop var title:String;
  @:prop var store:Store;

  function createTodo(value:String) {
    store.todos.add(new Todo({
      label: value
    }));
  }

  override function render() return html('
    <header class="todo-header">
      <h1>${title}</h1>
      ${ new TodoInput({ inputClass: 'new-todo', onSave: createTodo }) }
    </header>
  ');

}