import 'package:material_ui/material_ui.dart';

import 'saleba_tokens.dart';

/// Typography of the charter (§3): Plus Jakarta Sans for titles and key figures, Inter for text,
/// Noto Sans as fallback for local languages. Both main fonts are embedded in this package.
abstract final class SalebaTypography {
  static const String _package = 'saleba_design';

  /// Family of titles and key figures, as Flutter resolves a font embedded in a package.
  static const String display = 'packages/$_package/${SalebaTokens.fontFamilyDisplay}';

  /// Family of body text and forms.
  static const String body = 'packages/$_package/${SalebaTokens.fontFamilyBody}';

  /// Fallback families (system Noto Sans: ɛ, ɔ, ɲ, ŋ, ɓ, ɗ, ƴ, Arabic script).
  static const List<String> fallback = SalebaTokens.fontFamilyBodyFallback;

  /// Tabular figures, so that amounts line up and do not jump while typing.
  static const List<FontFeature> tabular = [FontFeature.tabularFigures()];

  /// Material text theme in [color]: display / headline / title in Plus Jakarta Sans, body and
  /// label in Inter, sizes from the tokens.
  static TextTheme textTheme(Color color, Color mutedColor) {
    TextStyle d(double size, FontWeight weight, {double letterSpacing = 0}) => TextStyle(
      fontFamily: display,
      fontFamilyFallback: fallback,
      fontSize: size,
      fontWeight: weight,
      letterSpacing: letterSpacing,
      height: 1.2,
      color: color,
    );
    TextStyle b(double size, FontWeight weight, {Color? c, double height = 1.4}) => TextStyle(
      fontFamily: body,
      fontFamilyFallback: fallback,
      fontSize: size,
      fontWeight: weight,
      height: height,
      color: c ?? color,
    );
    return TextTheme(
      displayLarge: d(SalebaTokens.fontSizeTv, SalebaTokens.fontWeightBold, letterSpacing: -0.8),
      displayMedium: d(SalebaTokens.fontSize3xl, SalebaTokens.fontWeightBold, letterSpacing: -0.6),
      displaySmall: d(SalebaTokens.fontSize2xl, SalebaTokens.fontWeightBold, letterSpacing: -0.4),
      headlineLarge: d(SalebaTokens.fontSize2xl, SalebaTokens.fontWeightBold, letterSpacing: -0.4),
      headlineMedium: d(SalebaTokens.fontSizeXl, SalebaTokens.fontWeightBold, letterSpacing: -0.3),
      headlineSmall: d(SalebaTokens.fontSizeLg, SalebaTokens.fontWeightSemibold, letterSpacing: -0.2),
      titleLarge: d(SalebaTokens.fontSizeXl, SalebaTokens.fontWeightSemibold, letterSpacing: -0.2),
      titleMedium: d(SalebaTokens.fontSizeMd, SalebaTokens.fontWeightSemibold),
      titleSmall: d(SalebaTokens.fontSizeSm, SalebaTokens.fontWeightSemibold),
      bodyLarge: b(SalebaTokens.fontSizeMd, SalebaTokens.fontWeightRegular, height: 1.5),
      bodyMedium: b(SalebaTokens.fontSizeSm, SalebaTokens.fontWeightRegular, height: 1.45),
      bodySmall: b(SalebaTokens.fontSizeXs, SalebaTokens.fontWeightRegular, c: mutedColor),
      labelLarge: b(SalebaTokens.fontSizeSm, SalebaTokens.fontWeightSemibold, height: 1.2),
      labelMedium: b(SalebaTokens.fontSizeXs, SalebaTokens.fontWeightMedium, height: 1.2),
      labelSmall: b(SalebaTokens.fontSizeXs, SalebaTokens.fontWeightMedium, c: mutedColor, height: 1.2),
    );
  }

  /// Amount style for the till and prices (charter §3: Inter with tabular figures, 18 to 36).
  static TextStyle amount({double size = SalebaTokens.fontSizeLg, Color? color}) => TextStyle(
    fontFamily: body,
    fontFamilyFallback: fallback,
    fontSize: size,
    fontWeight: SalebaTokens.fontWeightBold,
    height: 1.15,
    fontFeatures: tabular,
    color: color,
  );

  /// Key figure (dashboards, KPI) in the display family with tabular figures.
  static TextStyle keyFigure({double size = SalebaTokens.fontSize2xl, Color? color}) => TextStyle(
    fontFamily: display,
    fontFamilyFallback: fallback,
    fontSize: size,
    fontWeight: SalebaTokens.fontWeightBold,
    height: 1.1,
    letterSpacing: -0.5,
    fontFeatures: tabular,
    color: color,
  );
}
