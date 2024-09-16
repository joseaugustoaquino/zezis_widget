import 'package:flutter/material.dart';
import 'package:zezis_widget/z_typeahead/src/common/field/typeahead_field.dart';
import 'package:zezis_widget/z_typeahead/src/common/base/types.dart';
import 'package:zezis_widget/z_typeahead/src/material/material_defaults.dart';

class ZHeadField<T> extends ZRawHeadField<T> {
  ZHeadField({
    required super.onSelected,

    super.key,
    super.animationDuration,
    super.autoFlipDirection,
    super.autoFlipMinHeight,
    super.controller,
    super.debounceDuration,
    super.direction,
    super.focusNode,
    super.hideKeyboardOnDrag,
    super.hideOnEmpty,
    super.hideOnError,
    super.hideOnLoading,
    super.showOnFocus,
    super.hideOnUnfocus,
    super.hideWithKeyboard,
    super.hideOnSelect,
    super.itemSeparatorBuilder,
    super.retainOnLoading,
    super.scrollController,
    super.suggestionsController,
    super.transitionBuilder,
    super.listBuilder,
    super.constraints,
    super.offset,

    WidgetBuilder? loadingBuilder,
    WidgetBuilder? emptyBuilder,
    TextFieldBuilder? builder,
    SuggestionsErrorBuilder? errorBuilder,
    required SuggestionsItemBuilder<T> itemBuilder,
    required super.suggestionsCallback,
    DecorationBuilder? decorationBuilder,

  }) : super(
    builder: builder ?? ZHeadMaterialDefaults.builder,
    errorBuilder: errorBuilder ?? ZHeadMaterialDefaults.errorBuilder,
    loadingBuilder: loadingBuilder ?? ZHeadMaterialDefaults.loadingBuilder,
    emptyBuilder: emptyBuilder ?? ZHeadMaterialDefaults.emptyBuilder,
    itemBuilder: ZHeadMaterialDefaults.itemBuilder(itemBuilder),
    decorationBuilder: ZHeadMaterialDefaults.wrapperBuilder(decorationBuilder),
  );
}
