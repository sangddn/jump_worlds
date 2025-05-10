import 'package:flutter/foundation.dart';

import 'custom_fade_forward_route.dart';
import 'custom_slide_route.dart';
import 'custom_zoom_route.dart';

export 'custom_fade_forward_route.dart';
export 'custom_slide_route.dart';
export 'custom_zoom_route.dart';
export 'route_transition_animation.dart';
export 'rta_provider.dart';

const kPageTransitionBuilders = {
  TargetPlatform.android: CustomFadeForwardsTransitionsBuilder(),
  TargetPlatform.iOS: CustomSlideTransitionsBuilder(),
  TargetPlatform.macOS: CustomSlideTransitionsBuilder(),
  TargetPlatform.windows: CustomZoomTransitionsBuilder(),
  TargetPlatform.linux: CustomZoomTransitionsBuilder(),
  TargetPlatform.fuchsia: CustomZoomTransitionsBuilder(),
};
