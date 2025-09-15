import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:zezis_widget/src/components/input/z_text_form/z_text_form_field.dart';

class ZDateTimePicker extends StatefulWidget {
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? paddingContent;
  final Color? disabledColor;
  final String? dateFormat;
  final double space;

  final String? labelDate;
  final EdgeInsetsGeometry? paddingDate;
  final Widget? iconDate;
  final DateTime initialDate;
  final DateTime lastDate;
  final DateTime firstDate;
  final bool visibleDate;

  final String? labelTime;
  final EdgeInsetsGeometry? paddingTime;
  final Widget? iconTime;
  final double? sizeTimer;
  final TimeOfDay initialTime;
  final bool visibleTime;

  final ValueChanged<DateTime?> onChangedDate;
  final ValueChanged<TimeOfDay?> onChangedPicker;

  const ZDateTimePicker({
    super.key,
    
    this.padding,
    this.paddingContent,
    this.disabledColor,
    this.dateFormat,
    this.space = 0.0,

    this.labelDate,
    this.paddingDate,
    this.iconDate,
    required this.initialDate,
    required this.lastDate,
    required this.firstDate,
    this.visibleDate = true,

    this.labelTime,
    this.paddingTime,
    this.iconTime,
    this.sizeTimer,
    required this.initialTime,
    this.visibleTime = true,

    required this.onChangedDate,
    required this.onChangedPicker,
  });

  @override
  State<ZDateTimePicker> createState() => _ZDateTimePickerState();
}

class _ZDateTimePickerState extends State<ZDateTimePicker> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.padding ?? const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Visibility(
            visible: widget.visibleDate,
            child: Expanded(
              child: InkWell(
                onTap: () async => await _onChangeDate(context),
                child: ZTextFormField(
                  enable: false,
                  autofocus: false,
                  labelText: widget.labelDate ?? "Data",
                  padding: widget.paddingDate ?? const EdgeInsets.fromLTRB(8, 0, 4, 0),
                  disabledColor: widget.disabledColor ?? Theme.of(context).primaryColor,
                  contentPadding: widget.paddingContent ?? const EdgeInsets.fromLTRB(15, 0, 0, 0),
                  controller: TextEditingController(text: DateFormat(widget.dateFormat ?? "dd/MM/yyyy").format(widget.initialDate)),
          
                  prefixIcon: widget.iconDate ?? Icon(
                    Icons.date_range_rounded,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
            ),
          ),

          SizedBox(width: widget.space),

          Visibility(
            visible: widget.visibleTime,
            child: SizedBox(
              width: widget.sizeTimer ?? 150,
              child: InkWell(
                onTap: () async => await _onChangeTime(context),
                child: ZTextFormField(
                  enable: false,
                  autofocus: false,
                  labelText: widget.labelTime ?? "Hora",
                  padding: widget.paddingTime ?? const EdgeInsets.fromLTRB(4, 0, 8, 0),
                  disabledColor: widget.disabledColor ?? Theme.of(context).primaryColor,
                  contentPadding: widget.paddingContent ?? const EdgeInsets.fromLTRB(15, 0, 0, 0),
                  controller: TextEditingController(text: "${widget.initialTime.hour.toString().padLeft(2, '0')}:${widget.initialTime.minute.toString().padLeft(2, '0')}"),
          
                  prefixIcon: widget.iconTime ?? Icon(
                    Icons.access_time_filled_rounded,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future _onChangeDate(BuildContext context) async {
    return await showDatePicker(
      context: context, 
      lastDate: widget.lastDate,
      firstDate: widget.firstDate, 

      initialDate: widget.initialDate, 

      useRootNavigator: false,
      barrierDismissible: false,

      cancelText: "Cancelar",
      confirmText: "Confirmar",
      helpText: "Selecione uma Data",
      fieldLabelText: "Digite uma Data",
    ).then(_thenDate)
     .catchError((error) => printError(info: error.toString()));
  }

  Future<void> _onChangeTime(BuildContext context) async {
    await showTimePicker(
      context: context, 
      initialTime: widget.initialTime,

      hourLabelText: "Hora",
      cancelText: "Cancelar",
      confirmText: "Confirmar",
      minuteLabelText: "Minutos",
      helpText: "Selecione um Horário",

      useRootNavigator: false,
      barrierDismissible: false,

      builder: (c, w) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
          child: w ?? const SizedBox(),
        );
      }
    ).then(_thenHour)
     .catchError((error) => printError(info: error.toString()));
  }

  void _thenDate(DateTime? value) {
    value ??= widget.initialDate;

    widget.onChangedDate.call(value);
    setState(() {});
  }

  void _thenHour(TimeOfDay? value) {
    value ??= widget.initialTime;

    widget.onChangedPicker.call(value);
    setState(() {});
  }
}