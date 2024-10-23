import 'package:zezis_widget/z_drag_and_drop/drag_and_drop_list_interface.dart';
import 'package:zezis_widget/z_drag_and_drop/drag_and_drop_lists.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class DragAndDropItemTarget extends StatefulWidget {
  final Widget child;
  final DragAndDropListInterface? parent;
  final DragAndDropBuilderParameters parameters;
  final OnItemDropOnLastTarget onReorderOrAdd;

  const DragAndDropItemTarget({
    required this.child,
    required this.onReorderOrAdd,
    required this.parameters,
    this.parent,
    super.key
  });

  @override
  State<StatefulWidget> createState() => _DragAndDropItemTarget();
}

class _DragAndDropItemTarget extends State<DragAndDropItemTarget>
    with TickerProviderStateMixin {
  DragAndDropItem? _hoveredDraggable;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          crossAxisAlignment: widget.parameters.verticalAlignment,
          children: [
            AnimatedSize(
              alignment: Alignment.bottomCenter,
              duration: Duration(milliseconds: widget.parameters.itemSizeAnimationDuration),

              child: _hoveredDraggable == null ? Container() : Opacity(
                opacity: widget.parameters.itemGhostOpacity,
                child: widget.parameters.itemGhost ?? _hoveredDraggable!.child,
              ),
            ),
            
            widget.child,
          ],
        ),

        Positioned.fill(
          child: DragTarget<DragAndDropItem>(
            builder: (context, candidateData, rejectedData) {
              if (candidateData.isNotEmpty) {}
              return Container();
            },
            onWillAcceptWithDetails: (details) {
              bool accept = true;
              if (widget.parameters.itemTargetOnWillAccept != null) {
                accept = widget.parameters.itemTargetOnWillAccept!(details.data, widget);
              }
              if (accept && mounted) {
                setState(() => _hoveredDraggable = details.data);
              }
              return accept;
            },
            onLeave: (data) {
              if (mounted) {
                setState(() => _hoveredDraggable = null);
              }
            },
            onAcceptWithDetails: (details) {
              if (mounted) {
                setState(() {
                  widget.onReorderOrAdd(details.data, widget.parent!, widget);
                  _hoveredDraggable = null;
                });
              }
            },
          ),
        ),
      ],
    );
  }
}
