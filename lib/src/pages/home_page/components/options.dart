part of '../home_page.dart';

class _Options extends StatelessWidget {
  const _Options();

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: k24HPadding,
      sliver: SuperSliverList.list(
        children: [
          RaisedButton(
            onTap: () {},
            backgroundColor: PColors.green700,
            child: const Text('Easy'),
          ),
          const Gap(16.0),
          RaisedButton(
            onTap: () {},
            backgroundColor: PColors.blue700,
            child: const Text('Medium'),
          ),
          const Gap(16.0),
          RaisedButton(
            onTap: () {},
            backgroundColor: PColors.red700,
            child: const Text('Hard'),
          ),
        ],
      ),
    );
  }
}

