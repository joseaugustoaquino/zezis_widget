import 'package:flutter/widgets.dart';

enum DragHandleVerticalAlignment {
  top,
  center,
  bottom,
}

class DragHandle extends StatelessWidget {
  final bool onLeft;
  final Widget child;
  final DragHandleVerticalAlignment verticalAlignment;

  const DragHandle({
    super.key,
    required this.child,
    this.onLeft = false,
    this.verticalAlignment = DragHandleVerticalAlignment.center,
  });

  @override
  Widget build(BuildContext context) {
    return child;
  }
}
