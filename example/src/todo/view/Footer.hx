package todo.view;

import js.html.Event;
import scout.framework.Component;
import scout.framework.Api.html;
import todo.model.Store;

class Footer extends Component {

  @:prop @:update var store:Store;

  override function render() return html('${if (store.todos.length > 0) html('
    <footer class="footer">
      <span class="todo-count">${todoCount(store.todosRemaining)}</span>
      <ul class="filters">
        <li>
          <a href="#all" on:click="${e -> setFilter(e, VisibleAll)}">All</a>
        </li>
        <li>
          <a href="#completed" on:click="${e -> setFilter(e, VisibleCompleted)}">Completed</a>
        </li>
        <li>
          <a href="#pending" on:click="${e -> setFilter(e, VisiblePending)}">Pending</a>
        </li>
      </ul>
    </footer>  
  ') else html('')}');

  function setFilter(e:Event, filter:VisibleTodos) {
    e.preventDefault();
    store.visible = filter;
  }

  function todoCount(remaining:Int) return switch (remaining) { 
    case 0: html('No items left');
    case 1: html('1 item left');
    default: html('${remaining} items left');
  }

}
