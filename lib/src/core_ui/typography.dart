part of 'core_ui.dart';

extension TextStyleUtils on TextStyle {
  TextStyle rubikMono() => apply(
    fontFamily: 'RubikMonoOne',
    letterSpacingDelta: 1.25,
    fontWeightDelta: 2,
  );

  /// Modifies the weight of the font.
  ///
  /// Fractional weight deltas are only supported for variable fonts.
  /// For non-variable fonts such as, [delta] will be rounded to the nearest
  /// integer.
  ///
  /// A [delta] value of `0.0` will return the current [TextStyle] without any
  /// changes. A non-zero [delta] value will be added the weight in multiples
  /// of `100`. Typically, the weight is clamped below by `100` and above by
  /// `900`, but the exact effect can vary depending on the font.
  ///
  TextStyle addWeight(double delta) {
    if (delta == 0.0) return this;
    final weight =
        fontVariations
                ?.firstWhereOrNull((variation) => variation.axis == 'wght')
                ?.value
            as num?;
    if (weight != null && fontVariations == null) {
      return apply(fontWeightDelta: delta.round());
    }
    return copyWith(
      fontVariations: [FontVariation.weight((weight ?? 400) + delta * 100)],
    );
  }

  /// Modifies the letter spacing of the font if the language is not in the
  /// [avoidedLangs] list.
  ///
  /// Defaults to `0.0`, which is the normal letter spacing. A positive value
  /// will increase the letter spacing, and a negative value will decrease it.
  ///
  TextStyle withLetterSpacing(double delta) {
    return apply(letterSpacingDelta: delta);
  }

  /// Modifies the width of the font. This is only supported
  /// for variable fonts such as [kLabelFontFamily].
  ///
  /// Note that [kFontFamily] does not support width modification.
  ///
  /// Defaults to `1.0`, which is the normal width. A value greater
  /// than `1.0` will expand the width, and a value less than `1.0`
  /// will condense the width.
  ///
  // TextStyle modifyWidth([double width = 1.0]) => copyWith(
  //       fontVariations: [FontVariation.width(width * 100.0)],
  //     );

  TextStyle enableFeature(String feature) {
    return copyWith(
      fontFeatures: [...?fontFeatures, FontFeature.enable(feature)],
    );
  }

  TextStyle enableFeatures(List<String> features) {
    return copyWith(
      fontFeatures: [...?fontFeatures, ...features.map(FontFeature.enable)],
    );
  }

  TextStyle disableFeature(String feature) {
    return copyWith(
      fontFeatures: [...?fontFeatures, FontFeature.disable(feature)],
    );
  }

  TextStyle disableFeatures(List<String> features) {
    return copyWith(
      fontFeatures: [...?fontFeatures, ...features.map(FontFeature.disable)],
    );
  }

  TextStyle withColor(Color color) => apply(color: color);

  TextStyle gray(BuildContext context) => withColor(context.colors.gray300);

  TextStyle darkGray(BuildContext context) => withColor(context.colors.gray500);

  TextStyle textGray(BuildContext context) => withColor(context.colors.gray700);
}

extension type PTextTheme(TextTheme textTheme) {
  static PTextTheme of(BuildContext context) =>
      PTextTheme(TextTheme.of(context));

  TextStyle get display1 =>
      textTheme.displayLarge!.apply(letterSpacingDelta: -1.5).addWeight(3.0);
  TextStyle get display2 =>
      textTheme.displayMedium!.apply(letterSpacingDelta: -1.5).addWeight(2.5);
  TextStyle get display3 =>
      textTheme.displaySmall!.apply(letterSpacingDelta: -2).addWeight(2.0);
  TextStyle get h1 =>
      textTheme.headlineLarge!.apply(letterSpacingDelta: -1.5).addWeight(3.0);
  TextStyle get h2 =>
      textTheme.headlineMedium!.apply(letterSpacingDelta: -1.5).addWeight(2.5);
  TextStyle get h3 =>
      textTheme.headlineSmall!.apply(letterSpacingDelta: -1.5).addWeight(2.0);
  TextStyle get h4 =>
      textTheme.titleLarge!.apply(letterSpacingDelta: -.75).addWeight(1.0);
  TextStyle get h5 =>
      textTheme.titleMedium!.apply(letterSpacingDelta: -.75).addWeight(.5);
  TextStyle get h6 =>
      textTheme.titleSmall!.apply(letterSpacingDelta: -.75).addWeight(.25);
  TextStyle get title => textTheme.bodyLarge!.apply(letterSpacingDelta: -.5);
  TextStyle get p => textTheme.bodyMedium!.apply(letterSpacingDelta: -.5);
  TextStyle get caption => textTheme.bodySmall!.apply(letterSpacingDelta: -.4);
  TextStyle get label =>
      textTheme.labelLarge!.apply(letterSpacingDelta: -.35).addWeight(.5);
  TextStyle get small =>
      textTheme.labelMedium!.apply(letterSpacingDelta: -.35).addWeight(.5);
  TextStyle get tiny =>
      textTheme.labelSmall!.apply(letterSpacingDelta: -.35).addWeight(.5);
}
