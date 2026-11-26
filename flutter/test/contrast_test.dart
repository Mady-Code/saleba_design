import 'package:flutter/painting.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:saleba_design/saleba_design.dart';

/// Contrasts promised by the charter (§2, WCAG 2.2) and the tenant colour guard (§6).
void main() {
  group('charter contrasts', () {
    void expectRatio(String label, Color fg, Color bg, double atLeast) {
      final ratio = SalebaContrast.ratio(fg, bg);
      expect(ratio, greaterThanOrEqualTo(atLeast), reason: '$label: ${ratio.toStringAsFixed(2)}:1');
    }

    test('green on white', () {
      expectRatio('green on white', SalebaTokens.brandPrimary, SalebaTokens.neutral0, 6.0);
    });
    test('ebony on sand', () {
      expectRatio('ebony on sand', SalebaTokens.lightText, SalebaTokens.lightBg, 16.0);
    });
    test('ebony on saffron', () {
      expectRatio('ebony on saffron', SalebaTokens.lightOnAccent, SalebaTokens.brandAccent, 8.5);
    });
    test('light green on dark background', () {
      expectRatio('light green on dark', SalebaTokens.darkPrimary, SalebaTokens.darkBg, 9.5);
    });
    test('saffron never carries white text', () {
      expect(SalebaContrast.meetsAa(SalebaTokens.neutral0, SalebaTokens.brandAccent), isFalse);
      expect(SalebaContrast.onColor(SalebaTokens.brandAccent), SalebaTokens.neutral900);
    });

    for (final (name, colors) in [('light', SalebaColors.light), ('dark', SalebaColors.dark)]) {
      test('$name roles reach AA for text', () {
        expect(SalebaContrast.meetsAa(colors.text, colors.bg), isTrue);
        expect(SalebaContrast.meetsAa(colors.text, colors.surface), isTrue);
        expect(SalebaContrast.meetsAa(colors.textMuted, colors.surface), isTrue);
        expect(SalebaContrast.meetsAa(colors.onPrimary, colors.primary), isTrue);
        expect(SalebaContrast.meetsAa(colors.onAccent, colors.accent), isTrue);
      });
    }
  });

  group('tenant accent (charter §6)', () {
    test('a readable tenant colour replaces the accent only, with a computed text colour', () {
      const tenant = SalebaTokens.data5; // violet
      final colors = SalebaColors.light.withAccent(tenant);
      expect(colors.accent, tenant);
      expect(colors.onAccent, SalebaTokens.neutral0);
      expect(colors.primary, SalebaColors.light.primary);
      expect(colors.danger, SalebaColors.light.danger);
    });

    test('an unreadable tenant colour is ignored', () {
      // Mid grey: neither ebony nor white reaches 4.5:1 on it.
      final grey = Color.lerp(SalebaTokens.neutral0, SalebaTokens.neutral950, 0.55)!;
      expect(SalebaContrast.isUsableAccent(grey), isFalse);
      expect(SalebaColors.light.withAccent(grey), same(SalebaColors.light));
    });
  });
}
