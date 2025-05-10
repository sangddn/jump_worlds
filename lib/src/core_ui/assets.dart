part of 'core_ui.dart';

enum UiAsset {
  // Logos
  agentIconLightBackground('$_logo/agent_icon_light', 'png'),
  agentIconDarkBackground('$_logo/agent_icon_dark', 'jpg'),
  playCubeLightBackground('$_logo/play_cube_light', 'jpg'),
  playCubeDarkBackground('$_logo/play_cube_dark', 'jpg'),
  wordmarkLight('$_logo/wordmark_light', 'svg'),
  wordmarkDark('$_logo/wordmark_dark', 'svg'),
  wordmarkIconLight('$_logo/wordmark_icon_light', 'svg'),
  wordmarkIconDark('$_logo/wordmark_icon_dark', 'svg'),
  agentIconLight('$_logo/agent_icon_light_mode_no_background', 'svg'),
  agentIconDark('$_logo/agent_icon_dark_mode_no_background', 'svg'),
  playCubeLight('$_logo/play_cube_light_mode_no_background', 'svg'),
  playCubeDark('$_logo/play_cube_dark_mode_no_background', 'svg'),

  // Playcast specific
  playcastAlbers1Light('$_playcast/PlayCube-Albers-01', 'png'),
  playcastAlbers1Dark('$_playcast/PlayCube-Albers-01 - Dark', 'png'),
  playcastAlbers2Light('$_playcast/PlayCube-Albers-02', 'png'),
  playcastAlbers2Dark('$_playcast/PlayCube-Albers-02 - Dark', 'png'),
  playcastAlbers3Light('$_playcast/PlayCube-Albers-03', 'png'),
  playcastAlbers3Dark('$_playcast/PlayCube-Albers-03 - Dark', 'png'),
  playcastAlbers4Light('$_playcast/PlayCube-Albers-04', 'png'),
  playcastAlbers4Dark('$_playcast/PlayCube-Albers-04 - Dark', 'png'),
  playcastAlbers5Light('$_playcast/PlayCube-Albers-05', 'png'),
  playcastAlbers5Dark('$_playcast/PlayCube-Albers-05 - Dark', 'png'),
  playcastAlbers6Light('$_playcast/PlayCube-Albers-06', 'png'),
  playcastAlbers6Dark('$_playcast/PlayCube-Albers-06 - Dark', 'png'),
  playcastSpectrum1('$_playcast/PlayCubeSpectrum - 01', 'png'),
  playcastSpectrum2('$_playcast/PlayCubeSpectrum - 02', 'png'),
  playcastSpectrum3('$_playcast/PlayCubeSpectrum - 03', 'png'),
  playcastSpectrum4('$_playcast/PlayCubeSpectrum - 04', 'png'),
  playcastSpectrum5('$_playcast/PlayCubeSpectrum - 05', 'png'),
  playcastSpectrum6('$_playcast/PlayCubeSpectrum - 06', 'png'),

  // Haptics
  gravel('$_haptics/gravel', 'ahap'),
  heartbeats('$_haptics/heartbeats', 'ahap'),
  inflate('$_haptics/inflate', 'ahap'),
  rumble('$_haptics/rumble', 'ahap'),
  texture('$_haptics/texture', 'ahap'),

  // Sound effects
  correctSoundEffect('$_sound/correct', 'mp3'),
  incorrectSoundEffect('$_sound/incorrect', 'mp3'),
  successSoundEffect('$_sound/success', 'mp3'),

  // Logos
  googleColor('$_others/google_logo_color', 'svg');

  const UiAsset(this.pathWoExt, this.ext);

  final String pathWoExt;
  final String ext;
}

const _assets = 'assets';
const _image = '$_assets/images';
const _haptics = '$_assets/haptics';
// const _anim = '$_assets/animations';
const _sound = '$_assets/sounds';
const _logo = '$_image/logos';
const _playcast = '$_logo/playcast';
const _others = '$_image/others';
const _precompiledSvg = '$_assets/precompiled_svgs';

extension UiAssetX on UiAsset {
  String get path => '$pathWoExt.$ext';
  String get name => pathWoExt.split('/').last;
  bool get isSvg => ext == 'svg';
  bool get isPng => ext == 'png';
  bool get isJpeg => ext == 'jpeg' || ext == 'jpg';
  bool get isGif => ext == 'gif';
  bool get isJson => ext == 'json';
  bool get isAhap => ext == 'ahap';

  String get precompiledSvgPath {
    if (ext != 'svg') throw UnsupportedError('Only SVGs can be precompiled');
    return '$_precompiledSvg/$name.si';
  }

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

class SvgIcon extends StatelessWidget {
  const SvgIcon(
    this.asset, {
    this.filterColor = true,
    this.scale = 1,
    this.size,
    super.key,
  });

  final UiAsset asset;
  final bool filterColor;
  final double scale;
  final double? size;

  @override
  Widget build(BuildContext context) {
    final iconTheme = IconTheme.of(context);
    final assetPath = asset.precompiledSvgPath;

    assert(assetPath.endsWith('.si'), 'SVG asset must be a ScalableImage');

    final child = SizedBox(
      height: size ?? iconTheme.size,
      width: size ?? iconTheme.size,
      child: ScalableImageWidget.fromSISource(
        si: ScalableImageSource.fromSI(rootBundle, assetPath),
        scale: scale,
      ),
    );

    if (filterColor) {
      return ColorFiltered(
        colorFilter: ui.ColorFilter.mode(
          iconTheme.color ?? Theme.of(context).colorScheme.onSurface,
          BlendMode.srcIn,
        ),
        child: child,
      );
    }

    return child;
  }
}

class SvgImage extends StatelessWidget {
  const SvgImage(this.asset, {super.key, this.scale = 1});

  final double scale;
  final UiAsset asset;

  @override
  Widget build(BuildContext context) {
    return ScalableImageWidget.fromSISource(
      si: ScalableImageSource.fromSI(rootBundle, asset.precompiledSvgPath),
      scale: scale,
    );
  }
}
