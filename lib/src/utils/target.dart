import 'package:flutter/foundation.dart';

/// Enum representing the target platform.
///
/// This enum is used to determine the current platform the app is running on,
/// and to provide a way to conditionally execute code based on the platform.
///
/// The enum has four values: `android`, `ios`, `macos`, and `web`.
///
/// The `isWeb` getter is a constant that returns `true` if the app is running on the web,
/// regardless of whether the app is running in a browser on a desktop or mobile device.
///
enum Target {
  android,
  ios,
  macos,
  web;

  static const isWeb = kIsWeb;

  static final isAndroid = defaultTargetPlatform == TargetPlatform.android;
  static final isIos = defaultTargetPlatform == TargetPlatform.iOS;
  static final isMacOS = defaultTargetPlatform == TargetPlatform.macOS;
  static final isWindows = defaultTargetPlatform == TargetPlatform.windows;
  static final isLinux = defaultTargetPlatform == TargetPlatform.linux;

  static final isNativeAndroid = !isWeb && isAndroid;
  static final isNativeIos = !isWeb && isIos;
  static final isNativeMacOS = !isWeb && isMacOS;
  static final isNativeWindows = !isWeb && isWindows;
  static final isNativeLinux = !isWeb && isLinux;

  static final isWebAndroid = isWeb && isAndroid;
  static final isWebIos = isWeb && isIos;
  static final isWebMacOS = isWeb && isMacOS;
  static final isWebWindows = isWeb && isWindows;
  static final isWebLinux = isWeb && isLinux;

  static final isNativeApple = isNativeIos || isNativeMacOS;
  static final isNativeMobile = isNativeAndroid || isNativeIos;
  static final isDesktop = isNativeMacOS || isNativeWindows || isNativeLinux;

  /// Returns the current platform the app is running on.
  ///
  /// If the app is running on the web, `web` takes precedence over `android`,
  /// `ios`, and `macos`. To check for native platforms, use [currentNative].
  ///
  static Target get current {
    if (isWeb) {
      return web;
    }
    if (isNativeAndroid) {
      return android;
    }
    if (isNativeIos) {
      return ios;
    }
    if (isNativeMacOS) {
      return macos;
    }
    throw UnsupportedError('Unsupported platform');
  }

  /// Returns the current native platform the app is running on, even if the app
  /// is running on the web.
  ///
  static Target get currentNative {
    if (isAndroid) {
      return android;
    }
    if (isIos) {
      return ios;
    }
    if (isMacOS) {
      return macos;
    }
    throw UnsupportedError('Unsupported platform');
  }

  static bool isOneOf(List<Target> platforms) {
    return platforms.contains(current);
  }

  static T select<T>({required T android, required T ios, T? macos, T? web}) {
    switch (current) {
      case Target.android:
        return android;
      case Target.ios:
        return ios;
      case Target.macos:
        return macos ?? ios;
      case Target.web:
        return web ?? macos ?? ios;
    }
  }
}
