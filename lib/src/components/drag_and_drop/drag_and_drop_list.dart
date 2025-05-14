import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:zezis_widget/zezis_widget.dart';

class DragAndDropList implements DragAndDropListInterface {
  /// The widget that is displayed at the top of the list.
  final Widget? header;

  /// The widget that is displayed at the bottom of the list.
  final Widget? footer;

  /// The widget that is displayed to the left of the list.
  final Widget? leftSide;

  /// The widget that is displayed to the right of the list.
  final Widget? rightSide;

  /// The widget to be displayed when a list is empty.
  /// If this is not null, it will override that set in [DragAndDropLists.contentsWhenEmpty].
  final Widget? contentsWhenEmpty;

  /// The widget to be displayed as the last element in the list that will accept
  /// a dragged item.
  final Widget? lastTarget;

  /// The decoration displayed around a list.
  /// If this is not null, it will override that set in [DragAndDropLists.listDecoration].
  final Decoration? decoration;

  /// The vertical alignment of the contents in this list.
  /// If this is not null, it will override that set in [DragAndDropLists.verticalAlignment].
  final CrossAxisAlignment verticalAlignment;

  /// The horizontal alignment of the contents in this list.
  /// If this is not null, it will override that set in [DragAndDropLists.horizontalAlignment].
  final MainAxisAlignment horizontalAlignment;

  /// The child elements that will be contained in this list.
  /// It is possible to not provide any children when an empty list is desired.
  @override
  final List<DragAndDropItem> children;

  /// Whether or not this item can be dragged.
  /// Set to true if it can be reordered.
  /// Set to false if it must remain fixed.
  @override
  final bool canDrag;
  @override
  final Key? key;

  final List<GlobalKey> _keys = [];

  DragAndDropList({
    required this.children,
    this.key,
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
  Widget generateWidget(DragAndDropBuilderParameters params, double height) {
    var contents = <Widget>[];
    if (header != null) {
      contents.add(Flexible(child: header!));
    }
    Widget intrinsicHeight = IntrinsicHeight(
      child: Row(
        mainAxisAlignment: horizontalAlignment,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: _generateDragAndDropListInnerContents(params, height),
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
      width: params.axis == Axis.vertical
          ? double.infinity
          : params.listWidth - params.listPadding!.horizontal,
      decoration: decoration ?? params.listDecoration,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: verticalAlignment,
        children: contents,
      ),
    );
  }

  List<Widget> _generateDragAndDropListInnerContents(DragAndDropBuilderParameters parameters, double height) {
    var contents = <Widget>[];
    if (leftSide != null) {
      contents.add(leftSide!);
    }
    if (children.isNotEmpty) {
      List<Widget> allChildren = <Widget>[];
      double newHeight = 0;

      for (var key in List.generate(children.length, (index) => GlobalKey())) {
        _keys.add(key);
      }

      if (parameters.addLastItemTargetHeightToTop) {
        allChildren.add(Padding(
          padding: EdgeInsets.only(top: parameters.lastItemTargetHeight),
        ));
      }
      
      for (int i = 0; i < children.length; i++) {
        allChildren.add(Container(
          key: _keys[i],
          child: DragAndDropItemWrapper(
            key: children[i].key,
            child: children[i],
            parameters: parameters,
          ),
        ));
        if (parameters.itemDivider != null && i < children.length - 1) {
          allChildren.add(parameters.itemDivider!);
        }
      }


      for (final key in _keys) {
        final context = key.currentContext;
        
        if (context != null) {
          final box = context.findRenderObject() as RenderBox;
          newHeight += box.size.height;
        }
      }

      contents.add(
        Expanded(
          child: SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
            child: Column(
              crossAxisAlignment: verticalAlignment,
              mainAxisSize: MainAxisSize.max,
              children: [
                ...allChildren,

                SizedBox(height: newHeight > height ? height : ((height) - newHeight) > 0 ? ((height) - newHeight) : 0)
              ],
            ),
          )
        ),
      );
    } else {
      contents.add(
        Expanded(
          child: SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                contentsWhenEmpty ??
                    const Text(
                      'Empty list',
                      style: TextStyle(
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                
                DragAndDropItemTarget(
                  parent: this,
                  parameters: parameters,
                  onReorderOrAdd: parameters.onItemDropOnLastTarget!,
                  child: lastTarget ??
                      Container(
                        height: height - parameters.lastItemTargetHeight,
                      ),
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
