import 'package:flutter/widgets.dart';

class ConnectorWidget<T, R> extends StatefulWidget {
  const ConnectorWidget({
    super.key,
    required this.value,
    this.connect,
    this.disconnect,
    required this.child,
  });

  final T value;
  final R Function(T value)? connect;
  final void Function(T value, R? key)? disconnect;
  final Widget child;

  @override
  State<ConnectorWidget<T, R>> createState() => _ConnectorWidgetState<T, R>();
}

class _ConnectorWidgetState<T, R> extends State<ConnectorWidget<T, R>> {
  R? key;

  @override
  void initState() {
    super.initState();
    key = widget.connect?.call(widget.value);
  }

  @override
  void didUpdateWidget(covariant ConnectorWidget<T, R> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.value != widget.value) {
      widget.disconnect?.call(oldWidget.value, key);
      key = widget.connect?.call(widget.value);
    }
  }

  @override
  void dispose() {
    widget.disconnect?.call(widget.value, key);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => widget.child;
}
