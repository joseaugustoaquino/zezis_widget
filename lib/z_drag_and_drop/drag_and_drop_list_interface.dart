import 'package:zezis_widget/z_drag_and_drop/drag_and_drop_builder_parameters.dart';
import 'package:zezis_widget/z_drag_and_drop/drag_and_drop_interface.dart';
import 'package:zezis_widget/z_drag_and_drop/drag_and_drop_item.dart';
import 'package:flutter/material.dart';

abstract class DragAndDropListInterface implements DragAndDropInterface {
  List<DragAndDropItem>? get children;

  bool get canDrag;
  Widget generateWidget(DragAndDropBuilderParameters params);
}

abstract class DragAndDropListExpansionInterface
    implements DragAndDropListInterface {
  @override
  final List<DragAndDropItem>? children;

  DragAndDropListExpansionInterface({this.children});

  get isExpanded;

  toggleExpanded();

  expand();

  collapse();
}
