import 'package:flutter/material.dart';
import 'package:zezis_widget/z_typeahead/src/common/base/suggestions_controller.dart';
import 'package:zezis_widget/z_typeahead/src/common/base/types.dart';
import 'package:zezis_widget/z_typeahead/src/common/box/suggestions_box_animation.dart';
import 'package:zezis_widget/z_typeahead/src/common/box/suggestions_box_focus_connector.dart';
import 'package:zezis_widget/z_typeahead/src/common/box/suggestions_box_scroll_injector.dart';
import 'package:zezis_widget/z_typeahead/src/common/box/suggestions_box_traversal_connector.dart';
import 'package:pointer_interceptor/pointer_interceptor.dart';

class SuggestionsBox<T> extends StatelessWidget {
  const SuggestionsBox({
    super.key,
    required this.controller,
    this.scrollController,
    required this.builder,
    this.decorationBuilder,
    this.transitionBuilder,
    this.animationDuration,
  });

  final SuggestionsController<T> controller;
  final ScrollController? scrollController;
  final WidgetBuilder builder;
  final DecorationBuilder? decorationBuilder;
  final AnimationTransitionBuilder? transitionBuilder;
  final Duration? animationDuration;

  @override
  Widget build(BuildContext context) {
    SuggestionsItemBuilder<Widget> wrapper =
        decorationBuilder ?? (_, child) => child;

    return SuggestionsControllerProvider<T>(
      controller: controller,
      child: SuggestionsBoxScrollInjector(
        controller: scrollController,
        child: SuggestionsBoxFocusConnector<T>(
          controller: controller,
          child: SuggestionsBoxTraversalConnector<T>(
            controller: controller,
            child: PointerInterceptor(
              child: Builder(
                builder: (context) => wrapper(
                  context,
                  SuggestionsBoxAnimation<T>(
                    controller: controller,
                    transitionBuilder: transitionBuilder,
                    animationDuration: animationDuration,
                    child: builder(context),
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
