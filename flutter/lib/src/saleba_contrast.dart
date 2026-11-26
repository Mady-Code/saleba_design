import 'dart:math' as math;

import 'package:flutter/painting.dart';

import 'saleba_tokens.dart';

/// WCAG 2.2 contrast helpers (charter §2 and §6).
///
/// Used to check a tenant's brand colour when it is saved and to pick the text colour that goes on
/// it, so that a shop can never make its own storefront unreadable.
abstract final class SalebaContrast {
  /// Minimum ratio for body text (WCAG AA).
  static const double minText = 4.5;

  /// Minimum ratio for large text (≥ 18 pt, or 14 pt bold) and for UI components (WCAG AA).
  static const double minLargeText = 3;

  /// Contrast ratio between [a] and [b], from 1 (none) to 21 (black on white). Both colours are
  /// taken as opaque.
  static double ratio(Color a, Color b) {
    final la = a.computeLuminance();
    final lb = b.computeLuminance();
    return (math.max(la, lb) + 0.05) / (math.min(la, lb) + 0.05);
  }

  /// Text colour to put on [background]: ebony or white, whichever contrasts most. Saffron and
  /// other light accents therefore get dark text (charter §2).
  static Color onColor(Color background) {
    const dark = SalebaTokens.neutral900;
    const light = SalebaTokens.neutral0;
    return ratio(background, dark) >= ratio(background, light) ? dark : light;
  }

  /// Whether [foreground] on [background] reaches WCAG AA.
  static bool meetsAa(Color foreground, Color background, {bool largeText = false}) =>
      ratio(foreground, background) >= (largeText ? minLargeText : minText);

  /// Whether [color] can be used as a tenant accent (charter §6): its own text colour, computed by
  /// [onColor], must reach AA for body text.
  static bool isUsableAccent(Color color) => meetsAa(onColor(color), color);
}
