import js.Browser;
import todo.model.*;
import todo.view.App;
import scout.framework.Api;

class TodoApp {

  public static function main() {
    var store = new Store({
      todos: new TodoCollection()
    });
    var root = Browser.document.getElementById('Root');
    var app = new App({
      title: 'todo',
      store: store
    });
    Api.render(app, root);
  }

}
