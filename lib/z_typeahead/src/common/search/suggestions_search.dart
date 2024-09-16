import 'package:flutter/widgets.dart';
import 'package:zezis_widget/z_typeahead/src/common/base/connector_widget.dart';
import 'package:zezis_widget/z_typeahead/src/common/base/suggestions_controller.dart';

import 'package:zezis_widget/z_typeahead/src/common/base/types.dart';
import 'package:zezis_widget/z_typeahead/src/common/search/suggestions_search_text_debouncer.dart';
import 'package:zezis_widget/z_typeahead/src/common/search/suggestions_search_typing_connector.dart';

class SuggestionsSearch<T> extends StatefulWidget {
  const SuggestionsSearch({
    super.key,
    required this.controller,
    required this.textEditingController,
    required this.suggestionsCallback,
    required this.child,
    this.debounceDuration,
  });

  final SuggestionsController<T> controller;
  final TextEditingController textEditingController;
  final SuggestionsCallback<T> suggestionsCallback;
  final Widget child;
  final Duration? debounceDuration;

  @override
  State<SuggestionsSearch<T>> createState() => _SuggestionsSearchState<T>();
}

class _SuggestionsSearchState<T> extends State<SuggestionsSearch<T>> {
  bool isQueued = false;
  late String search = widget.textEditingController.text;
  late bool wasOpen = widget.controller.isOpen;
  late bool hadSuggestions = widget.controller.suggestions != null;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => load());
  }

  void onChange() {
    if (!mounted) return;
    onOpenChange();
    onSuggestionsChange();
  }

  void onOpenChange() {
    bool isOpen = widget.controller.isOpen;
    if (wasOpen == isOpen) return;
    wasOpen = isOpen;
    load();
  }

  void onSuggestionsChange() {
    bool hasSuggestions = widget.controller.suggestions != null;
    if (hadSuggestions == hasSuggestions) return;
    hadSuggestions = hasSuggestions;
    load();
  }

  Future<void> load() async {
    if (widget.controller.suggestions != null) return;
    return reload();
  }

  Future<void> reload() async {
    if (!mounted) return;
    if (!wasOpen) return;

    if (widget.controller.isLoading) {
      isQueued = true;
      return;
    }

    widget.controller.suggestions = widget.controller.suggestions;
    widget.controller.isLoading = true;
    widget.controller.error = null;

    List<T>? newSuggestions;
    Object? newError;

    try {
      newSuggestions = (await widget.suggestionsCallback(search))?.toList();
    } on Exception catch (e) {
      newError = e;
    }

    if (!mounted) return;

    widget.controller.suggestions = newSuggestions;
    widget.controller.error = newError;
    widget.controller.isLoading = false;

    if (isQueued) {
      isQueued = false;
      await reload();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SuggestionsSearchTypingConnector<T>(
      controller: widget.controller,
      textEditingController: widget.textEditingController,
      child: SuggestionsSearchTextDebouncer(
        controller: widget.textEditingController,
        debounceDuration: widget.debounceDuration,
        onChanged: (value) {
          search = value;
          widget.controller.refresh();
        },
        child: ConnectorWidget(
          value: widget.controller,
          connect: (value) => value.addListener(onChange),
          disconnect: (value, key) => value.removeListener(onChange),
          child: ConnectorWidget(
            value: widget.controller,
            connect: (value) => value.$refreshes.listen((_) {
              hadSuggestions = false; // prevents double load
              reload();
            }),
            disconnect: (value, key) => key?.cancel(),
            child: widget.child,
          ),
        ),
      ),
    );
  }
}
