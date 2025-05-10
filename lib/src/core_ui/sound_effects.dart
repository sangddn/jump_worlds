part of 'core_ui.dart';

// abstract final class SoundEffects {
//   static final _pool = Soundpool.fromOptions(
//     options: const SoundpoolOptions(
//       iosOptions: SoundpoolOptionsIos(
//         audioSessionCategory: AudioSessionCategory.ambient,
//       ),
//     ),
//   );
//   static final _cached = <UiAsset, int>{};

//   static Future<void> play(UiAsset sound, {double rate = 1.0}) async {
//     final soundId =
//         _cached[sound] ??
//         (await rootBundle.load(sound.path).then((bytes) async {
//           return _cached[sound] = await _pool.load(bytes);
//         }));
//     debugPrint('SoundEffects.play: $soundId');
//     if (soundId == null) {
//       return;
//     }
//     await _pool.play(soundId, rate: rate);
//     return;
//   }

//   static Future<void> playCorrect() => play(UiAsset.correctSoundEffect);
//   static Future<void> playIncorrect() => play(UiAsset.incorrectSoundEffect);
//   static Future<void> playSuccess() => play(UiAsset.successSoundEffect);
// }
