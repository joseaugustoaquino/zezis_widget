
// ignore_for_file: non_constant_identifier_names

library datepicker_dropdown;

import 'package:flutter/material.dart';

/// Defines widgets which are to used as DropDown Date Picker.
// ignore: must_be_immutable
class ZDatePeriod extends StatefulWidget {
  final TextStyle? textStyle;
  final BoxDecoration? boxDecoration;
  final InputDecoration? inputDecoration;
  final Icon? icon;
  final int? startYear;
  final int? endYear;
  final double width;
 
  ValueChanged<String?>? onChangedDay;
  ValueChanged<String?>? onChangedMonth;
  ValueChanged<String?>? onChangedYear;
 
  String errorDay;
  String errorMonth;
  String errorYear;
  String hintMonth;
  String hintYear;
  String hintDay;

  TextStyle? hintTextStyle;
  
  final bool isFormValidator;
  final bool isExpanded;
  final int? selectedDay;
  final int? selectedMonth;
  final int? selectedYear;

  int monthFlex;
  int dayFlex;
  int yearFlex;

  ZDatePeriod(
      {Key? key,
      this.textStyle,
      this.boxDecoration,
      this.inputDecoration,
      this.icon,
      this.startYear,
      this.endYear,
      this.width = 12.0,
      this.onChangedDay,
      this.onChangedMonth,
      this.onChangedYear,
      this.errorDay = 'Please select day',
      this.errorMonth = 'Please select month',
      this.errorYear = 'Please select year',
      this.hintMonth = 'Month',
      this.hintDay = 'Day',
      this.hintYear = 'Year',
      this.hintTextStyle,
      this.isFormValidator = false,
      this.isExpanded = true,
      this.selectedDay,
      this.selectedMonth,
      this.selectedYear,
      this.monthFlex = 3,
      this.dayFlex = 1,
      this.yearFlex = 2})
      : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _ZDatePeriodState createState() => _ZDatePeriodState();
}

class _ZDatePeriodState extends State<ZDatePeriod> {
  var monthselVal = '';
  var dayselVal = '';
  var yearselVal = '';
  int daysIn = 32;
  late List listdates = [];
  late List listyears = [];
  late List<dynamic> listMonths = [
    {"id": 1, "value": "Jan."},
    {"id": 2, "value": "Fev."},
    {"id": 3, "value": "Mar."},
    {"id": 4, "value": "Abr."},
    {"id": 5, "value": "Mai."},
    {"id": 6, "value": "Jun."},
    {"id": 7, "value": "Jul."},
    {"id": 8, "value": "Aug."},
    {"id": 9, "value": "Set."},
    {"id": 10, "value": "Out."},
    {"id": 11, "value": "Nov."},
    {"id": 12, "value": "Dez."}
  ];

  @override
  void initState() {
    super.initState();
    dayselVal = widget.selectedDay != null ? widget.selectedDay.toString() : '';
    monthselVal =
        widget.selectedMonth != null ? widget.selectedMonth.toString() : '';
    yearselVal =
        widget.selectedYear != null ? widget.selectedYear.toString() : '';
    listdates = Iterable<int>.generate(daysIn).skip(1).toList();
    listyears = Iterable<int>.generate((widget.endYear ?? DateTime.now().year) + 1)
      .skip(widget.startYear ?? 1900)
      .toList()
      .reversed
      .toList();

    listyears.sort((a, b) => a.compareTo(b));
  }

  ///Month selection dropdown function
  monthSelected(value) {
    widget.onChangedMonth!(value);
    monthselVal = value;
    int days = daysInMonth(
      yearselVal == '' ? DateTime.now().year : int.parse(yearselVal),
      int.parse(value)
    );
    listdates = Iterable<int>.generate(days + 1).skip(1).toList();
    checkDates(days);
    setState(() {});
  }

  ///check dates for selected month and year
  void checkDates(days) {
    if (dayselVal != '') {
      if (int.parse(dayselVal) > days) {
        dayselVal = '';
        widget.onChangedDay!('');
        setState(() {});
      }
    }
  }

