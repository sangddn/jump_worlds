import 'dart:async';
import 'dart:ui' as ui;

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:palette_generator/palette_generator.dart';

import '../database/database.dart';

extension ColorUtilsExtension on Color {
  String toHexStringRGB() {
    return '${(r * 255).round().toRadixString(16).padLeft(2, '0')}'
        '${(g * 255).round().toRadixString(16).padLeft(2, '0')}'
        '${(b * 255).round().toRadixString(16).padLeft(2, '0')}';
  }
}

extension ColorTintsShades on Color {
  /// Internal method to convert the Color to a list of RGB values.
  List<double> _toRgb() {
    return [r, g, b];
  }

  /// Internal method to create a Color from RGB values.
  static Color _fromRgb(double r, double g, double b, [double opacity = 1.0]) {
    // return Color.from(red: r, green: g, blue: b, alpha: opacity);
    return Color.from(alpha: opacity, red: r, green: g, blue: b);
  }

  /// Internal method to create a tint of the Color.
  Color tint(double factor) {
    assert(factor >= 0 && factor <= 1, 'Factor must be between 0 and 1');

    final rgb = _toRgb();
    final tintedRgb = rgb.map((c) => c + ((1.0 - c) * factor)).toList();

    return _fromRgb(tintedRgb[0], tintedRgb[1], tintedRgb[2], a);
  }

  /// Internal method to create a shade of the Color.
  Color shade(double factor) {
    assert(factor >= 0 && factor <= 1, 'Factor must be between 0 and 1');

    final rgb = _toRgb();
    final shadedRgb = rgb.map((c) => c * (1.0 - factor)).toList();
    return _fromRgb(shadedRgb[0], shadedRgb[1], shadedRgb[2], a);
  }

  // Tint methods
  Color get tint10 => tint(0.1);
  Color get tint20 => tint(0.2);
  Color get tint30 => tint(0.3);
  Color get tint40 => tint(0.4);
  Color get tint50 => tint(0.5);
  Color get tint60 => tint(0.6);
  Color get tint70 => tint(0.7);
  Color get tint80 => tint(0.8);
  Color get tint90 => tint(0.9);

  // Shade methods
  Color get shade10 => shade(0.1);
  Color get shade20 => shade(0.2);
  Color get shade30 => shade(0.3);
  Color get shade40 => shade(0.4);
  Color get shade50 => shade(0.5);
  Color get shade60 => shade(0.6);
  Color get shade70 => shade(0.7);
  Color get shade80 => shade(0.8);
  Color get shade90 => shade(0.9);

  /// Dynamically create a tint or shade of the Color based on brightness.
  ///
  /// If the theme is light, the Color will be tinted with [tintFactor].
  /// If the theme is dark, the Color will be shaded with [shadeFactor], or [tintFactor]
  /// if [shadeFactor] is not provided.
  Color adjustForBrightness(
    BuildContext context,
    double tintFactor, [
    double? shadeFactor,
  ]) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return isDark ? shade(shadeFactor ?? tintFactor) : tint(tintFactor);
  }

  /// Dynamically create a tint of the Color based on brightness.
  Color resolveTint(
    BuildContext context,
    double lightFactor,
    double darkFactor,
  ) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return isDark ? tint(darkFactor) : tint(lightFactor);
  }

  Color adaptForDarkMode() {
    final hsl = HSLColor.fromColor(this);
    final lightness = hsl.lightness;
    final saturation = hsl.saturation;
    final hue = hsl.hue;

    if (lightness <= 0.75) {
      return HSLColor.fromAHSL(1.0, hue, saturation, 0.75).toColor();
    }

    return this;
  }

  Color adaptForLightMode() {
    final hsl = HSLColor.fromColor(this);
    final lightness = hsl.lightness;
    final saturation = hsl.saturation;
    final hue = hsl.hue;

    if (lightness > 0.4) {
      return HSLColor.fromAHSL(1.0, hue, saturation, 0.4).toColor();
    }

    return this;
  }

  Color adaptForContext(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    switch (brightness) {
      case Brightness.light:
        return adaptForLightMode();
      case Brightness.dark:
        return adaptForDarkMode();
    }
  }

  Color inverseAdaptForContext(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    switch (brightness) {
      case Brightness.light:
        return adaptForDarkMode();
      case Brightness.dark:
        return adaptForLightMode();
    }
  }

  Color getBolderShade({
    double saturationFactor = 1.2,
    double lightnessAdjustment = -0.05,
  }) {
    // Convert the color to HSL
    final hsl = HSLColor.fromColor(this);

    // Increase the saturation (within bounds of 0.0 to 1.0)
    final newSaturation = (hsl.saturation * saturationFactor).clamp(0.0, 1.0);

    // Adjust the lightness (make it slightly darker, but not too much)
    final newLightness = (hsl.lightness + lightnessAdjustment).clamp(0.0, 1.0);

    // Return the new color with updated saturation and lightness
    return hsl
        .withSaturation(newSaturation)
        .withLightness(newLightness)
        .toColor();
  }
}

class ColorUtils {
  static Color colorFromHexString(String hexString) {
    final hex = hexString.replaceFirst('#', '');
    final r = int.parse(hex.substring(0, 2), radix: 16);
    final g = int.parse(hex.substring(2, 4), radix: 16);
    final b = int.parse(hex.substring(4, 6), radix: 16);
    return Color.fromARGB(255, r, g, b);
  }

