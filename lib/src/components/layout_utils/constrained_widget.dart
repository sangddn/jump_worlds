import 'package:flutter/material.dart';

abstract class ConstrainedWidget extends StatelessWidget {
  const ConstrainedWidget({super.key});

  Widget buildWithConstraints(BuildContext context, BoxConstraints constraints);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: buildWithConstraints);
  }
}
