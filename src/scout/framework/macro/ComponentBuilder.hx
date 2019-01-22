#if macro
package scout.framework.macro;

import haxe.macro.Expr;
import haxe.macro.Context;

using Lambda;
using scout.framework.macro.MetadataTools;

class ComponentBuilder {

  static final updateMetaNames = [ ':update' ];
  static final observeMetaNames = [ ':observe' ];
  static final propMetaNames = [ ':prop', ':property' ];

  public static function build() {
    return new ComponentBuilder(Context.getBuildFields()).export();
  }
  
  var fields:Array<Field>;
  var constructorFields:Array<Field> = [];
  var initializers:Array<Expr> = [];
  var propInitializers:Array<Expr> = [];
  var props:Array<Field> = [];

  public function new(fields:Array<Field>) {
    this.fields = fields;
  }

  public function export() {
    var newFields:Array<Field> = [];

    fields = fields.filter(f -> switch (f.kind) {
      case FVar(t, e):
        if (f.meta.hasEntry(propMetaNames)) {
          newFields = newFields.concat(makeFieldsForProp(f, t, e));
          if (f.meta.hasEntry(updateMetaNames)) {
            var name = f.name;
            initializers.push(macro @:pos(f.pos) props.$name.observe(_ -> update()));
          }
          return false;
        }
        true;
      case FFun(_):
        if (f.meta.hasEntry([ ':init' ])) {
          var name = f.name;
          initializers.push(macro @:pos(f.pos) this.$name());
        }
        if (f.meta.hasEntry(observeMetaNames)) {
          var name = f.name;
          var metas = f.meta.extract(observeMetaNames);
          for (meta in metas) {
            if (meta.params.length == 0) {
              Context.error('An identifier is required', f.pos);
            } else if (meta.params.length > 1) {
              Context.error('Only one param is allowed here', f.pos);
            }
            initializers.push(Common.makeObserverForState(meta.params[0], macro @:pos(f.pos) this.$name));
          }
        }
        true;
      default: true;
    });

    var conPropArgType = TAnonymous(constructorFields);
    var propsType = TAnonymous(props);
    newFields = newFields.concat((macro class {

      final props:$propsType;

      public function new(props:$conPropArgType) {
        this.props = cast {};
        $b{propInitializers};
        _scout_init();
      }

      function _scout_init() {
        $b{initializers};
      }

    }).fields);

    return fields.concat(newFields);
  }

  function makeFieldsForProp(f:Field, t:ComplexType, ?e:Expr):Array<Field> {
    var isOptional = f.meta.hasEntry([ ':optional' ]) || e != null;
    props.push(Common.makeState(f.name, t, f.pos));
    constructorFields.push(Common.makeConstructorField(f.name, t, f.pos, isOptional));
    propInitializers.push(Common.makeStateInitializer('props', 'props', f.name, t, e));
    return [
      Common.makeProp(f.name, t, f.pos, true),
      Common.makeStateGetter('props', f.name, t, f.pos),
      Common.makeStateSetter('props', f.name, t, f.pos)
    ];
  }

}
#end
