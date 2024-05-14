import 'package:flutter/cupertino.dart';
import 'package:zezis_widget/z_typeahead/src/common/field/typeahead_field.dart';
import 'package:zezis_widget/z_typeahead/src/common/base/types.dart';
import 'package:zezis_widget/z_typeahead/src/cupertino/cupertino_defaults.dart';

/// {@template zezis_widget/z_typeahead.ZHeadFieldCupertino}
/// A widget that shows suggestions above a text field while the user is typing.
///
/// This is the Cupertino version of the widget.
/// builder, itemBuilder, loadingBuilder, emptyBuilder, errorBuilder and decorationBuilder will default to Cupertino.
/// {@endtemplate}
class ZHeadFieldCupertino<T> extends ZRawHeadField<T> {
  ZHeadFieldCupertino({
    super.key,
    super.animationDuration,
    super.autoFlipDirection,
    super.autoFlipMinHeight,
    TextFieldBuilder? builder,
    super.controller,
    super.debounceDuration,
    super.direction,
    SuggestionsErrorBuilder? errorBuilder,
    super.focusNode,
    super.hideKeyboardOnDrag,
    super.hideOnEmpty,
    super.hideOnError,
    super.hideOnLoading,
    super.showOnFocus,
    super.hideOnUnfocus,
    super.hideWithKeyboard,
    super.hideOnSelect,
    required SuggestionsItemBuilder<T> itemBuilder,
    super.itemSeparatorBuilder,
    super.retainOnLoading,
    WidgetBuilder? loadingBuilder,
    WidgetBuilder? emptyBuilder,
    required super.onSelected,
    super.scrollController,
    super.suggestionsController,
    required super.suggestionsCallback,
    super.transitionBuilder,
    DecorationBuilder? decorationBuilder,
    super.listBuilder,
    super.constraints,
    super.offset,
  }) : super(
          builder: builder ?? ZHeadCupertinoDefaults.builder,
          errorBuilder: errorBuilder ?? ZHeadCupertinoDefaults.errorBuilder,
          loadingBuilder:
              loadingBuilder ?? ZHeadCupertinoDefaults.loadingBuilder,
          emptyBuilder: emptyBuilder ?? ZHeadCupertinoDefaults.emptyBuilder,
          itemBuilder: ZHeadCupertinoDefaults.itemBuilder(itemBuilder),
          decorationBuilder:
              ZHeadCupertinoDefaults.wrapperBuilder(decorationBuilder),
        );
}
