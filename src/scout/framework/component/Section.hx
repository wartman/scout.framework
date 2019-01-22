package scout.framework.component;

import scout.html.Api.html;
import scout.html.TemplateResult;
import scout.framework.Component;

class Section extends Component {

  @:prop var className:String;
  @:prop var children:Array<TemplateResult>;

  override function render() return html('
    <section class="${className}">
      ${children}
    </section>
  ');

}
