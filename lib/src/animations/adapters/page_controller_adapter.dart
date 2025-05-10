import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_animate/flutter_animate.dart';

/// {@template animations.adapters.page_controller_adapter}
/// A [PageControllerAdapter] drives an [Animate] animation from a
/// [PageController].
///
/// Set [direction] to [ScrollDirection.forward] or [ScrollDirection.reverse] to
/// only trigger updates when the scroll position increases or decreases respectively.
/// {@endtemplate}
class PageControllerAdapter extends Adapter {
  PageControllerAdapter(
    this.pageController, {
    required this.page,
    super.direction,
  });

  final PageController pageController;
  final int page;

  @override
  void attach(AnimationController controller) {
    config(
      controller,
      _getValue() ?? 0,
      notifier: pageController,
      listener: () {
        final double? value = _getValue();
        if (value != null) updateValue(value);
      },
    );
  }

  double? _getValue() {
    if (!pageController.hasClients) return null;
    try {
      final p = pageController.page;
      // ignore if out of 0..1 range
      if (p == null || p < page - 1 || p > page + 1) return null;
      // if moving forward from page - 1 to page, interpret as 0 to 1
      if (p <= page) return 1.0 - (page - p);
      // if moving backward from page + 1 to page, interpret as 1 to 0
      return page - p;
    } catch (_) {
      // ignore page controller assertions
      return null;
    }
  }
}

extension PageControllerExtension on Widget {
  /// Animates the widget with the page transition animation.
  ///
  /// {@macro animations.transitions.page_controller_adapter}
  Animate animateWithPageView(
    PageController pageController, {
    required int page,
    Direction? direction,
    // ignore: strict_raw_type
    List<Effect>? effects,
    AnimateCallback? onInit,
    AnimateCallback? onPlay,
    AnimateCallback? onComplete,
    bool autoPlay = true,
    AnimationController? controller,
  }) => animate(
    adapter: PageControllerAdapter(pageController, page: page),
    effects: effects,
    onInit: onInit,
    onPlay: onPlay,
    onComplete: onComplete,
    autoPlay: autoPlay,
    controller: controller,
  );
}
