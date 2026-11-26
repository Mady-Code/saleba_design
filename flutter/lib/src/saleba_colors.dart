import 'package:material_ui/material_ui.dart';

import 'saleba_contrast.dart';
import 'saleba_tokens.dart';

/// Colour roles of the Saleba charter, for the current brightness (charter §2).
///
/// Read it with `SalebaColors.of(context)`. Every value comes from [SalebaTokens]; the dark soft
/// fills are the role colour blended over the dark surface, so no colour is written here.
@immutable
class SalebaColors extends ThemeExtension<SalebaColors> {
  /// Builds a set of roles. Prefer [light], [dark] or [withAccent].
  const SalebaColors({
    required this.bg,
    required this.surface,
    required this.surfaceAlt,
    required this.border,
    required this.text,
    required this.textMuted,
    required this.primary,
    required this.onPrimary,
    required this.primaryStrong,
    required this.primarySoft,
    required this.accent,
    required this.onAccent,
    required this.accentSoft,
    required this.highlight,
    required this.success,
    required this.successSoft,
    required this.warning,
    required this.warningSoft,
    required this.danger,
    required this.dangerSoft,
    required this.info,
    required this.infoSoft,
    required this.scrim,
    required this.data,
  });

  /// Light roles (sand background, Saleba green).
  static const SalebaColors light = SalebaColors(
    bg: SalebaTokens.lightBg,
    surface: SalebaTokens.lightSurface,
    surfaceAlt: SalebaTokens.lightSurfaceAlt,
    border: SalebaTokens.lightBorder,
    text: SalebaTokens.lightText,
    textMuted: SalebaTokens.lightTextMuted,
    primary: SalebaTokens.lightPrimary,
    onPrimary: SalebaTokens.lightOnPrimary,
    primaryStrong: SalebaTokens.brandPrimaryStrong,
    primarySoft: SalebaTokens.brandPrimarySoft,
    accent: SalebaTokens.lightAccent,
    onAccent: SalebaTokens.lightOnAccent,
    accentSoft: SalebaTokens.brandAccentSoft,
    highlight: SalebaTokens.brandTerracotta,
    success: SalebaTokens.success,
    successSoft: SalebaTokens.successSoft,
    warning: SalebaTokens.warning,
    warningSoft: SalebaTokens.warningSoft,
    danger: SalebaTokens.danger,
    dangerSoft: SalebaTokens.dangerSoft,
    info: SalebaTokens.info,
    infoSoft: SalebaTokens.infoSoft,
    scrim: SalebaTokens.overlayScrim,
    data: SalebaTokens.dataPalette,
  );

  /// Dark roles (lighter green, dark text on it).
  static final SalebaColors dark = SalebaColors(
    bg: SalebaTokens.darkBg,
    surface: SalebaTokens.darkSurface,
    surfaceAlt: SalebaTokens.darkSurfaceAlt,
    border: SalebaTokens.darkBorder,
    text: SalebaTokens.darkText,
    textMuted: SalebaTokens.darkTextMuted,
    primary: SalebaTokens.darkPrimary,
    onPrimary: SalebaTokens.darkOnPrimary,
    primaryStrong: SalebaTokens.brandPrimary,
    primarySoft: _softOnDark(SalebaTokens.darkPrimary),
    accent: SalebaTokens.darkAccent,
    onAccent: SalebaTokens.darkOnAccent,
    accentSoft: _softOnDark(SalebaTokens.darkAccent),
    highlight: SalebaTokens.brandTerracotta,
    success: SalebaTokens.success,
    successSoft: _softOnDark(SalebaTokens.success),
    warning: SalebaTokens.warning,
    warningSoft: _softOnDark(SalebaTokens.warning),
    danger: SalebaTokens.danger,
    dangerSoft: _softOnDark(SalebaTokens.danger),
    info: SalebaTokens.info,
    infoSoft: _softOnDark(SalebaTokens.info),
    scrim: SalebaTokens.overlayScrim,
    data: SalebaTokens.dataPalette,
  );

  /// Roles for [brightness].
  static SalebaColors forBrightness(Brightness brightness) => brightness == Brightness.dark ? dark : light;

  /// Roles of the current theme, or the light roles when the theme has no [SalebaColors].
  static SalebaColors of(BuildContext context) =>
      Theme.of(context).extension<SalebaColors>() ?? forBrightness(Theme.of(context).brightness);

  /// Page background.
  final Color bg;

  /// Cards, sheets, dialogs.
  final Color surface;

  /// Fields and secondary surfaces.
  final Color surfaceAlt;

  /// 1 px borders and dividers.
  final Color border;

  /// Main text.
  final Color text;

  /// Labels, hints, secondary text.
  final Color textMuted;

  /// Main actions, navigation, brand.
  final Color primary;

  /// Text and icons on [primary].
  final Color onPrimary;

  /// Hover and pressed state of [primary].
  final Color primaryStrong;

  /// Selection backgrounds and badges.
  final Color primarySoft;

