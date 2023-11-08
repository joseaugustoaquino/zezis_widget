import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:zezis_widget/z_input/z_input.dart';

class ZDateTimePicker extends StatefulWidget {
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? paddingContent;
  final Color? disabledColor;
  final String? dateFormat;

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
  final TextEditingController dateController = TextEditingController();
  final TextEditingController hourController = TextEditingController();
  
  @override
  void initState() {
    dateController.text = DateFormat(widget.dateFormat ?? "dd/MM/yyyy").format(widget.initialDate);
    hourController.text = "${widget.initialTime.hour.toString().padLeft(2, '0')}:${widget.initialTime.minute.toString().padLeft(2, '0')}";
    super.initState();
  }

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
                child: ZTextForm(
                  enable: false,
                  autofocus: false,
                  controller: dateController,
                  labelText: widget.labelDate ?? "Data",
                  padding: widget.paddingDate ?? const EdgeInsets.fromLTRB(8, 0, 4, 0),
                  disabledColor: widget.disabledColor ?? Theme.of(context).primaryColor,
                  contentPadding: widget.paddingContent ?? const EdgeInsets.fromLTRB(15, 0, 0, 0),
          
                  prefixIcon: widget.iconDate ?? Icon(
                    Icons.date_range_rounded,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
            ),
          ),

          Visibility(
            visible: widget.visibleTime,
            child: SizedBox(
              width: widget.sizeTimer ?? 150,
              child: InkWell(
                onTap: () async => await _onChangeTime(context),
                child: ZTextForm(
                  enable: false,
                  autofocus: false,
                  controller: hourController,
                  labelText: widget.labelTime ?? "Hora",
                  padding: widget.paddingTime ?? const EdgeInsets.fromLTRB(4, 0, 8, 0),
                  disabledColor: widget.disabledColor ?? Theme.of(context).primaryColor,
                  contentPadding: widget.paddingContent ?? const EdgeInsets.fromLTRB(15, 0, 0, 0),
          
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

  _onChangeDate(BuildContext context) async {
    return await showDatePicker(
      context: context, 
      lastDate: widget.lastDate,
      firstDate: widget.firstDate, 

      initialDate: widget.initialDate, 
    ).then(_thenDate)
     .catchError((_) => printError(info: _.toString()));
  }

  _onChangeTime(BuildContext context) async {
    await showTimePicker(
      context: context, 
      initialTime: widget.initialTime,
    ).then(_thenHour)
     .catchError((_) => printError(info: _.toString()));
  }

  _thenDate(DateTime? value) {
    value ??= widget.initialDate;

    dateController.text = DateFormat(widget.dateFormat ?? "dd/MM/yyyy").format(value);
    widget.onChangedDate.call(value);
    setState(() {});
  }

  _thenHour(TimeOfDay? value) {
    value ??= widget.initialTime;

    hourController.text = "${value.hour.toString().padLeft(2, '0')}:${value.minute.toString().padLeft(2, '0')}";
    widget.onChangedPicker.call(value);
    setState(() {});
  }
}