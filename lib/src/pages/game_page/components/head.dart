part of '../game_page.dart';

class _Head extends StatelessWidget {
  const _Head();

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [Gap(16), _Score(), Spacer(), _Timer(), Gap(16)],
    );
  }
}

class _Score extends StatelessWidget {
  const _Score();

  @override
  Widget build(BuildContext context) {
    return Text('Score: ${context.watchScore()}', style: context.textTheme.h4);
  }
}
