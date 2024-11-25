import 'package:zezis_widget/z_drag_and_drop/drag_and_drop_builder_parameters.dart';
import 'package:zezis_widget/z_drag_and_drop/drag_and_drop_item.dart';
import 'package:zezis_widget/z_drag_and_drop/drag_and_drop_item_target.dart';
import 'package:zezis_widget/z_drag_and_drop/drag_and_drop_item_wrapper.dart';
import 'package:zezis_widget/z_drag_and_drop/drag_and_drop_list_interface.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class DragAndDropList implements DragAndDropListInterface {
  final double? height;
  final Widget? header;
  final Widget? footer;
  final Widget? leftSide;
  final Widget? rightSide;
  final Widget? contentsWhenEmpty;
  final Widget? lastTarget;
  final Decoration? decoration;
  final CrossAxisAlignment verticalAlignment;
  final MainAxisAlignment horizontalAlignment;

  @override
  final List<DragAndDropItem> children;

  @override
  final bool canDrag;
  final Key? key;

  DragAndDropList({
    required this.children,
    this.key,
    this.height,
    this.header,
    this.footer,
    this.leftSide,
    this.rightSide,
    this.contentsWhenEmpty,
    this.lastTarget,
    this.decoration,
    this.horizontalAlignment = MainAxisAlignment.start,
    this.verticalAlignment = CrossAxisAlignment.start,
    this.canDrag = true,
  });

  @override
  Widget generateWidget(DragAndDropBuilderParameters params) {
    var contents = <Widget>[];

    if (header != null) {
      contents.add(Flexible(child: header!));
    }

    Widget intrinsicHeight = IntrinsicHeight(
      child: Row(
        mainAxisAlignment: horizontalAlignment,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: _generateDragAndDropListInnerContents(params),
      ),
    );

    if (params.axis == Axis.horizontal) {
      intrinsicHeight = SizedBox(
        width: params.listWidth,
        child: intrinsicHeight,
      );
    }

    if (params.listInnerDecoration != null) {
      intrinsicHeight = Container(
        decoration: params.listInnerDecoration,
        child: intrinsicHeight,
      );
    }
    
    contents.add(intrinsicHeight);

    if (footer != null) {
      contents.add(Flexible(child: footer!));
    }

    return Container(
      key: key,
      decoration: decoration ?? params.listDecoration,
      width: params.axis == Axis.vertical ? double.infinity : params.listWidth - params.listPadding!.horizontal,
      height: params.axis == Axis.vertical ? null : 500,

      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: verticalAlignment,
        children: contents,
      ),
    );
  }

  List<Widget> _generateDragAndDropListInnerContents(DragAndDropBuilderParameters parameters) {
    var contents = <Widget>[];

    if (leftSide != null) {
      contents.add(leftSide!);
    }
    
    if (children.isNotEmpty) {
      List<Widget> allChildren = [];
      if (parameters.addLastItemTargetHeightToTop) {
        allChildren.add(Padding(
          padding: EdgeInsets.only(top: parameters.lastItemTargetHeight),
        ));
      }

      for (int i = 0; i < children.length; i++) {
        allChildren.add(DragAndDropItemWrapper(
          key: children[i].key,
          child: children[i],
          parameters: parameters,
        ));

        if (parameters.itemDivider != null && i < children.length - 1) {
          allChildren.add(parameters.itemDivider!);
        }
      }

      allChildren.add(DragAndDropItemTarget(
        parent: this,
        parameters: parameters,
        onReorderOrAdd: parameters.onItemDropOnLastTarget!,
        child: lastTarget ?? Container(height: parameters.lastItemTargetHeight),
      ));

      contents.add(
        Expanded(
          child: SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
            child: Column(
              crossAxisAlignment: verticalAlignment,
              mainAxisSize: MainAxisSize.max,
              children: allChildren,
            ),
          ),
        ),
      );
    } else {
      contents.add(
        Expanded(
          child: SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                contentsWhenEmpty ?? const Text(
                  'Empty list',
                  style: TextStyle(
                    fontStyle: FontStyle.italic,
                  ),
                ),

                DragAndDropItemTarget(
                  parent: this,
                  parameters: parameters,
                  onReorderOrAdd: parameters.onItemDropOnLastTarget!,
                  child: lastTarget ?? Container(height: parameters.lastItemTargetHeight),
                ),
              ],
            ),
          ),
        ),
      );
    }
    
    if (rightSide != null) {
      contents.add(rightSide!);
    }

    return contents;
  }
}
