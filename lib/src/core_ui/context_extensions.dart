part of 'core_ui.dart';

extension ContextX on BuildContext {
  TextDirection get textDirection => Directionality.of(this);
  bool get ltr => textDirection == TextDirection.ltr;
  bool get rtl => textDirection == TextDirection.rtl;

  T resolveDirection<T>(T ltr, T rtl) {
    switch (textDirection) {
      case TextDirection.ltr:
        return ltr;
      case TextDirection.rtl:
        return rtl;
    }
  }
}

extension EdgeInsetsDirectionalX on EdgeInsetsDirectional {
  EdgeInsets resolveFrom(BuildContext context) =>
      resolve(context.textDirection);
}

extension AlignmentDirectionalX on AlignmentDirectional {
  Alignment resolveFrom(BuildContext context) => resolve(context.textDirection);
}

extension BrightnessCheckData on ThemeData {
  bool get isDark => brightness == Brightness.dark;
  bool get isLight => brightness == Brightness.light;

  /// Returns the interpolation value between different [Theme]s when app's
  /// [Theme] animates.
  ///
  /// Returns 0.0 when the theme is light, 1.0 when the theme is dark.
  ///
  /// The app's [Theme] at any point is not only determined the animation state
  /// of [AnimatedTheme], which is not 0.0 or 1.0 when user is switching between
  /// light and dark themes.
  ///
  /// [ThemeExtension] doesn't have the flexibility we need, so this method
  /// calculates the current "lerp value" between the light and dark themes, so
  /// even custom colors or numbers animates.
  ///
  /// The trick here is to use the [switchTheme.splashRadius] property, which
  /// is a double value that we define to animate between 0.0 and 1.0. This
  /// value is not used anywhere else in the app.
  ///
  double get interpolationValue => switchTheme.splashRadius!;

  double resolveNum<T extends num>(
    T light,
    T dark, {
    ThemeMode mode = ThemeMode.system,
    bool inverse = false,
  }) {
    final a = (inverse ? dark : light).toDouble();
    final b = (inverse ? light : dark).toDouble();
    switch (mode) {
      case ThemeMode.light:
        return a;
      case ThemeMode.dark:
        return b;
      case ThemeMode.system:
        final a = light.toDouble();
        final b = dark.toDouble();
        final t = interpolationValue;
        if (a == b || (a.isNaN) && (b.isNaN)) {
          return a;
        }
        assert(
          a.isFinite,
          'Cannot interpolate between finite and non-finite values',
        );
        assert(
          b.isFinite,
          'Cannot interpolate between finite and non-finite values',
        );
        assert(
          t.isFinite,
          't must be finite when interpolating between values',
        );
        return a * (1.0 - t) + b * t;
    }
  }

  BorderSide resolveBorderSide(BorderSide light, BorderSide dark) {
    return BorderSide.lerp(light, dark, interpolationValue);
  }

  /// Resolves any type [T] between [light] and [dark] based on the current
  /// [Theme.brightness] and an optional [mode].
  ///
  /// Should not be used in favor of type-specific methods like [resolveColor]
  /// or [resolveNum] when possible, since this method does not interpolate
  /// between the two values when the theme is animating.
  ///
  T resolveBrightness<T>(T light, T dark, [ThemeMode mode = ThemeMode.system]) {
    switch (mode) {
      case ThemeMode.system:
        return isDark ? dark : light;
      case ThemeMode.light:
        return light;
      case ThemeMode.dark:
        return dark;
    }
  }

  Color resolveColor(
    Color light,
    Color dark, {
    bool inverse = false,
    bool isHighContrast = false,
    ThemeMode mode = ThemeMode.system,
  }) {
    switch (mode) {
      case ThemeMode.light:
        return inverse ? dark : light;
      case ThemeMode.dark:
        return inverse ? light : dark;
      case ThemeMode.system:
        final dynamicColor = CupertinoDynamicColor.withBrightness(
          color: light,
          darkColor: dark,
        );
        return inverse
            ? dynamicColor.reverseResolveWithTheme(
              this,
              isHighContrast: isHighContrast,
            )
            : dynamicColor.resolveWithTheme(
              this,
              isHighContrast: isHighContrast,
            );
    }
  }
}

extension BrightnessUtils on Brightness {
  bool get isDark => this == Brightness.dark;
  bool get isLight => this == Brightness.light;
}