  int daysInMonth(year, month) => 
    DateTimeRange(start: DateTime(year, month, 1), end: DateTime(year, month + 1))
    .duration
    .inDays;

  daysSelected(value) {
    widget.onChangedDay!(value);
    dayselVal = value;
    setState(() {});
  }

  yearsSelected(value) {
    widget.onChangedYear!(value);
    yearselVal = value;
    if (monthselVal != '') {
      int days = daysInMonth(yearselVal == '' ? DateTime.now().year : int.parse(yearselVal), int.parse(monthselVal));
      listdates = Iterable<int>.generate(days + 1).skip(1).toList();
      checkDates(days);
      setState(() {});
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: widget.dayFlex,
          child: Container(
            child: dayDropdown(),
          ),
        ),

        const SizedBox(width: 8),

        Expanded(
          flex: widget.monthFlex,
          child: Container(
            decoration: widget.boxDecoration ?? const BoxDecoration(),
            child: monthDropdown(),
          ),
        ),
        
        const SizedBox(width: 8),
        
        Expanded(
          flex: widget.yearFlex,
          child: Container(
            decoration: widget.boxDecoration ?? const BoxDecoration(),
            child: yearDropdown(),
          ),
        ),
      ],
    );
  }

  ///month dropdown
  DropdownButtonFormField<String> monthDropdown() {
    return DropdownButtonFormField<String>(
        decoration: widget.inputDecoration,
        isExpanded: widget.isExpanded,
        hint: Text(widget.hintMonth, style: widget.hintTextStyle),
        icon: widget.icon ?? const Icon(Icons.expand_more, color: Colors.grey),
        value: monthselVal == '' ? null : monthselVal,
        onChanged: (value) {
          monthSelected(value);
        },
        validator: (value) {
          return widget.isFormValidator
              ? value == null
                  ? widget.errorMonth
                  : null
              : null;
        },
        items: listMonths.map((item) {
          return DropdownMenuItem<String>(
            value: item["id"].toString(),
            child: Text(
              item["value"].toString(),
              style: widget.textStyle ??
                const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.black
                ),
            ),
          );
        }).toList());
  }

  ///year dropdown
  DropdownButtonFormField<String> yearDropdown() {
    return DropdownButtonFormField<String>(
        decoration: widget.inputDecoration,
        hint: Text(widget.hintYear, style: widget.hintTextStyle),
        isExpanded: widget.isExpanded,
        icon: widget.icon ?? const Icon(Icons.expand_more, color: Colors.grey),
        value: yearselVal == '' ? null : yearselVal,
        onChanged: (value) {
          yearsSelected(value);
        },
        validator: (value) {
          return widget.isFormValidator
              ? value == null
                  ? widget.errorYear
                  : null
              : null;
        },
        items: listyears.map((item) {
          return DropdownMenuItem<String>(
            value: item.toString(),
            child: Text(
              item.toString(),
              style: widget.textStyle ??
                  const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.black),
            ),
          );
        }).toList());
  }

  ///day dropdown
  DropdownButtonFormField<String> dayDropdown() {
    return DropdownButtonFormField<String>(
        decoration: widget.inputDecoration,
        hint: Text(widget.hintDay, style: widget.hintTextStyle),
        isExpanded: widget.isExpanded,
        icon: widget.icon ?? const Icon(Icons.expand_more, color: Colors.grey),
        value: dayselVal == '' ? null : dayselVal,
        onChanged: (value) {
          daysSelected(value);
        },
        validator: (value) {
          return widget.isFormValidator
              ? value == null
                  ? widget.errorDay
                  : null
              : null;
        },
        items: listdates.map((item) {
          return DropdownMenuItem<String>(
            value: item.toString(),
            child: Text(item.toString(),
                style: widget.textStyle ??
                    const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.black)),
          );
        }).toList());
  }
}
