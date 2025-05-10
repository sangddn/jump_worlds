part of 'core_ui.dart';

typedef MaybeScrollableBuilder =
    Widget Function(
      BuildContext context,
      ScrollController? scrollController,
      SheetController? sheetController,
    );

Future<T?> showModal<T>({
  required BuildContext context,
  required MaybeScrollableBuilder builder,
  double? minHeight,
  double? initHeight,
  double? maxHeight,
  bool isDismissible = true,
  bool isDraggable = false,
  bool useRootNavigator = false,
  bool shouldAvoidKeyboard = false,
  CupertinoDynamicColor? bottomSheetColor,
  CupertinoDynamicColor? barrierColor,
  Duration? duration,
  EdgeInsetsGeometry dialogPadding = k24HPadding,
  Decoration? decoration,
  BoxConstraints? dialogContraints,
  BoxConstraints? modalSheetContraints,
}) {
  if (context.isNarrow) {
    return Navigator.of(context, rootNavigator: useRootNavigator).push(
      CupertinoModalSheetRoute(
        swipeDismissible: isDismissible,
        barrierDismissible: isDismissible,
        barrierColor: barrierColor,
        transitionDuration: duration ?? const Duration(milliseconds: 300),
        builder:
            (modalContext) => _ModalWrapper(
              isDraggable: isDraggable,
              initHeight: initHeight,
              minHeight: minHeight,
              maxHeight: maxHeight,
              bottomSheetColor: bottomSheetColor,
              decoration: decoration,
              shouldAvoidKeyboard: shouldAvoidKeyboard,
              modalSheetContraints: modalSheetContraints,
              builder: builder,
            ),
      ),
    );
  } else {
    return showPDialog<T>(
      context: context,
      builder: (context) => builder(context, null, null),
      isDismissible: isDismissible,
      maxHeight: maxHeight,
      dialogContraints: dialogContraints,
      barrierColor: barrierColor,
      useRootNavigator: useRootNavigator,
      padding: dialogPadding,
    );
  }
}

enum DialogTransition {
  fadeSlide,
  fadeScale;

  Widget Function(Animation<double> animation, Widget background, Widget child)
  get builder => switch (this) {
    DialogTransition.fadeSlide => _slideFadeTransitionBuilder,
    DialogTransition.fadeScale => _fadeScaleInTransitionBuilder,
  };
}

Future<T?> showPDialog<T>({
  required BuildContext context,
  required WidgetBuilder builder,
  EdgeInsetsGeometry padding = k24HPadding,
  bool isDismissible = true,
  double? maxHeight,
  double? maxWidth,
  double? elevation,
  BoxConstraints? dialogContraints,
  CupertinoDynamicColor? barrierColor,
  bool useRootNavigator = false,
  double backgroundOpacity = 1.0,
  DialogTransition transition = DialogTransition.fadeSlide,
}) => showGeneralDialog<T>(
  context: context,
  barrierColor: barrierColor?.resolveFrom(context) ?? Colors.transparent,
  barrierDismissible: isDismissible,
  barrierLabel: 'Dismiss',
  useRootNavigator: useRootNavigator,
  transitionDuration: Effects.shortDuration,
  pageBuilder:
      (context, anim1, anim2) => _DialogWrapper(
        animation: anim1,
        transition: transition,
        elevation: elevation,
        backgroundOpacity: backgroundOpacity,
        padding: padding,
        isDismissible: isDismissible,
        maxHeightPercentage: maxHeight,
        maxWidthPercentage: maxWidth,
        childConstraints: dialogContraints,
        child: builder(context),
      ),
);

Widget _slideFadeTransitionBuilder(
  Animation<double> animation,
  Widget background,
  Widget child,
) {
  // Apply Curves.easeInOut to the animation for a smooth transition.
  final curvedAnimation = CurvedAnimation(
    parent: animation,
    curve: Easing.emphasizedDecelerate,
  );

  final slideTween = Tween<Offset>(
    begin: const Offset(0, 1), // Start from bottom
    end: Offset.zero, // End at current position
  );

  background = FadeTransition(opacity: curvedAnimation, child: background);

  child = SlideTransition(
    position: slideTween.animate(
      curvedAnimation,
    ), // Slide up animation with curve
    child: FadeTransition(
      opacity: curvedAnimation, // Fade in animation with curve
      child: child,
    ),
  );

  return Stack(
    children: [Positioned.fill(child: background), Center(child: child)],
  );
}

Widget _fadeScaleInTransitionBuilder(
  Animation<double> animation,
  Widget background,
  Widget child,
) {
  // Apply Curves.easeInOut to the animation for a smooth transition.
  final curvedAnimation = CurvedAnimation(
    parent: animation,
    curve: Easing.emphasizedDecelerate,
  );

  final scaleTween = Tween<double>(
    begin: 1.2, // Start from 1.2
    end: 1.0, // End at 1
  );

  background = FadeTransition(opacity: curvedAnimation, child: background);

  child = ScaleTransition(
    scale: scaleTween.animate(curvedAnimation), // Scale in animation with curve
    child: FadeTransition(
      opacity: curvedAnimation, // Fade in animation with curve
      child: child,
    ),
  );

  return Stack(
    children: [Positioned.fill(child: background), Center(child: child)],
  );
}

class _ModalWrapper extends StatelessWidget {
  const _ModalWrapper({
    required this.isDraggable,
    required this.initHeight,
    required this.minHeight,
    required this.maxHeight,
    required this.bottomSheetColor,
    required this.decoration,
    required this.builder,
    required this.shouldAvoidKeyboard,
    required this.modalSheetContraints,
  });

