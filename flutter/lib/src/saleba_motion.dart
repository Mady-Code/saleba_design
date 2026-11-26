import 'package:flutter/widgets.dart';

import 'saleba_tokens.dart';

/// Motion tokens that honour the system "reduce motion" setting (charter §4).
abstract final class SalebaMotion {
  /// Standard easing curve of every Saleba animation.
  static const Curve curve = SalebaTokens.motionEase;

  /// Whether the user asked the system to reduce or disable animations.
  static bool reduceMotionOf(BuildContext context) =>
      MediaQuery.reduceMotionOf(context) || MediaQuery.disableAnimationsOf(context);

  /// [duration] (default: the `normal` token), or [Duration.zero] when motion is reduced.
  static Duration duration(BuildContext context, [Duration duration = SalebaTokens.motionNormal]) =>
      reduceMotionOf(context) ? Duration.zero : duration;
}
