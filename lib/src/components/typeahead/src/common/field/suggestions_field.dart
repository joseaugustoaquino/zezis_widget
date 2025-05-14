import 'package:flutter/widgets.dart';
import 'package:zezis_widget/src/components/typeahead/src/common/base/connector_widget.dart';
import 'package:zezis_widget/src/components/typeahead/src/common/base/floater.dart';
import 'package:zezis_widget/src/components/typeahead/src/common/box/suggestions_box.dart';
import 'package:zezis_widget/src/components/typeahead/src/common/base/suggestions_controller.dart';
import 'package:zezis_widget/src/components/typeahead/src/common/base/types.dart';
import 'package:zezis_widget/src/components/typeahead/src/common/field/suggestions_field_focus_connector.dart';
import 'package:zezis_widget/src/components/typeahead/src/common/field/suggestions_field_keyboard_connector.dart';
import 'package:zezis_widget/src/components/typeahead/src/common/field/suggestions_field_box_connector.dart';
import 'package:zezis_widget/src/components/typeahead/src/common/field/suggestions_field_select_connector.dart';
import 'package:zezis_widget/src/components/typeahead/src/common/field/suggestions_field_tap_connector.dart';
import 'package:zezis_widget/src/components/typeahead/src/common/field/suggestions_field_traversal_connector.dart';

class SuggestionsField<T> extends StatefulWidget {
  const SuggestionsField({
    super.key,
    this.controller,
    required this.builder,
    required this.child,
    required this.focusNode,
    this.onSelected,
    this.direction,
    this.autoFlipDirection = false,
    this.autoFlipMinHeight = 64,
    this.showOnFocus = true,
    this.hideOnUnfocus = true,
    this.hideOnSelect = true,
    this.hideWithKeyboard = true,
    this.constraints,
    this.offset,
    this.scrollController,
    this.decorationBuilder,
    this.transitionBuilder,
    this.animationDuration,
  });

  final SuggestionsController<T>? controller;
  final FocusNode focusNode;
  final Widget child;
  final ValueSetter<T>? onSelected;
  final VerticalDirection? direction;
  final BoxConstraints? constraints;
  final Offset? offset;
  final bool autoFlipDirection;
  final double autoFlipMinHeight;
  final bool showOnFocus;
  final bool hideOnUnfocus;
  final bool hideOnSelect;
  final bool hideWithKeyboard;
  final ScrollController? scrollController;
  final DecorationBuilder? decorationBuilder;
  final AnimationTransitionBuilder? transitionBuilder;
  final Duration? animationDuration;

  final Widget Function(
    BuildContext context,
    SuggestionsController<T> controller,
  ) builder;

  @override
  State<SuggestionsField<T>> createState() => _SuggestionsFieldState<T>();
}

class _SuggestionsFieldState<T> extends State<SuggestionsField<T>> {
  final FloaterLink link = FloaterLink();
  late SuggestionsController<T> controller;

  @override
  void initState() {
    super.initState();
    controller = widget.controller ?? SuggestionsController<T>();
    if (widget.direction != null) {
      controller.direction = widget.direction!;
    }
  }

  @override
  void didUpdateWidget(covariant SuggestionsField<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.controller != oldWidget.controller) {
      if (oldWidget.controller == null) {
        controller.dispose();
      }
      controller = widget.controller ?? SuggestionsController<T>();
    }
    if (widget.direction != oldWidget.direction && widget.direction != null) {
      controller.direction = widget.direction!;
    }
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      controller.dispose();
    }
    link.dispose();
    super.dispose();
  }

  void onResize() {
    if (controller.isOpen) {
      link.markNeedsBuild();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SuggestionsControllerProvider<T>(
      controller: controller,
      child: Floater(
        link: link,
        direction: switch (controller.direction) {
          VerticalDirection.up => AxisDirection.up,
          VerticalDirection.down => AxisDirection.down,
        },
        offset: widget.offset ?? const Offset(0, 5),
        followHeight: false,
        autoFlip: widget.autoFlipDirection,
        autoFlipHeight: widget.autoFlipMinHeight,
        builder: (context) {
          FloaterData data = Floater.of(context);

          VerticalDirection newEffectiveDirection =
              switch (data.effectiveDirection) {
            AxisDirection.up => VerticalDirection.up,
            _ => VerticalDirection.down,
          };
          if (newEffectiveDirection != controller.effectiveDirection) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (!mounted) return;
              controller.effectiveDirection = newEffectiveDirection;
            });
          }

          Widget list = SuggestionsBox(
            controller: controller,
            scrollController: widget.scrollController,
            builder: (context) => widget.builder(context, controller),
            decorationBuilder: widget.decorationBuilder,
            transitionBuilder: widget.transitionBuilder,
            animationDuration: widget.animationDuration,
          );

          if (widget.constraints != null) {
            Alignment alignment = Alignment.topCenter;
            if (widget.direction == VerticalDirection.up) {
              alignment = Alignment.bottomCenter;
            }
            list = Align(
              alignment: alignment,
              child: ConstrainedBox(
                constraints: widget.constraints!,
                child: list,
              ),
            );
          }

          list = Semantics(
            container: true,
            child: list,
          );

          return list;
        },
        child: FloaterTarget(
          link: link,
          child: ConnectorWidget(
            value: controller,
            connect: (value) => value.$resizes.listen((_) => onResize()),
            disconnect: (value, key) => key?.cancel(),
            child: SuggestionsFieldFocusConnector<T>(
              controller: controller,
              focusNode: widget.focusNode,
              child: SuggestionsFieldTraversalConnector<T>(
                controller: controller,
                focusNode: widget.focusNode,
                child: SuggestionsFieldBoxConnector<T>(
                  controller: controller,
                  showOnFocus: widget.showOnFocus,
                  hideOnUnfocus: widget.hideOnUnfocus,
                  child: SuggestionsFieldKeyboardConnector<T>(
                    controller: controller,
                    hideWithKeyboard: widget.hideWithKeyboard,
                    child: SuggestionsFieldTapConnector<T>(
                      controller: controller,
                      child: SuggestionsFieldSelectConnector<T>(
                        controller: controller,
                        hideOnSelect: widget.hideOnSelect,
                        onSelected: widget.onSelected,
                        child: widget.child,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
