import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

import '../tool/gen_tokens.dart';

/// Charter §7: tokens/tokens.json is the single source; every output is generated from it.
void main() {
  final tokens = readTokens();

  for (final (path, generate) in [
    (dartOutputPath, generateDart),
    (cssOutputPath, generateCss),
    (tailwindOutputPath, generateTailwind),
  ]) {
    test('$path is up to date with tokens/tokens.json', () {
      expect(
        File(path).readAsStringSync(),
        generate(tokens),
        reason: 'run: cd flutter && dart run tool/gen_tokens.dart',
      );
    });
  }

  test('no hard-coded colour in lib/ outside the generated tokens', () {
    final hexColor = RegExp(r'Color\(0x');
    // Material palette (`Colors.white`…); transparent is not a colour.
    final materialColor = RegExp(r'(?<![A-Za-z_])Colors\.(?!transparent\b)');
    final offenders = <String>[];
    for (final file in Directory('lib').listSync(recursive: true).whereType<File>()) {
      final path = file.path.replaceAll(r'\', '/');
      if (!path.endsWith('.dart') || path == dartOutputPath) continue;
      final lines = file.readAsLinesSync();
      for (var i = 0; i < lines.length; i++) {
        if (hexColor.hasMatch(lines[i]) || materialColor.hasMatch(lines[i])) {
          offenders.add('$path:${i + 1}: ${lines[i].trim()}');
        }
      }
    }
    expect(offenders, isEmpty, reason: 'use SalebaTokens (tokens/tokens.json)');
  });
}
