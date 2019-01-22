package todo.view;

import scout.framework.Component;
import scout.framework.Api.*;
import todo.model.Store;

class App extends Component {

  @:prop var id:String = 'App';
  @:prop var title:String;
  @:prop var store:Store;

  override function render() return html('
    <div class="todoapp">
      ${ new Header({ title: title, store: store }) }
      ${ new TodoList({ store: store }) }
      ${ new Footer({ store: store }) }
    </div>
    <footer class="info">
      <p>Double-click to edit a todo.</p>
      <p>Written by <a href="https://github.com/wartman">wartman</a></p>
      <p>Part of <a href="http://todomvc.com">TodoMVC</a></p>
    </footer>
  ');

}