  static Color getInverseColor(Color color) {
    final r = 1.0 - color.r;
    final g = 1.0 - color.g;
    final b = 1.0 - color.b;

    // return Color.from(
    //   alpha: color.a,
    //   red: r,
    //   green: g,
    //   blue: b,
    // );
    return Color.fromARGB(
      (color.a * 255).round(),
      (r * 255).round(),
      (g * 255).round(),
      (b * 255).round(),
    );
  }

  static Future<List<Color>> detectImageColors(
    ImageProvider image, [
    int maximumColorCount = 6,
  ]) async {
    try {
      final paletteGenerator = await PaletteGenerator.fromImageProvider(
        image,
        maximumColorCount: maximumColorCount,
        timeout: const Duration(seconds: 5),
      );
      return paletteGenerator.colors.toList();
    } on TimeoutException {
      return [];
    }
  }

  /// Get the vibrant colors of an image.
  ///
  /// [onPaletteObtained] is a callback that is called with the [PaletteGenerator]
  /// after it is obtained. This is not called if the palette is cached.
  ///
  static Future<CupertinoDynamicColor> getVibrantColors(
    ImageProvider imageProvider,
    String cacheKey, {
    required DatabaseInterface db,
    CupertinoDynamicColor? fallbackColors,
    ValueChanged<PaletteGenerator>? onPaletteObtained,
  }) {
    final serverRef = db.stringRef;
    // debugPrint('Generating palette for $cacheKey.');

    // Skip cache if onPaletteObtained is provided.
    if (onPaletteObtained == null) {
      final cachedLight = serverRef.get(
        '$cacheKey-vibrantcolors-light'.hashCode,
      );
      final cachedDark = serverRef.get('$cacheKey-vibrantcolors-dark'.hashCode);

      if (cachedLight != null && cachedDark != null) {
        // debugPrint('Palette found in cache.');
        return SynchronousFuture(
          CupertinoDynamicColor.withBrightness(
            color: colorFromHexString(cachedLight),
            darkColor: colorFromHexString(cachedDark),
          ),
        );
      }
    }

    return _getVibrantColors(
      imageProvider,
      cacheKey,
      db: db,
      fallbackColors: fallbackColors,
      onPaletteObtained: onPaletteObtained,
    );
  }

  static Future<CupertinoDynamicColor> _getVibrantColors(
    ImageProvider imageProvider,
    String cacheKey, {
    required DatabaseInterface db,
    CupertinoDynamicColor? fallbackColors,
    ValueChanged<PaletteGenerator>? onPaletteObtained,
  }) async {
    try {
      final palette = await generatePalette(imageProvider);
      onPaletteObtained?.call(palette);
      // debugPrint('Palette generated. Called $onPaletteObtained.');
      final muted = palette.mutedColor?.color;
      final lightMuted = palette.lightMutedColor?.color;
      final darkMuted = palette.darkMutedColor?.color;
      final vibrant = palette.vibrantColor?.color;
      final lightVibrant = palette.lightVibrantColor?.color;
      final darkVibrant = palette.darkVibrantColor?.color;

      final light =
          darkMuted ??
          lightMuted ??
          fallbackColors?.color ??
          Colors.transparent;

      final dark =
          lightVibrant ??
          vibrant ??
          darkVibrant ??
          muted ??
          fallbackColors?.darkColor ??
          Colors.transparent;

      db.stringRef.putAll({
        '$cacheKey-vibrantcolors-light'.hashCode: light.toHexStringRGB(),
        '$cacheKey-vibrantcolors-dark'.hashCode: dark.toHexStringRGB(),
      });

      return CupertinoDynamicColor.withBrightness(
        color: light,
        darkColor: dark,
      );
    } on TimeoutException {
      return const CupertinoDynamicColor.withBrightness(
        color: Colors.transparent,
        darkColor: Colors.transparent,
      );
    }
  }

  static Future<PaletteGenerator> generatePalette(
    ImageProvider imageProvider,
  ) async {
    final ImageStream stream = imageProvider.resolve(
      const ImageConfiguration(size: Size(200.0, 200.0), devicePixelRatio: 1.0),
    );
    final imageCompleter = Completer<ui.Image>();
    Timer? loadFailureTimeout;
    late ImageStreamListener listener;
    listener = ImageStreamListener((ImageInfo info, bool synchronousCall) {
      loadFailureTimeout?.cancel();
      stream.removeListener(listener);
      imageCompleter.complete(info.image);
    });
    loadFailureTimeout = Timer(const Duration(seconds: 5), () {
      stream.removeListener(listener);
      imageCompleter.completeError(
        TimeoutException('Timeout occurred trying to load from $imageProvider'),
      );
    });
    stream.addListener(listener);
    final image = await imageCompleter.future;
    final imageData = await image.toByteData();
    if (imageData == null) {
      throw StateError('Failed to encode the image.');
    }

    return compute(_generatePalette, (imageData, image.width, image.height));
  }
}

Future<PaletteGenerator> _generatePalette(
  (ByteData data, int width, int height) m,
) {
  return PaletteGenerator.fromByteData(
    EncodedImage(m.$1, width: m.$2, height: m.$3),
    maximumColorCount: 6,
  );
}
