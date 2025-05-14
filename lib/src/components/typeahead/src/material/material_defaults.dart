import 'package:flutter/material.dart';
import 'package:zezis_widget/src/components/typeahead/src/common/base/suggestions_controller.dart';
import 'package:zezis_widget/src/components/typeahead/src/common/base/types.dart';

abstract final class ZHeadMaterialDefaults {
  static Widget loadingBuilder(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [CircularProgressIndicator()],
      ),
    );
  }

  static Widget errorBuilder(BuildContext context, Object? error) {
    String message = 'An error has occured';
    message = 'Error: $error';
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Text(
        message,
        style: TextStyle(color: Theme.of(context).colorScheme.error),
      ),
    );
  }

  static Widget emptyBuilder(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Text(
        'No items found!',
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.titleMedium,
      ),
    );
  }

  static SuggestionsItemBuilder<T> itemBuilder<T>(
    SuggestionsItemBuilder<T> builder,
  ) {
    return (context, item) {
      return InkWell(
        focusColor: Theme.of(context).hoverColor,
        onTap: () => SuggestionsController.of<T>(context).select(item),
        child: builder(context, item),
      );
    };
  }

  static SuggestionsItemBuilder wrapperBuilder(
    DecorationBuilder? builder,
  ) {
    return (context, child) {
      return Material(
        type: MaterialType.transparency,
        child: (builder ?? decorationBuilder)(context, child),
      );
    };
  }

  static Widget decorationBuilder(
    BuildContext context,
    Widget child,
  ) {
    return Material(
      type: MaterialType.card,
      elevation: 4,
      borderRadius: BorderRadius.circular(8),
      child: child,
    );
  }

  static Widget builder(
    BuildContext context,
    TextEditingController controller,
    FocusNode node,
  ) {
    return TextField(
      controller: controller,
      focusNode: node,
    );
  }
}
