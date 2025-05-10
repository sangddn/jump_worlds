part of '../home_page.dart';

class _Title extends StatelessWidget {
  const _Title();

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Text(
        'Ready for a challenge?',
        style: context.textTheme.display3.withColor(context.colors.blue700),
        textAlign: TextAlign.center,
      ),
    );
  }
}
