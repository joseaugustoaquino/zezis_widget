import 'package:flutter/material.dart';
import 'package:zezis_widget/src/components/typeahead/src/common/base/connector_widget.dart';
import 'package:zezis_widget/src/components/typeahead/src/common/base/suggestions_controller.dart';

class SuggestionsSearchTypingConnector<T> extends StatefulWidget {
  const SuggestionsSearchTypingConnector({
    super.key,
    required this.controller,
    required this.textEditingController,
    required this.child,
  });

  final SuggestionsController<T> controller;
  final TextEditingController textEditingController;
  final Widget child;

  @override
  State<SuggestionsSearchTypingConnector<T>> createState() =>
      _SuggestionsSearchTypingConnectorState<T>();
}

class _SuggestionsSearchTypingConnectorState<T>
    extends State<SuggestionsSearchTypingConnector<T>> {
  String? previousText;

  void onTextChange() {
    if (previousText == widget.textEditingController.text) return;
    previousText = widget.textEditingController.text;

    if (widget.controller.retainFocus) {
      widget.controller.open();
    }
  }

  @override
  Widget build(BuildContext context) {
    return ConnectorWidget(
      value: widget.textEditingController,
      connect: (value) => value.addListener(onTextChange),
      disconnect: (value, key) => value.removeListener(onTextChange),
      child: widget.child,
    );
  }
}