  final bool isDraggable;
  final double? initHeight;
  final double? minHeight;
  final double? maxHeight;
  final CupertinoDynamicColor? bottomSheetColor;
  final Decoration? decoration;
  final MaybeScrollableBuilder builder;
  final bool shouldAvoidKeyboard;
  final BoxConstraints? modalSheetContraints;

  @override
  Widget build(BuildContext context) {
    var decoration = this.decoration;
    final initialPosition = SheetOffset(initHeight ?? 1.0);
    final minPosition = SheetOffset(minHeight ?? 1.0);
    final maxPosition = SheetOffset(maxHeight ?? 1.0);

    return SafeArea(
      minimum: k16APadding,
      child: ReTheme(
        builder: (context) {
          decoration ??= ShapeDecoration(
            shape: Superellipse.border24,
            color:
                bottomSheetColor?.resolveFrom(context) ?? context.brightSurface,
            shadows: const [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 30,
                spreadRadius: 5,
                offset: Offset(0, 10),
              ),
            ],
          );

          return Sheet(
            scrollConfiguration:
                isDraggable ? null : const SheetScrollConfiguration(),
            initialOffset: initialPosition,
            snapGrid: SheetSnapGrid(snaps: [minPosition, maxPosition]),
            physics: const BouncingSheetPhysics(),
            decoration: SheetDecorationBuilder(
              size: SheetSize.fit,
              builder:
                  (context, child) => Container(
                    decoration: decoration,
                    clipBehavior: Clip.hardEdge,
                    constraints: modalSheetContraints,
                    margin:
                        shouldAvoidKeyboard
                            ? EdgeInsets.only(
                              bottom: MediaQuery.viewInsetsOf(context).bottom,
                            )
                            : null,
                    child: child,
                  ),
            ),
            child: Builder(
              builder: (context) {
                final scrollController = PrimaryScrollController.maybeOf(
                  context,
                );
                final sheetController = DefaultSheetController.maybeOf(context);
                return builder(context, scrollController, sheetController);
              },
            ),
          );
        },
      ),
    );
  }
}

class _DialogWrapper extends StatelessWidget {
  const _DialogWrapper({
    required this.animation,
    required this.transition,
    required this.backgroundOpacity,
    required this.padding,
    required this.isDismissible,
    required this.maxHeightPercentage,
    required this.maxWidthPercentage,
    required this.childConstraints,
    required this.elevation,
    required this.child,
  });

  final Animation<double> animation;
  final DialogTransition transition;
  final double backgroundOpacity;
  final EdgeInsetsGeometry padding;
  final bool isDismissible;
  final double? maxHeightPercentage, maxWidthPercentage, elevation;
  final BoxConstraints? childConstraints;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ReTheme(
      includeNewScaffoldMessenger: true,
      builder: (context) {
        return Material(
          color: Colors.transparent,
          child: LayoutBuilder(
            builder: (context, constraints) {
              final barrierColor = theme.colorScheme.onSurface.fade(0.2);
              final background = GestureDetector(
                onTap:
                    isDismissible
                        ? () {
                          Navigator.of(context).pop();
                        }
                        : null,
                child: ColoredBox(
                  color: Target.select(
                    android: barrierColor,
                    ios: barrierColor,
                  ),
                ),
              );

              final child = ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: math.min(
                    constraints.maxWidth * (maxWidthPercentage ?? 0.9),
                    childConstraints?.maxWidth ?? 1200.0,
                  ),
                  maxHeight: math.min(
                    constraints.maxHeight * (maxHeightPercentage ?? 0.9),
                    childConstraints?.maxHeight ?? double.infinity,
                  ),
                ),
                child: Container(
                  decoration: ShapeDecoration(
                    shape: Superellipse.all(
                      24.0,
                      side: BorderSide(
                        color: theme.colorScheme.onSurface.fade(0.2),
                      ),
                    ),
                    color: theme.scaffoldBackgroundColor.withOpacityFactor(
                      backgroundOpacity,
                    ),
                    shadows: mediumShadows(elevation: elevation ?? 2.0),
                  ),
                  clipBehavior: Clip.antiAlias,
                  padding: padding,
                  child: this.child,
                ),
              );

              return transition.builder(animation, background, child);
            },
          ),
        );
      },
    );
  }
}

/// A parent widget that re-themes its child based on the user's theme preference
/// and the system's platform brightness.
///
/// Typically used for spawned windows or dialogs.
///
class ReTheme extends StatefulWidget {
  const ReTheme({
    this.includeNewScaffoldMessenger = false,
    required this.builder,
    super.key,
  });

  /// Whether to include a new [ScaffoldMessenger] in the [builder]'s context.
  ///
  /// Including a new [ScaffoldMessenger] may be useful for spawned windows or
  /// dialogs when we don't want SnackBar messages to be displayed in the main
  /// Navigator and the dialog at the same time.
  ///
  final bool includeNewScaffoldMessenger;
  final WidgetBuilder builder;

  @override
  State<ReTheme> createState() => _ReThemeState();
}

class _ReThemeState extends State<ReTheme> {
  late final _themePrefs = streamThemeMode(context.read());

  @override
  Widget build(BuildContext context) {
    final themedChild = StreamBuilder(
      stream: _themePrefs,
      builder: (context, snapshot) {
        final mode = snapshot.data ?? ThemeMode.system;
        final theme =
            mode == ThemeMode.dark
                ? getTheme(Brightness.dark)
                : mode == ThemeMode.light
                ? getTheme(Brightness.light)
                : getTheme(MediaQuery.platformBrightnessOf(context));

        return AnimatedTheme(
          data: theme,
          child: Builder(builder: widget.builder),
        );
      },
    );
    if (widget.includeNewScaffoldMessenger) {
      return ScaffoldMessenger(child: themedChild);
    }
    return themedChild;
  }
}
