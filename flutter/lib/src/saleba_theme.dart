import 'package:material_ui/material_ui.dart';

import 'saleba_colors.dart';
import 'saleba_spacing.dart';
import 'saleba_tokens.dart';
import 'saleba_typography.dart';

/// Material themes of the Saleba charter, built from the tokens only.
///
/// ```dart
/// MaterialApp(theme: SalebaTheme.light(), darkTheme: SalebaTheme.dark());
/// ```
///
/// A storefront can pass its tenant colour as [tenantAccent] (charter §6): it replaces the accent
/// only, never the navigation, states or errors, and is ignored when it cannot carry readable text.
abstract final class SalebaTheme {
  /// Light theme (sand background).
  static ThemeData light({Color? tenantAccent, SalebaSpacing spacing = SalebaSpacing.standard}) =>
      build(SalebaColors.light.withAccent(tenantAccent), Brightness.light, spacing);

  /// Dark theme (lighter green on near-black).
  static ThemeData dark({Color? tenantAccent, SalebaSpacing spacing = SalebaSpacing.standard}) =>
      build(SalebaColors.dark.withAccent(tenantAccent), Brightness.dark, spacing);

  /// Theme for an explicit set of roles.
  static ThemeData build(SalebaColors c, Brightness brightness, SalebaSpacing s) {
    final isDark = brightness == Brightness.dark;
    final scheme = ColorScheme.fromSeed(seedColor: c.primary, brightness: brightness).copyWith(
      primary: c.primary,
      onPrimary: c.onPrimary,
      primaryContainer: c.primarySoft,
      onPrimaryContainer: isDark ? c.primary : c.primaryStrong,
      secondary: c.accent,
      onSecondary: c.onAccent,
      secondaryContainer: c.accentSoft,
      onSecondaryContainer: c.text,
      tertiary: c.highlight,
      onTertiary: SalebaTokens.neutral0,
      surface: c.surface,
      onSurface: c.text,
      onSurfaceVariant: c.textMuted,
      surfaceContainerLowest: c.bg,
      surfaceContainerLow: c.surfaceAlt,
      surfaceContainer: c.surfaceAlt,
      surfaceContainerHigh: c.surfaceAlt,
      surfaceContainerHighest: c.border,
      outline: isDark ? SalebaTokens.neutral600 : SalebaTokens.neutral300,
      outlineVariant: c.border,
      error: c.danger,
      onError: SalebaTokens.neutral0,
      errorContainer: c.dangerSoft,
      onErrorContainer: c.text,
      scrim: c.scrim,
      surfaceTint: Colors.transparent,
    );
    final text = SalebaTypography.textTheme(c.text, c.textMuted);
    final buttonText = text.labelLarge;
    final buttonShape = RoundedRectangleBorder(borderRadius: BorderRadius.circular(s.radiusSm));
    final buttonPadding = EdgeInsets.symmetric(horizontal: s.s4, vertical: s.s3);
    final minButton = Size(s.touchMin, s.touchMin);
    OutlineInputBorder field(Color color, [double width = 1]) => OutlineInputBorder(
      borderRadius: BorderRadius.circular(s.radiusSm),
      borderSide: BorderSide(color: color, width: width),
    );

    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      colorScheme: scheme,
      fontFamily: SalebaTypography.body,
      fontFamilyFallback: SalebaTypography.fallback,
      textTheme: text,
      scaffoldBackgroundColor: c.bg,
      canvasColor: c.bg,
      dividerColor: c.border,
      materialTapTargetSize: MaterialTapTargetSize.padded,
      appBarTheme: AppBarTheme(
        backgroundColor: c.bg,
        foregroundColor: c.text,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
        titleTextStyle: text.titleMedium,
        iconTheme: IconThemeData(color: c.text, size: 22),
      ),
      cardTheme: CardThemeData(
        color: c.surface,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(s.radiusMd),
          side: BorderSide(color: c.border),
        ),
      ),
      dialogTheme: DialogThemeData(
        backgroundColor: c.surface,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(s.radiusXl),
          side: BorderSide(color: c.border),
        ),
      ),
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: c.surface,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(s.radiusLg))),
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: c.surface,
        surfaceTintColor: Colors.transparent,
        indicatorColor: c.primarySoft,
        elevation: 0,
        height: 68,
        labelTextStyle: WidgetStateProperty.resolveWith((states) {
          final selected = states.contains(WidgetState.selected);
          return text.labelMedium?.copyWith(
            fontWeight: selected ? SalebaTokens.fontWeightSemibold : SalebaTokens.fontWeightRegular,
            color: selected ? c.primary : c.textMuted,
          );
        }),
        iconTheme: WidgetStateProperty.resolveWith(
          (states) =>
              IconThemeData(size: 22, color: states.contains(WidgetState.selected) ? c.primary : c.textMuted),
        ),
      ),
      navigationRailTheme: NavigationRailThemeData(
        backgroundColor: c.surface,
        indicatorColor: c.primarySoft,
        selectedIconTheme: IconThemeData(color: c.primary),
        unselectedIconTheme: IconThemeData(color: c.textMuted),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: c.surfaceAlt,
        isDense: true,
        contentPadding: EdgeInsets.symmetric(horizontal: s.s4, vertical: s.s3),
        hintStyle: text.bodyMedium?.copyWith(color: c.textMuted),
        labelStyle: text.bodyMedium?.copyWith(color: c.textMuted),
        border: field(c.border),
        enabledBorder: field(c.border),
        focusedBorder: field(c.primary, 1.5),
        errorBorder: field(c.danger),
        focusedErrorBorder: field(c.danger, 1.5),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: c.primary,
          foregroundColor: c.onPrimary,
          elevation: 0,
          minimumSize: minButton,
          padding: buttonPadding,
          shape: buttonShape,
          textStyle: buttonText,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: c.primary,
          foregroundColor: c.onPrimary,
          elevation: 0,
          minimumSize: minButton,
          padding: buttonPadding,
          shape: buttonShape,
          textStyle: buttonText,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: c.text,
          backgroundColor: c.surface,
          side: BorderSide(color: c.border),
          minimumSize: minButton,
          padding: buttonPadding,
          shape: buttonShape,
          textStyle: buttonText,
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: c.primary,
          minimumSize: minButton,
          shape: buttonShape,
          textStyle: buttonText,
        ),
      ),
      chipTheme: ChipThemeData(
        backgroundColor: c.surfaceAlt,
        selectedColor: c.primarySoft,
        side: BorderSide(color: c.border),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(s.radiusPill)),
        labelStyle: text.labelLarge?.copyWith(fontWeight: SalebaTokens.fontWeightMedium),
      ),
      dividerTheme: DividerThemeData(color: c.border, thickness: 1, space: 1),
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        backgroundColor: isDark ? SalebaTokens.neutral100 : SalebaTokens.neutral900,
        contentTextStyle: text.bodyMedium?.copyWith(
          color: isDark ? SalebaTokens.neutral900 : SalebaTokens.neutral0,
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(s.radiusSm)),
      ),
      progressIndicatorTheme: ProgressIndicatorThemeData(color: c.primary),
      extensions: [c, s],
    );
  }
}
