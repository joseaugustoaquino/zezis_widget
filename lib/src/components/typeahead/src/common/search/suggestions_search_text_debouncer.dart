import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:zezis_widget/src/components/typeahead/src/common/base/connector_widget.dart';

class SuggestionsSearchTextDebouncer extends StatefulWidget {
  const SuggestionsSearchTextDebouncer({
    super.key,
    required this.controller,
    required this.onChanged,
    this.debounceDuration,
    required this.child,
  });

  final TextEditingController controller;
  final ValueSetter<String> onChanged;
  final Duration? debounceDuration;
  final Widget child;

  @override
  State<SuggestionsSearchTextDebouncer> createState() =>
      _SuggestionsSearchTextDebouncerState();
}

class _SuggestionsSearchTextDebouncerState
    extends State<SuggestionsSearchTextDebouncer> {
  String? lastTextValue;
  Timer? debounceTimer;

  @override
  void initState() {
    super.initState();
    lastTextValue = widget.controller.text;
  }

  void onChange() {
    if (widget.controller.text == lastTextValue) return;
    lastTextValue = widget.controller.text;

    Duration? debounceDuration = widget.debounceDuration;
    debounceDuration ??= const Duration(milliseconds: 300);

    debounceTimer?.cancel();
    if (debounceDuration == Duration.zero) {
      widget.onChanged(widget.controller.text);
    } else {
      debounceTimer = Timer(
        debounceDuration,
        () => widget.onChanged(widget.controller.text),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return ConnectorWidget(
      value: widget.controller,
      connect: (value) {
        onChange();
        value.addListener(onChange);
      },
      disconnect: (value, key) {
        debounceTimer?.cancel();
        value.removeListener(onChange);
      },
      child: widget.child,
    );
  }
}
