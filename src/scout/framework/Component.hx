package scout.framework;

import scout.html.Template;
import scout.html.TemplateResult;
import scout.html.TemplateUpdater;

@:autoBuild(scout.framework.macro.ComponentBuilder.build())
class Component 
  implements TemplateResultObject 
  implements TemplateUpdater  
{

  static var _scout_componentIds:Int = 0;

  public final _scout_cid:Int = _scout_componentIds++;
  var _scout_template:Template;
  
  public function setTemplate(template:Template) {
    _scout_template = template;
  }

  public function getFactory() {
    return render().getFactory();
  }

  public function getValues() {
    return render().getValues();
  }

  public function update() {
    if (shouldRender() && _scout_template != null) {
      _scout_template.update(getValues());
    }
  }

  public function shouldRender():Bool {
    return true;
  }

  public function render():TemplateResult {
    return Api.html('');
  }

}
