import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:saleba_design/saleba_design.dart';

void main() {
  test('light and dark themes carry the Saleba roles and spacing', () {
    final light = SalebaTheme.light();
    final dark = SalebaTheme.dark();
    expect(light.colorScheme.primary, SalebaTokens.lightPrimary);
    expect(light.scaffoldBackgroundColor, SalebaTokens.lightBg);
    expect(dark.colorScheme.primary, SalebaTokens.darkPrimary);
    expect(dark.colorScheme.onPrimary, SalebaTokens.darkOnPrimary);
    expect(light.extension<SalebaColors>(), same(SalebaColors.light));
    expect(dark.extension<SalebaColors>(), same(SalebaColors.dark));
    expect(light.extension<SalebaSpacing>(), same(SalebaSpacing.standard));
  });

  test('tenant accent changes the secondary colour, not the primary', () {
    final theme = SalebaTheme.light(tenantAccent: SalebaTokens.data3);
    expect(theme.colorScheme.secondary, SalebaTokens.data3);
    expect(theme.colorScheme.primary, SalebaTokens.lightPrimary);
  });

  test('buttons keep the 48 px touch target', () {
    final size = SalebaTheme.light().filledButtonTheme.style!.minimumSize!.resolve({});
    expect(size, const Size(SalebaTokens.sizeTouchMin, SalebaTokens.sizeTouchMin));
  });

  test('TV spacing scales every value', () {
    final tv = SalebaSpacing.standard.scaled(1.5);
    expect(tv.s4, SalebaTokens.space4 * 1.5);
    expect(tv.posKey, SalebaTokens.sizePosKey * 1.5);
  });

  test('typography uses the embedded fonts and tabular amounts', () {
    final text = SalebaTheme.light().textTheme;
    expect(text.headlineMedium!.fontFamily, 'packages/saleba_design/Plus Jakarta Sans');
    expect(text.bodyMedium!.fontFamily, 'packages/saleba_design/Inter');
    expect(SalebaTypography.amount().fontFeatures, SalebaTypography.tabular);
  });

  testWidgets('of(context) reads the extensions and motion honours reduce motion', (tester) async {
    late SalebaColors colors;
    late Duration duration;
    await tester.pumpWidget(
      MaterialApp(
        theme: SalebaTheme.light(),
        darkTheme: SalebaTheme.dark(),
        themeMode: ThemeMode.dark,
        home: MediaQuery(
          data: const MediaQueryData(disableAnimations: true),
          child: Builder(
            builder: (context) {
              colors = SalebaColors.of(context);
              duration = SalebaMotion.duration(context);
              return const SizedBox();
            },
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();
    expect(colors.primary, SalebaTokens.darkPrimary);
    expect(duration, Duration.zero);
  });
}