  /// Marketing calls to action, prices, "featured". Replaced by the tenant colour on a storefront
  /// (charter §6).
  final Color accent;

  /// Text on [accent]: never white on saffron.
  final Color onAccent;

  /// Soft fill of [accent].
  final Color accentSoft;

  /// Promotions and discounts (terracotta).
  final Color highlight;

  /// Success state.
  final Color success;

  /// Background of success banners and badges.
  final Color successSoft;

  /// Warning state.
  final Color warning;

  /// Background of warning banners and badges.
  final Color warningSoft;

  /// Error state.
  final Color danger;

  /// Background of error banners and badges.
  final Color dangerSoft;

  /// Information state.
  final Color info;

  /// Background of information banners and badges.
  final Color infoSoft;

  /// Veil behind modals.
  final Color scrim;

  /// Categorical chart palette, always in this order.
  final List<Color> data;

  /// These roles with a tenant brand colour as [accent] (charter §6). Only the accent changes; the
  /// text colour on it is computed. Returns these roles unchanged when [tenantAccent] is null or
  /// cannot carry readable text ([SalebaContrast.isUsableAccent]).
  SalebaColors withAccent(Color? tenantAccent) {
    if (tenantAccent == null || !SalebaContrast.isUsableAccent(tenantAccent)) return this;
    final isDark = bg.computeLuminance() < 0.5;
    return copyWith(
      accent: tenantAccent,
      onAccent: SalebaContrast.onColor(tenantAccent),
      accentSoft: isDark
          ? _softOnDark(tenantAccent)
          : Color.alphaBlend(tenantAccent.withAlpha(0x26), surface),
    );
  }

  static Color _softOnDark(Color color) => Color.alphaBlend(color.withAlpha(0x2A), SalebaTokens.darkSurface);

  @override
  SalebaColors copyWith({
    Color? bg,
    Color? surface,
    Color? surfaceAlt,
    Color? border,
    Color? text,
    Color? textMuted,
    Color? primary,
    Color? onPrimary,
    Color? primaryStrong,
    Color? primarySoft,
    Color? accent,
    Color? onAccent,
    Color? accentSoft,
    Color? highlight,
    Color? success,
    Color? successSoft,
    Color? warning,
    Color? warningSoft,
    Color? danger,
    Color? dangerSoft,
    Color? info,
    Color? infoSoft,
    Color? scrim,
    List<Color>? data,
  }) => SalebaColors(
    bg: bg ?? this.bg,
    surface: surface ?? this.surface,
    surfaceAlt: surfaceAlt ?? this.surfaceAlt,
    border: border ?? this.border,
    text: text ?? this.text,
    textMuted: textMuted ?? this.textMuted,
    primary: primary ?? this.primary,
    onPrimary: onPrimary ?? this.onPrimary,
    primaryStrong: primaryStrong ?? this.primaryStrong,
    primarySoft: primarySoft ?? this.primarySoft,
    accent: accent ?? this.accent,
    onAccent: onAccent ?? this.onAccent,
    accentSoft: accentSoft ?? this.accentSoft,
    highlight: highlight ?? this.highlight,
    success: success ?? this.success,
    successSoft: successSoft ?? this.successSoft,
    warning: warning ?? this.warning,
    warningSoft: warningSoft ?? this.warningSoft,
    danger: danger ?? this.danger,
    dangerSoft: dangerSoft ?? this.dangerSoft,
    info: info ?? this.info,
    infoSoft: infoSoft ?? this.infoSoft,
    scrim: scrim ?? this.scrim,
    data: data ?? this.data,
  );

  @override
  SalebaColors lerp(ThemeExtension<SalebaColors>? other, double t) {
    if (other is! SalebaColors) return this;
    Color l(Color a, Color b) => Color.lerp(a, b, t)!;
    return SalebaColors(
      bg: l(bg, other.bg),
      surface: l(surface, other.surface),
      surfaceAlt: l(surfaceAlt, other.surfaceAlt),
      border: l(border, other.border),
      text: l(text, other.text),
      textMuted: l(textMuted, other.textMuted),
      primary: l(primary, other.primary),
      onPrimary: l(onPrimary, other.onPrimary),
      primaryStrong: l(primaryStrong, other.primaryStrong),
      primarySoft: l(primarySoft, other.primarySoft),
      accent: l(accent, other.accent),
      onAccent: l(onAccent, other.onAccent),
      accentSoft: l(accentSoft, other.accentSoft),
      highlight: l(highlight, other.highlight),
      success: l(success, other.success),
      successSoft: l(successSoft, other.successSoft),
      warning: l(warning, other.warning),
      warningSoft: l(warningSoft, other.warningSoft),
      danger: l(danger, other.danger),
      dangerSoft: l(dangerSoft, other.dangerSoft),
      info: l(info, other.info),
      infoSoft: l(infoSoft, other.infoSoft),
      scrim: l(scrim, other.scrim),
      data: [for (var i = 0; i < data.length && i < other.data.length; i++) l(data[i], other.data[i])],
    );
  }
}
