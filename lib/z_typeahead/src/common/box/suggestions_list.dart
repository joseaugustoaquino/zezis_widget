import 'package:flutter/widgets.dart';
import 'package:zezis_widget/z_typeahead/src/common/base/suggestions_controller.dart';
import 'package:zezis_widget/z_typeahead/src/common/base/types.dart';

class SuggestionsList<T> extends StatefulWidget {
  const SuggestionsList({
    super.key,
    required this.controller,
    this.hideKeyboardOnDrag,
    this.hideOnLoading,
    this.hideOnError,
    this.hideOnEmpty,
    required this.loadingBuilder,
    required this.errorBuilder,
    required this.emptyBuilder,
    required this.itemBuilder,
    this.retainOnLoading,
    this.listBuilder,
    this.itemSeparatorBuilder,
  });

  final SuggestionsController<T> controller;
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
  final ListBuilder? listBuilder;

  @override
  State<SuggestionsList<T>> createState() => _SuggestionsListState<T>();
}

class _SuggestionsListState<T> extends State<SuggestionsList<T>> {
  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: widget.controller,
      builder: (context, _) {
        List<T>? suggestions = widget.controller.suggestions;
        bool retainOnLoading = widget.retainOnLoading ?? true;

        bool isError = widget.controller.hasError;
        bool isEmpty = suggestions?.isEmpty ?? false;
        bool isLoading = widget.controller.isLoading &&
            (suggestions == null || isEmpty || !retainOnLoading);

        if (isLoading) {
          if (widget.hideOnLoading ?? false) return const SizedBox();
          return widget.loadingBuilder(context);
        } else if (isError) {
          if (widget.hideOnError ?? false) return const SizedBox();
          return widget.errorBuilder(context, widget.controller.error!);
        } else if (isEmpty) {
          if (widget.hideOnEmpty ?? false) return const SizedBox();
          return widget.emptyBuilder(context);
        } else if (suggestions == null) {
          return const SizedBox();
        }

        if (widget.listBuilder != null) {
          return widget.listBuilder!(
            context,
            suggestions
                .map((suggestion) => widget.itemBuilder(context, suggestion))
                .toList(),
          );
        }

        return ListView.separated(
          // We cannot pass a controller, as we want to inherit it from
          // the PrimaryScrollController of the SuggestionsBox.
          // This happens automatically as long as we
          // dont pass a controller and pass either null or true for primary.
          controller: null,
          primary: null,
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          keyboardDismissBehavior: (widget.hideKeyboardOnDrag ?? false)
              ? ScrollViewKeyboardDismissBehavior.onDrag
              : ScrollViewKeyboardDismissBehavior.manual,
          reverse: widget.controller.effectiveDirection == VerticalDirection.up,
          itemCount: suggestions.length,
          itemBuilder: (context, index) =>
              widget.itemBuilder(context, suggestions[index]),
          separatorBuilder: (context, index) =>
              widget.itemSeparatorBuilder?.call(context, index) ??
              const SizedBox.shrink(),
        );
      },
    );
  }
}
