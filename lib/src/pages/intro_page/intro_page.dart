import 'package:auto_route/auto_route.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:smooth_sheets/smooth_sheets.dart';

import '../../app/app.dart';
import '../../components/components.dart';
import '../../core_ui/core_ui.dart';

@RoutePage()
class IntroPage extends StatelessWidget {
  const IntroPage({super.key});

  static bool isShown(BuildContext context) {
    return !kDebugMode && (context.db.boolRef.get('intro_shown') ?? false);
  }

  static void setShown(BuildContext context) {
    context.db.boolRef.put('intro_shown', true);
  }

  @override
  Widget build(BuildContext context) {
    return Sheet(
      decoration: MaterialSheetDecoration(
        size: SheetSize.fit,
        borderRadius: BorderRadius.circular(20),
        clipBehavior: Clip.antiAlias,
      ),
      child: Container(
        width: double.infinity,
        color: Theme.of(context).colorScheme.surface,
        child: const Column(
          children: [
            Gap(120.0),
            _Title(),
            Gap(64.0),
            _Explanation(),
            Spacer(),
            SafeArea(child: _Button()),
            Gap(24.0),
          ],
        ),
      ),
    );
  }
}

class _Title extends StatelessWidget {
  const _Title();

  @override
  Widget build(BuildContext context) {
    final style = context.textTheme.h3;
    return DefaultTextStyle(
      style: style,
      textAlign: TextAlign.center,
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 400.0),
        child: const Padding(
          padding: k32HPadding,
          child: Column(
            children: [
              Text('Build the best burger.'),
              Text('Solve a word puzzle to unlock ingredients.'),
            ],
          ),
        ),
      ),
    );
  }
}

class _Explanation extends StatelessWidget {
  const _Explanation();

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class _Button extends StatelessWidget {
  const _Button();

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      onTap: () => context.router.maybePop(),
      padding: k16H12VPadding,
      margin: k32HPadding,
      child: const Text('Continue'),
    );
  }
}
