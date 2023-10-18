import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zezis_widget/z_input/z_input.dart';

class ZDateTimePicker extends StatelessWidget {
  final EdgeInsetsGeometry? padding;

  final String? labelDate;
  final EdgeInsetsGeometry? paddingDate;
  final Widget? iconDate;
  final DateTime initialDate;
  final DateTime lastDate;
  final DateTime firstDate;

  final String? labelTime;
  final EdgeInsetsGeometry? paddingTime;
  final Widget? iconTime;
  final double? sizeTimer;
  final TimeOfDay initialTime;

  final ValueChanged<DateTime?> onChangedDate;
  final ValueChanged<TimeOfDay?> onChangedPicker;

  const ZDateTimePicker({
    super.key,
    
    this.padding,

    this.labelDate,
    this.paddingDate,
    this.iconDate,
    required this.initialDate,
    required this.lastDate,
    required this.firstDate,

    this.labelTime,
    this.paddingTime,
    this.iconTime,
    this.sizeTimer,
    required this.initialTime,

    required this.onChangedDate,
    required this.onChangedPicker,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: InkWell(
              onTap: () async => await _onChangeDate(context),
              child: ZTextForm(
                enable: false,
                autofocus: false,
                labelText: labelDate ?? "Data",
                padding: paddingDate ?? const EdgeInsets.fromLTRB(8, 0, 4, 0),
                prefixIcon: iconDate ?? Icon(
                  Icons.date_range_rounded,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
          ),

          SizedBox(
            width: sizeTimer ?? 120,
            child: InkWell(
              onTap: () async => await _onChangeTime(context),
              child: ZTextForm(
                enable: false,
                autofocus: false,
                labelText: labelTime ?? "Hora",
                padding: paddingTime ?? const EdgeInsets.fromLTRB(4, 0, 8, 0),
                prefixIcon: iconTime ?? Icon(
                  Icons.access_time_filled_rounded,
                  color: Theme.of(context).primaryColor,
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
      lastDate: lastDate,
      firstDate: firstDate, 

      initialDate: initialDate, 
    ).then((value) => onChangedDate.call(value))
     .catchError((_) => printError(info: _.toString()));
  }

  _onChangeTime(BuildContext context) async {
    await showTimePicker(
      context: context, 
      initialTime: initialTime,
    ).then((value) => onChangedPicker.call(value))
     .catchError((_) => printError(info: _.toString()));
  }
}