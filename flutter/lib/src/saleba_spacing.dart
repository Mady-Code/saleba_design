import 'dart:ui' show lerpDouble;

import 'package:material_ui/material_ui.dart';

import 'saleba_tokens.dart';

/// Spacing, radii and touch sizes of the charter (§4), as a theme extension so that a surface can
/// scale them (Saleba TV reads from 3 m: `SalebaSpacing.standard.scaled(1.5)`).
///
/// Read it with `SalebaSpacing.of(context)`.
@immutable
class SalebaSpacing extends ThemeExtension<SalebaSpacing> {
  /// Builds a set of spacings. Prefer [standard] or [scaled].
  const SalebaSpacing({
    required this.s1,
    required this.s2,
    required this.s3,
    required this.s4,
    required this.s6,
    required this.s8,
    required this.s12,
    required this.radiusSm,
    required this.radiusMd,
    required this.radiusLg,
    required this.radiusXl,
    required this.touchMin,
    required this.posKey,
  });

  /// The 4 px grid of the charter.
  static const SalebaSpacing standard = SalebaSpacing(
    s1: SalebaTokens.space1,
    s2: SalebaTokens.space2,
    s3: SalebaTokens.space3,
    s4: SalebaTokens.space4,
    s6: SalebaTokens.space6,
    s8: SalebaTokens.space8,
    s12: SalebaTokens.space12,
    radiusSm: SalebaTokens.radiusSm,
    radiusMd: SalebaTokens.radiusMd,
    radiusLg: SalebaTokens.radiusLg,
    radiusXl: SalebaTokens.radiusXl,
    touchMin: SalebaTokens.sizeTouchMin,
    posKey: SalebaTokens.sizePosKey,
  );

  /// Spacing of the current theme, or [standard].
  static SalebaSpacing of(BuildContext context) => Theme.of(context).extension<SalebaSpacing>() ?? standard;

  /// 4 px.
  final double s1;

  /// 8 px.
  final double s2;

  /// 12 px.
  final double s3;

  /// 16 px.
  final double s4;

  /// 24 px.
  final double s6;

  /// 32 px.
  final double s8;

  /// 48 px.
  final double s12;

  /// Fields (8 px).
  final double radiusSm;

  /// Cards (12 px).
  final double radiusMd;

  /// Sheets (16 px).
  final double radiusLg;

  /// Modals (24 px).
  final double radiusXl;

  /// Pills (badges, chips).
  double get radiusPill => SalebaTokens.radiusPill;

  /// Minimum touch target (48 px).
  final double touchMin;

  /// Point-of-sale key (72 px).
  final double posKey;

  /// Every value multiplied by [factor] (TV, large kiosks).
  SalebaSpacing scaled(double factor) => SalebaSpacing(
    s1: s1 * factor,
    s2: s2 * factor,
    s3: s3 * factor,
    s4: s4 * factor,
    s6: s6 * factor,
    s8: s8 * factor,
    s12: s12 * factor,
    radiusSm: radiusSm * factor,
    radiusMd: radiusMd * factor,
    radiusLg: radiusLg * factor,
    radiusXl: radiusXl * factor,
    touchMin: touchMin * factor,
    posKey: posKey * factor,
  );

  @override
  SalebaSpacing copyWith({
    double? s1,
    double? s2,
    double? s3,
    double? s4,
    double? s6,
    double? s8,
    double? s12,
    double? radiusSm,
    double? radiusMd,
    double? radiusLg,
    double? radiusXl,
    double? touchMin,
    double? posKey,
  }) => SalebaSpacing(
    s1: s1 ?? this.s1,
    s2: s2 ?? this.s2,
    s3: s3 ?? this.s3,
    s4: s4 ?? this.s4,
    s6: s6 ?? this.s6,
    s8: s8 ?? this.s8,
    s12: s12 ?? this.s12,
    radiusSm: radiusSm ?? this.radiusSm,
    radiusMd: radiusMd ?? this.radiusMd,
    radiusLg: radiusLg ?? this.radiusLg,
    radiusXl: radiusXl ?? this.radiusXl,
    touchMin: touchMin ?? this.touchMin,
    posKey: posKey ?? this.posKey,
  );

  @override
  SalebaSpacing lerp(ThemeExtension<SalebaSpacing>? other, double t) {
    if (other is! SalebaSpacing) return this;
    double l(double a, double b) => lerpDouble(a, b, t)!;
    return SalebaSpacing(
      s1: l(s1, other.s1),
      s2: l(s2, other.s2),
      s3: l(s3, other.s3),
      s4: l(s4, other.s4),
      s6: l(s6, other.s6),
      s8: l(s8, other.s8),
      s12: l(s12, other.s12),
      radiusSm: l(radiusSm, other.radiusSm),
      radiusMd: l(radiusMd, other.radiusMd),
      radiusLg: l(radiusLg, other.radiusLg),
      radiusXl: l(radiusXl, other.radiusXl),
      touchMin: l(touchMin, other.touchMin),
      posKey: l(posKey, other.posKey),
    );
  }
}
