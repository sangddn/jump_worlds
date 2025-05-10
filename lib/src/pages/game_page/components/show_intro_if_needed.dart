part of '../game_page.dart';

class _ShowIntroIfNeeded extends StatefulWidget {
  const _ShowIntroIfNeeded();

  @override
  State<_ShowIntroIfNeeded> createState() => _ShowIntroIfNeededState();
}

class _ShowIntroIfNeededState extends State<_ShowIntroIfNeeded> {
  @override
  void initState() {
    super.initState();
    if (!IntroPage.isShown(context)) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        context.router
            .push(const IntroRoute())
            .then((_) => !mounted ? null : IntroPage.setShown(context));
      });
    }
  }

  @override
  Widget build(BuildContext context) => const SizedBox.shrink();
}
