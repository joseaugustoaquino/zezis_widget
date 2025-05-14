import 'package:flutter/widgets.dart';
import 'package:zezis_widget/src/components/typeahead/src/common/field/suggestions_field.dart';
import 'package:zezis_widget/src/components/typeahead/src/common/search/suggestions_search.dart';
import 'package:zezis_widget/src/components/typeahead/src/common/base/suggestions_controller.dart';
import 'package:zezis_widget/src/components/typeahead/src/common/box/suggestions_list.dart';

import 'package:zezis_widget/src/components/typeahead/src/common/base/types.dart';
import 'package:pointer_interceptor/pointer_interceptor.dart';

abstract class ZRawHeadField<T> extends StatefulWidget {
  const ZRawHeadField({
    super.key,
    this.animationDuration = const Duration(milliseconds: 200),
    this.autoFlipDirection = false,
    this.autoFlipMinHeight = 144,
    required this.builder,
    this.controller,
    this.debounceDuration = const Duration(milliseconds: 300),
    this.direction = VerticalDirection.down,
    required this.errorBuilder,
    this.focusNode,
    this.hideKeyboardOnDrag = false,
    this.hideOnEmpty = false,
    this.hideOnError = false,
    this.hideOnLoading = false,
    this.showOnFocus = true,
    this.hideOnUnfocus = true,
    this.hideWithKeyboard = true,
    this.hideOnSelect = true,
    required this.itemBuilder,
    this.itemSeparatorBuilder,
    this.retainOnLoading = true,
    required this.loadingBuilder,
    required this.emptyBuilder,
    required this.onSelected,
    this.scrollController,
    this.suggestionsController,
    required this.suggestionsCallback,
    this.transitionBuilder,
    this.decorationBuilder,
    this.listBuilder,
    this.constraints,
    this.offset,
  });

  final TextFieldBuilder builder;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final SuggestionsController<T>? suggestionsController;
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
  final AnimationTransitionBuilder? transitionBuilder;
  final Duration? animationDuration;
  final SuggestionsCallback<T> suggestionsCallback;
  final bool? retainOnLoading;
  final bool? hideKeyboardOnDrag;
  final bool? hideOnLoading;
  final bool? hideOnError;
  final bool? hideOnEmpty;
  final WidgetBuilder loadingBuilder;
  final SuggestionsErrorBuilder errorBuilder;
  final WidgetBuilder emptyBuilder;
  final SuggestionsItemBuilder<T> itemBuilder;
  final IndexedWidgetBuilder? itemSeparatorBuilder;
  final DecorationBuilder? decorationBuilder;
  final ListBuilder? listBuilder;
  final Duration? debounceDuration;

  @override
  State<ZRawHeadField<T>> createState() => _ZRawHeadFieldState<T>();
}

class _ZRawHeadFieldState<T> extends State<ZRawHeadField<T>> {
  late TextEditingController controller;
  late FocusNode focusNode;

  @override
  void initState() {
    super.initState();
    controller = widget.controller ?? TextEditingController();
    focusNode = widget.focusNode ?? FocusNode();
  }

  @override
  void didUpdateWidget(covariant ZRawHeadField<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.controller != widget.controller) {
      if (oldWidget.controller == null) {
        controller.dispose();
      }
      controller = widget.controller ?? TextEditingController();
    }
    if (oldWidget.focusNode != widget.focusNode) {
      if (oldWidget.focusNode == null) {
        focusNode.dispose();
      }
      focusNode = widget.focusNode ?? FocusNode();
    }
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      controller.dispose();
    }
    if (widget.focusNode == null) {
      focusNode.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SuggestionsField<T>(
      controller: widget.suggestionsController,
      onSelected: widget.onSelected,
      focusNode: focusNode,
      direction: widget.direction,
      autoFlipDirection: widget.autoFlipDirection,
      autoFlipMinHeight: widget.autoFlipMinHeight,
      showOnFocus: widget.showOnFocus,
      hideOnUnfocus: widget.hideOnUnfocus,
      hideOnSelect: widget.hideOnSelect,
      hideWithKeyboard: widget.hideWithKeyboard,
      constraints: widget.constraints,
      offset: widget.offset,
      scrollController: widget.scrollController,
      decorationBuilder: (context, child) => TextFieldTapRegion(
        child: SuggestionsSearch<T>(
          controller: SuggestionsController.of<T>(context),
          textEditingController: controller,
          suggestionsCallback: widget.suggestionsCallback,
          debounceDuration: widget.debounceDuration,
          child: widget.decorationBuilder?.call(context, child) ?? child,
        ),
      ),
      transitionBuilder: widget.transitionBuilder,
      animationDuration: widget.animationDuration,
      builder: (context, suggestionsController) => SuggestionsList<T>(
        controller: suggestionsController,
        loadingBuilder: widget.loadingBuilder,
        errorBuilder: widget.errorBuilder,
        emptyBuilder: widget.emptyBuilder,
        hideOnLoading: widget.hideOnLoading,
        hideOnError: widget.hideOnError,
        hideOnEmpty: widget.hideOnEmpty,
        retainOnLoading: widget.retainOnLoading,
        hideKeyboardOnDrag: widget.hideKeyboardOnDrag,
        itemBuilder: widget.itemBuilder,
        itemSeparatorBuilder: widget.itemSeparatorBuilder,
        listBuilder: widget.listBuilder,
      ),
      child: PointerInterceptor(
        child: widget.builder(
          context,
          controller,
          focusNode,
        ),
      ),
    );
  }
}
