import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_adaptive_scaffold/flutter_adaptive_scaffold.dart';

/// Default scroll physics for scrollable widgets
const AlwaysScrollableScrollPhysics kDefaultScrollPhysics =
    AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics());

/// Default app constants string
class AppDefaults {
  const AppDefaults._();
  static const appName = 'CartUser Delivery App';
}

String kError([String errorOn = '']) =>
    'Something went wrong ${kDebugMode ? '[$errorOn]' : ''}';

class AppLayout {
  const AppLayout._();

  static const double maxMobile = 600;

  /// 0px to 600px
  static const small = Breakpoints.small;

  /// 600px to up
  static const large = Breakpoints.mediumAndUp;

  /// 0px to up
  static const all = Breakpoints.smallAndUp;
}

/// Default durations for animations
class Times {
  const Times._();

  /// 250 ms
  static const Duration defaultDuration = fast;
  static const Duration fast = Duration(milliseconds: 250);
  static const Duration fastest = Duration(milliseconds: 150);
  static const Duration medium = Duration(milliseconds: 350);
  static const Duration slow = Duration(milliseconds: 700);
  static const Duration slower = Duration(milliseconds: 1000);

  static const Duration extraSlow = Duration(milliseconds: 2000);

  static const Curve defaultCurve = Curves.easeInOutCubic;
}

/// Default insets constants for padding and margin
/// xs = 4, sm = 8, med = 12, lg = 16, xl = 32
/// offset = 40
class Insets {
  const Insets._();

  /// 2 px
  static const double xs = 2;

  /// 5 px
  static const double sm = 5;

  /// 10 px
  static const double med = 10;

  /// 16 px
  static const double lg = 16;

  /// 20 px
  static const double xl = 18;

  /// 40 px
  static const double offset = 40;

  static const padAll = EdgeInsets.all(lg);
  static const padH = EdgeInsets.symmetric(horizontal: lg);
  static const padV = EdgeInsets.symmetric(vertical: lg);
  static const padAllContainer = EdgeInsets.all(15);

  /// uses [med] as vertical padding (10 px)
  static padSym([double v = med, double h = med]) =>
      EdgeInsets.symmetric(vertical: v, horizontal: h);
}

/// Default corner radius constants for border radius
/// lg = 10, med = 8, sm = 3
class Corners {
  const Corners._();

  static const double lg = 24;
  static const BorderRadius lgBorder = BorderRadius.all(lgRadius);
  static const Radius lgRadius = Radius.circular(lg);

  static const double med = 12;
  static const BorderRadius medBorder = BorderRadius.all(medRadius);
  static const Radius medRadius = Radius.circular(med);

  static const double sm = 3;
  static const BorderRadius smBorder = BorderRadius.all(smRadius);
  static const Radius smRadius = Radius.circular(sm);
}
