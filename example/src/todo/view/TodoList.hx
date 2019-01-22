package todo.view;

import scout.framework.Component;
import scout.framework.Api.*;
import todo.model.Store;

class TodoList extends Component {

  @:prop @:update var store:Store;

  override function shouldRender() {
    return store != null;
  }

  override function render() return html('
    <ul class="todo-list">
      ${[ for (todo in store.todos) new TodoItem({ store: store, todo: todo }) ]}
    </ul>
  ');

}
