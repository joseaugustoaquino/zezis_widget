import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

class SuggestionsController<T> extends ChangeNotifier {
  SuggestionsController();

  static SuggestionsController<T>? maybeOf<T>(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<SuggestionsControllerProvider<T>>()
        ?.notifier;
  }

  static SuggestionsController<T> of<T>(BuildContext context) {
    SuggestionsController<T>? controller = maybeOf<T>(context);
    if (controller == null) {
      throw FlutterError.fromParts(
        [
          ErrorSummary('No SuggestionsController found in the context. '),
          ErrorDescription(
            'SuggestionsControllers are only available inside SuggestionsBox widgets.',
          ),
          ErrorHint('Are you inside a SuggestionsBox?'),
          context.describeElement('The context used was')
        ],
      );
    }
    return controller;
  }

  List<T>? get suggestions =>
      _suggestions == null ? null : List.of(_suggestions!);
  set suggestions(List<T>? value) {
    if (listEquals(_suggestions, value)) return;
    if (value != null) {
      value = List.of(value);
    }
    _suggestions = value;
    notifyListeners();
  }

  List<T>? _suggestions;

  Stream<void> get $refreshes => _refreshesController.stream;
  final StreamController<void> _refreshesController =
      StreamController<void>.broadcast();

  void refresh() {
    ChangeNotifier.debugAssertNotDisposed(this);
    _suggestions = null;
    _refreshesController.add(null);
  }

  bool get isLoading => _isLoading;
  set isLoading(bool value) {
    if (_isLoading == value) return;
    _isLoading = value;
    notifyListeners();
  }

  bool _isLoading = false;

  bool get hasError => _error != null;

  Object? get error => _error;
  set error(Object? value) {
    if (_error == value) return;
    _error = value;
    notifyListeners();
  }

  Object? _error;

  bool get isOpen => _isOpen;
  bool _isOpen = false;

  SuggestionsFocusState get focusState => _focusState;
  SuggestionsFocusState _focusState = SuggestionsFocusState.blur;

  bool get retainFocus => _retainFocus;
  bool _retainFocus = false;

  bool get gainFocus => _gainFocus;
  bool _gainFocus = true;

  VerticalDirection get direction => _direction;
  set direction(VerticalDirection value) {
    if (_direction == value) return;
    _direction = value;
    notifyListeners();
  }

  VerticalDirection _direction = VerticalDirection.down;

  VerticalDirection get effectiveDirection => _effectiveDirection;
  set effectiveDirection(VerticalDirection value) {
    if (_effectiveDirection == value) return;
    _effectiveDirection = value;
    notifyListeners();
  }

  VerticalDirection _effectiveDirection = VerticalDirection.down;

  Stream<void> get $resizes => _resizesController.stream;
  final StreamController<void> _resizesController =
      StreamController<void>.broadcast();

  void resize() {
    ChangeNotifier.debugAssertNotDisposed(this);
    _resizesController.add(null);
  }

  Stream<T> get selections => _selectionsController.stream;
  final StreamController<T> _selectionsController =
      StreamController<T>.broadcast();

  void select(T suggestion) => _selectionsController.add(suggestion);

  void focusBox() {
    if (_focusState == SuggestionsFocusState.box) return;
    _focusState = SuggestionsFocusState.box;
    notifyListeners();
  }

  void focusField() {
    if (_focusState == SuggestionsFocusState.field) return;
    _focusState = SuggestionsFocusState.field;
    notifyListeners();
  }

  void unfocus() {
    if (_focusState == SuggestionsFocusState.blur) return;
    _focusState = SuggestionsFocusState.blur;
    notifyListeners();
  }

  void open({bool gainFocus = true}) {
    if (isOpen) return;
    _isOpen = true;
    _gainFocus = gainFocus;
    notifyListeners();
    resize();
  }

  void close({bool retainFocus = false}) {
    if (!isOpen) return;
    _isOpen = false;
    _retainFocus = retainFocus;
    notifyListeners();
  }

  void toggle() {
    if (isOpen) {
      close();
    } else {
      open();
    }
  }

  @override
  void dispose() {
    close();
    _refreshesController.close();
    _resizesController.close();
    _selectionsController.close();
    super.dispose();
  }
}

class SuggestionsControllerProvider<T>
    extends InheritedNotifier<SuggestionsController<T>> {
  const SuggestionsControllerProvider({
    super.key,
    required SuggestionsController<T> controller,
    required super.child,
  }) : super(notifier: controller);
}

enum SuggestionsFocusState {
  blur,
  box,
  field;

  bool get hasFocus => this != SuggestionsFocusState.blur;
}
