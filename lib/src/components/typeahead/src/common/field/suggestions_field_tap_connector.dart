import 'package:flutter/widgets.dart';
import 'package:zezis_widget/src/components/typeahead/src/common/base/suggestions_controller.dart';

class SuggestionsFieldTapConnector<T> extends StatelessWidget {
  const SuggestionsFieldTapConnector({
    super.key,
    required this.controller,
    required this.child,
  });

  final SuggestionsController<T> controller;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return TextFieldTapRegion(
      child: Listener(
        behavior: HitTestBehavior.deferToChild,
        onPointerDown: (event) {
          if (controller.retainFocus) {
            controller.open();
          }
        },
        child: child,
      ),
    );
  }
}
