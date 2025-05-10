part of 'core_ui.dart';

enum UiAsset {
  // Buns
  bun('$_image/bun', 'png'),
  happyBun('$_image/happy_bun', 'png'),
  laughingBun('$_image/laughing_bun', 'png'),
  sadBun('$_image/sad_bun', 'png'),
  teacherBun('$_image/teacher_bun', 'png'),
  victoriousBun('$_image/victorious_bun', 'png'),
  readyBun('$_image/ready_bun', 'png'),

  // Haptics
  gravel('$_haptics/gravel', 'ahap'),
  heartbeats('$_haptics/heartbeats', 'ahap'),
  inflate('$_haptics/inflate', 'ahap'),
  rumble('$_haptics/rumble', 'ahap'),
  texture('$_haptics/texture', 'ahap'),

  // Sound effects
  correctSoundEffect('$_sound/correct', 'mp3'),
  incorrectSoundEffect('$_sound/incorrect', 'mp3'),
  successSoundEffect('$_sound/success', 'mp3');

  const UiAsset(this.pathWoExt, this.ext);

  final String pathWoExt;
  final String ext;
}

const _assets = 'assets';
const _image = '$_assets/images';
const _haptics = '$_assets/haptics';
const _sound = '$_assets/sounds';

extension UiAssetX on UiAsset {
  String get path => '$pathWoExt.$ext';
  String get name => pathWoExt.split('/').last;
  bool get isSvg => ext == 'svg';
  bool get isPng => ext == 'png';
  bool get isJpeg => ext == 'jpeg' || ext == 'jpg';
  bool get isGif => ext == 'gif';
  bool get isJson => ext == 'json';
  bool get isAhap => ext == 'ahap';

  // String get precompiledSvgPath {
  //   if (ext != 'svg') throw UnsupportedError('Only SVGs can be precompiled');
  //   return '$_precompiledSvg/$name.si';
  // }

  /// Returns an [ImageProvider] for the asset.
  ///
  /// This does not support SVGs. If the asset is an SVG, it must be precompiled
  /// and used with [ScalableImageWidget].
  ///
  ImageProvider toImageProvider() {
    if (isSvg) throw UnsupportedError('SVGs must be precompiled');
    return AssetImage(path) as ImageProvider;
  }
}

// class SvgIcon extends StatelessWidget {
//   const SvgIcon(
//     this.asset, {
//     this.filterColor = true,
//     this.scale = 1,
//     this.size,
//     super.key,
//   });

//   final UiAsset asset;
//   final bool filterColor;
//   final double scale;
//   final double? size;

//   @override
//   Widget build(BuildContext context) {
//     final iconTheme = IconTheme.of(context);
//     final assetPath = asset.precompiledSvgPath;

//     assert(assetPath.endsWith('.si'), 'SVG asset must be a ScalableImage');

//     final child = SizedBox(
//       height: size ?? iconTheme.size,
//       width: size ?? iconTheme.size,
//       child: ScalableImageWidget.fromSISource(
//         si: ScalableImageSource.fromSI(rootBundle, assetPath),
//         scale: scale,
//       ),
//     );

//     if (filterColor) {
//       return ColorFiltered(
//         colorFilter: ui.ColorFilter.mode(
//           iconTheme.color ?? Theme.of(context).colorScheme.onSurface,
//           BlendMode.srcIn,
//         ),
//         child: child,
//       );
//     }

//     return child;
//   }
// }

// class SvgImage extends StatelessWidget {
//   const SvgImage(this.asset, {super.key, this.scale = 1});

//   final double scale;
//   final UiAsset asset;

//   @override
//   Widget build(BuildContext context) {
//     return ScalableImageWidget.fromSISource(
//       si: ScalableImageSource.fromSI(rootBundle, asset.precompiledSvgPath),
//       scale: scale,
//     );
//   }
// }
