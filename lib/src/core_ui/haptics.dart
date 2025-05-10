part of 'core_ui.dart';

final _cachedHapticPatterns = <UiAsset, String>{};

class Haptics {
  static final Future<bool> _isSupported = Future.microtask(() async {
    return (Target.isNativeAndroid || Target.isNativeIos) &&
        await Gaimon.canSupportsHaptic;
  });

  static Future<void> _runIfSupported(VoidCallback fn) async {
    if (await _isSupported) {
      fn();
    }
  }

  static Future<void> _runPattern(UiAsset asset) async {
    debugPrint('Haptics._runPattern($asset)');
    assert(asset.isAhap);
    return _runIfSupported(() async {
      final cachedAsset = _cachedHapticPatterns[asset];
      final response = cachedAsset ?? await rootBundle.loadString(asset.path);
      if (cachedAsset == null) {
        _cachedHapticPatterns[asset] = response;
      }
      return Gaimon.patternFromData(response);
    });
  }

  static Future<void> selection() async {
    debugPrint('Haptics.selection()');
    return _runIfSupported(Gaimon.selection);
  }

  static Future<void> error() async {
    debugPrint('Haptics.error()');
    return _runIfSupported(Gaimon.error);
  }

  static Future<void> success() async {
    debugPrint('Haptics.success()');
    return _runIfSupported(Gaimon.success);
  }

  static Future<void> warning() async {
    debugPrint('Haptics.warning()');
    return _runIfSupported(Gaimon.warning);
  }

  static Future<void> heavyImpact() async {
    debugPrint('Haptics.heavyImpact()');
    return _runIfSupported(Gaimon.heavy);
  }

  static Future<void> mediumImpact() async {
    debugPrint('Haptics.mediumImpact()');
    return _runIfSupported(Gaimon.medium);
  }

  static Future<void> lightImpact() async {
    debugPrint('Haptics.lightImpact()');
    return _runIfSupported(Gaimon.light);
  }

  static Future<void> rigid() async {
    debugPrint('Haptics.rigid()');
    return _runIfSupported(Gaimon.rigid);
  }

  static Future<void> soft() async {
    debugPrint('Haptics.soft()');
    return _runIfSupported(Gaimon.soft);
  }

  static Future<void> rumble() async => _runPattern(UiAsset.rumble);

  static Future<void> gravel() async => _runPattern(UiAsset.gravel);

  static Future<void> heartbeats() async => _runPattern(UiAsset.heartbeats);

  static Future<void> inflate() async => _runPattern(UiAsset.inflate);

  static Future<void> texture() async => _runPattern(UiAsset.texture);
}
