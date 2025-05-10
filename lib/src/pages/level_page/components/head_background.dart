part of '../level_page.dart';

class _HeadBackground extends StatelessWidget {
  const _HeadBackground();

  @override
  Widget build(BuildContext context) => RuledBackground(
    extent: 800.0,
    color: context.read<Difficulty>().backgroundColor,
  );
}
