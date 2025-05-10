part of '../home_page.dart';

class _Head extends StatelessWidget {
  const _Head();

  @override
  Widget build(BuildContext context) {
    return SliverSafeArea(
      bottom: false,
      sliver: SuperSliverList.list(
        children: const [
          SizedBox.square(
            dimension: 200.0,
            child: RoundedImage.fromAsset(
              UiAsset.readyBun,
              fit: BoxFit.contain,
            ),
          ),
        ],
      ),
    );
  }
}
