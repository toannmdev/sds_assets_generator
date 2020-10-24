import 'package:assets_generator/assets_generator.dart';
import 'package:build_runner_core/build_runner_core.dart';
import 'package:io/ansi.dart';
import 'package:path/path.dart';

const String license = '''// GENERATED CODE - DO NOT MODIFY MANUALLY
// **************************************************************************
// Auto generated by https://github.com/fluttercandies/assets_generator
// **************************************************************************
''';

String get classDeclare => 'class {0} {\n const {0}._();';
String get classDeclareFooter => '}\n';

class Template {
  Template(
    this.assets,
    this.packageGraph,
    this.rule,
    this.class1,
  );
  final PackageNode packageGraph;
  final List<String> assets;
  final Rule rule;
  final Class class1;

  @override
  String toString() {
    final StringBuffer sb = StringBuffer();
    sb.write(license);
    sb.write(classDeclare.replaceAll(
      '{0}',
      class1.go('ucc'),
    ));
    if (!packageGraph.isRoot) {
      sb.write('''static const String package = '${packageGraph.name}';\n''');
    }
    // 1.5x,2.0x,3.0x
    final RegExp regExp = RegExp(r'(([0-9]+).([0-9]+)|([0-9]+))x/');
    // check resolution image assets
    final List<String> list = assets.toList();
    for (final String asset in assets) {
      final String r = asset.replaceAllMapped(regExp, (Match match) {
        return '';
      });
      //macth
      if (r != asset) {
        if (!list.contains(r)) {
          throw Exception(red
              .wrap('miss main asset entry: ${packageGraph.path}$separator$r'));
          //list.add(r);
        }
        list.remove(asset);
      }
    }

    for (final String asset in list) {
      sb.write(formatFiled(asset));
    }

    sb.write(classDeclareFooter);

    return sb.toString();
  }

  String formatFiled(String path) {
    return '''static const String ${_formatFiledName(path)} = '$path';\n''';
  }

  String _formatFiledName(String path) {
    path = path
        .replaceAll('/', '_')
        .replaceAll('.', '_')
        .replaceAll(' ', '_')
        .replaceAll('-', '_')
        .replaceAll('@', '_AT_');
    return rule.go(path);
  }
}
