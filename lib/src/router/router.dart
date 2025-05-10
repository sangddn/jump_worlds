import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smooth_sheets/smooth_sheets.dart';

import '../animations/animations.dart';
import '../database/database.dart';
import 'router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Screen|Page,Route')
class AppRouter extends RootStackRouter {
  AppRouter({required super.navigatorKey, required this.db});

  static AppRouter of(BuildContext context, {bool listen = false}) {
    return Provider.of<AppRouter>(context, listen: listen);
  }

  final DatabaseInterface db;

  @override
  RouteType get defaultRouteType => const RouteType.adaptive();

  @override
  List<AutoRoute> get routes {
    return [
      CustomRoute<void>(
        path: '/intro',
        page: IntroRoute.page,
        customRouteBuilder: <T>(_, child, page) {
          return CupertinoModalSheetRoute(
            settings: page,
            swipeDismissible: true,
            builder: (_) => child,
          );
        },
      ),
      CupertinoRoute<void>(path: '/home', initial: true, page: HomeRoute.page),
      CupertinoRoute<void>(path: '/game', page: GameRoute.page),
      CupertinoRoute<void>(path: '/level', page: LevelRoute.page),
    ];
  }
}

class FadeRoute extends CustomRoute<void> {
  FadeRoute({
    super.path,
    super.initial,
    super.guards,
    required super.page,
    super.children,
  }) : super(
         transitionsBuilder: (context, animation, secondaryAnimation, child) {
           return RouteTransitionAnimationProvider(
             animation: animation,
             secondaryAnimation: secondaryAnimation,
             child: FadeTransition(opacity: animation, child: child),
           );
         },
       );
}
