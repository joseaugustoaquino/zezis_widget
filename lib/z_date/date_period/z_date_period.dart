
// ignore_for_file: non_constant_identifier_names

library datepicker_dropdown;

import 'package:flutter/material.dart';

/// Defines widgets which are to used as DropDown Date Picker.
// ignore: must_be_immutable
class ZDatePeriod extends StatefulWidget {
  Icon? icon;
  TextStyle? textStyle;
  TextStyle? hintTextStyle;
  EdgeInsetsGeometry? padding;
  BoxDecoration? boxDecoration;
  InputDecoration? inputDecoration;
 
  ValueChanged<String?>? onChangedDay;
  ValueChanged<String?>? onChangedYear;
  ValueChanged<String?>? onChangedMonth;
 
  String hintDay;
  String errorDay;
  String hintYear;
  String errorYear;
  String hintMonth;
  String errorMonth;

  double width;
  double space;
  bool disabled;
  bool isExpanded;
  bool isFormValidator;

  int dayFlex;
  int yearFlex;
  int monthFlex;

  int? endYear;
  int? startYear;
  int? selectedDay;
  int? selectedMonth;
  int? selectedYear;

  ZDatePeriod({
    super.key,

    this.icon,
    this.textStyle,
    this.hintTextStyle,
    this.padding,
    this.boxDecoration,
    this.inputDecoration,

    this.onChangedDay,
    this.onChangedYear,
    this.onChangedMonth,

    this.hintDay = 'Day',
    this.errorDay = 'Please select day',
    this.hintYear = 'Year',
    this.errorYear = 'Please select year',
    this.hintMonth = 'Month',
    this.errorMonth = 'Please select month',

    this.width = 12.0,
    this.space = 5.0,
    this.disabled = false,
    this.isExpanded = true,
    this.isFormValidator = false,

    this.dayFlex = 1,
    this.yearFlex = 2,
    this.monthFlex = 3,

    this.endYear,
    this.startYear,
    this.selectedDay,
    this.selectedMonth,
    this.selectedYear,
  });

  @override
  // ignore: library_private_types_in_public_api
  _ZDatePeriodState createState() => _ZDatePeriodState();
}

class _ZDatePeriodState extends State<ZDatePeriod> {
  var dayselVal = '';
  var yearselVal = '';
  var monthselVal = '';

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
    monthselVal = widget.selectedMonth != null ? widget.selectedMonth.toString() : '';
    yearselVal = widget.selectedYear != null ? widget.selectedYear.toString() : '';

    listdates = Iterable<int>.generate(daysIn)
                             .skip(1)
                             .toList();

    listyears = Iterable<int>.generate((widget.endYear ?? DateTime.now().year) + 1)
                             .skip(widget.startYear ?? 1900)
                             .toList()
                             .reversed
                             .toList();

    listyears.sort((a, b) => a.compareTo(b));
  }

  ///check dates for selected month and year
  void checkDates(days) {
    if (dayselVal != '') {
      if (int.parse(dayselVal) > days) {
        dayselVal = '';
        if (widget.onChangedDay != null) { widget.onChangedDay!(''); }
        
        setState(() {});
      }
    }
  }

  int daysInMonth(year, month) => DateTimeRange(start: DateTime(year, month, 1), end: DateTime(year, month + 1)).duration.inDays;

  ///Selection dropdown function
  daysSelected(value) {
    if (widget.onChangedDay == null) { return; }

    widget.onChangedDay!(value);
    dayselVal = value;
    setState(() {});
  }

  monthSelected(value) {
    if (widget.onChangedMonth == null) { return; }

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

  yearsSelected(value) {
    if (widget.onChangedYear == null) { return; }

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
    if (widget.disabled) {
      dayselVal = '';
      monthselVal = '';
      yearselVal = '';

      setState(() {});
    }
    
    return Padding(
      padding: widget.padding ?? const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            flex: widget.dayFlex,
            child: Container(
              child: dayDropdown(),
            ),
          ),
      
          SizedBox(width: widget.space),
      
          Expanded(
            flex: widget.monthFlex,
            child: Container(
              decoration: widget.boxDecoration ?? const BoxDecoration(),
              child: monthDropdown(),
            ),
          ),
          
          SizedBox(width: widget.space),
          
          Expanded(
            flex: widget.yearFlex,
            child: Container(
              decoration: widget.boxDecoration ?? const BoxDecoration(),
              child: yearDropdown(),
            ),
          ),
        ],
      ),
    );
  }

  ///month dropdown
  DropdownButtonFormField<String> monthDropdown() {
    return DropdownButtonFormField<String>(
      isExpanded: widget.isExpanded,
      decoration: widget.inputDecoration,
      value: monthselVal == '' ? null : monthselVal,
      hint: Text(widget.hintMonth, style: widget.hintTextStyle),
      icon: widget.icon ?? const Icon(Icons.expand_more, color: Colors.grey),
      
      onChanged: widget.disabled ? null : (value) {
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
      }
    ).toList());
  }

  ///year dropdown
  DropdownButtonFormField<String> yearDropdown() {
    return DropdownButtonFormField<String>(
      isExpanded: widget.isExpanded,
      decoration: widget.inputDecoration,
      value: yearselVal == '' ? null : yearselVal,
      hint: Text(widget.hintYear, style: widget.hintTextStyle),
      icon: widget.icon ?? const Icon(Icons.expand_more, color: Colors.grey),

      onChanged: widget.disabled ? null : (value) {
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
      }
    ).toList());
  }

  ///day dropdown
  DropdownButtonFormField<String> dayDropdown() {
    return DropdownButtonFormField<String>(
      isExpanded: widget.isExpanded,
      decoration: widget.inputDecoration,
      value: dayselVal == '' ? null : dayselVal,
      hint: Text(widget.hintDay, style: widget.hintTextStyle),
      icon: widget.icon ?? const Icon(Icons.expand_more, color: Colors.grey),

      onChanged: widget.disabled ? null : (value) {
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
      }
    ).toList());
  }
}
