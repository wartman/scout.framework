package scout.framework.component;

import js.html.Event;
import scout.html.Api.html;
import scout.html.TemplateResult;
import scout.framework.Component;

class Button extends Component {

  @:prop var className:String;
  @:prop var onClick:(e:Event)->Void;
  @:prop var child:TemplateResult;

  override function render() return html('
    <button class="${className}" on:click="${onClick}">
      ${child}
    </button>
  ');

}
