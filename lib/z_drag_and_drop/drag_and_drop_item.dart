import 'package:zezis_widget/z_drag_and_drop/drag_and_drop_interface.dart';
import 'package:flutter/widgets.dart';

class DragAndDropItem implements DragAndDropInterface {
  final Widget child;
  final Widget? feedbackWidget;

  final bool canDrag;
  final Key? key;
  
  DragAndDropItem({
    required this.child,
    this.feedbackWidget,
    this.canDrag = true,
    this.key,
  });
}
