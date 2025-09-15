
// ignore_for_file: non_constant_identifier_names

library;

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
  bool isAllName = false;

  bool dayDisabled = false;
  bool monthDisabled = false;
  bool yearDisabled = false;

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
    this.isAllName = false,

    this.dayDisabled = false,
    this.monthDisabled = false,
    this.yearDisabled = false,

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
    {"id": 1, "value": "Jan.", "value2": "Janeiro"},
    {"id": 2, "value": "Fev.", "value2": "Fevereiro"},
    {"id": 3, "value": "Mar.", "value2": "Março"},
    {"id": 4, "value": "Abr.", "value2": "Abril"},
    {"id": 5, "value": "Mai.", "value2": "Maio"},
    {"id": 6, "value": "Jun.", "value2": "Junho"},
    {"id": 7, "value": "Jul.", "value2": "Julho"},
    {"id": 8, "value": "Aug.", "value2": "Agosto"},
    {"id": 9, "value": "Set.", "value2": "Setembro"},
    {"id": 10, "value": "Out.", "value2": "Outubro"},
    {"id": 11, "value": "Nov.", "value2": "Novembro"},
    {"id": 12, "value": "Dez.", "value2": "Dezembro"}
  ];

  @override
  void initState() {
    super.initState();

    dayselVal = widget.selectedDay != null ? widget.selectedDay.toString() : '';
    yearselVal = widget.selectedYear != null ? widget.selectedYear.toString() : '';
    monthselVal = widget.selectedMonth != null ? widget.selectedMonth.toString() : '';

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
  void checkDates(int days) {
    if (dayselVal != '') {
      if (int.parse(dayselVal) > days) {
        dayselVal = '';
        if (widget.onChangedDay != null) { widget.onChangedDay!(''); }
        
        setState(() {});
      }
    }
  }

  int daysInMonth(int year, int month) => DateTimeRange(start: DateTime(year, month, 1), end: DateTime(year, month + 1)).duration.inDays;

  ///Selection dropdown function
  void daysSelected(String? value) {
    if (value == null) { return; }
    if (widget.onChangedDay == null) { return; }

    widget.onChangedDay!(value);
    dayselVal = value;
    setState(() {});
  }

  void monthSelected(String? value) {
    if (value == null) { return; }
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

  void yearsSelected(String? value) {
    if (value == null) { return; }
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
          Visibility(
            visible: !widget.dayDisabled,

            child: Expanded(
              flex: widget.dayFlex,
              child: Container(
                child: dayDropdown(),
              ),
            ),
          ),
      
          Visibility(
            visible: !widget.dayDisabled,
            child: SizedBox(width: widget.space)
          ),
      
          Visibility(
            visible: !widget.monthDisabled,

            child: Expanded(
              flex: widget.monthFlex,
              child: Container(
                decoration: widget.boxDecoration ?? const BoxDecoration(),
                child: monthDropdown(),
              ),
            ),
          ),
          
          Visibility(
            visible: (!widget.monthDisabled || !widget.yearDisabled),
            child: SizedBox(width: widget.space)
          ),
      
          Visibility(
            visible: !widget.yearDisabled,

            child: Expanded(
              flex: widget.yearFlex,
              child: Container(
                decoration: widget.boxDecoration ?? const BoxDecoration(),
                child: yearDropdown(),
              ),
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
      decoration: widget.inputDecoration ?? InputDecoration(
        enabled: !widget.disabled,
        contentPadding: const EdgeInsets.only(left: 15.0, right: 10),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),

        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(width: 1.0, color: Theme.of(context).primaryColor),
        ),

        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(width: 1.0, color: Theme.of(context).disabledColor),
        ),
      ),

      initialValue: monthselVal == '' ? null : monthselVal,
      hint: Text(widget.hintMonth, style: widget.hintTextStyle),
      onChanged: widget.disabled ? null : (value) => monthSelected(value),
      icon: widget.icon ?? Icon(Icons.arrow_drop_down, color: widget.disabled ? Theme.of(context).disabledColor : Theme.of(context).primaryColor),

      validator: (value) {
        return widget.isFormValidator 
          ? (value == null ? widget.errorMonth : null) : null;
      },
      
      items: listMonths.map((item) {
        return DropdownMenuItem<String>(
          value: item["id"].toString(),
          child: Text(
            !widget.isAllName ? item["value"].toString() : item["value2"].toString(),
            
            style: widget.textStyle ?? const TextStyle(
              fontSize: 16,
              color: Colors.black,
              fontWeight: FontWeight.w500,
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
      decoration: widget.inputDecoration ?? InputDecoration(
        enabled: !widget.disabled,
        contentPadding: const EdgeInsets.only(left: 15.0, right: 10),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),

        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(width: 1.0, color: Theme.of(context).primaryColor),
        ),

        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(width: 1.0, color: Theme.of(context).disabledColor),
        ),
      ),

      initialValue: yearselVal == '' ? null : yearselVal,
      hint: Text(widget.hintYear, style: widget.hintTextStyle),
      onChanged: widget.disabled ? null : (value) => yearsSelected(value),
      icon: widget.icon ?? Icon(Icons.arrow_drop_down, color: widget.disabled ? Theme.of(context).disabledColor : Theme.of(context).primaryColor),
      
      validator: (value) {
        return widget.isFormValidator
          ? (value == null ? widget.errorYear : null) : null;
      },
      
      items: listyears.map((item) {
        return DropdownMenuItem<String>(
          value: item.toString(),
          child: Text(
            item.toString(),
            style: widget.textStyle ?? const TextStyle(
              fontSize: 16,
              color: Colors.black,
              fontWeight: FontWeight.w500,
            ),
          ),
        );
      }
    ).toList());
  }

  ///day dropdown
  DropdownButtonFormField<String> dayDropdown() {
    return DropdownButtonFormField<String>(
      isExpanded: widget.isExpanded,
      decoration: widget.inputDecoration ?? InputDecoration(
        enabled: !widget.disabled,
        contentPadding: const EdgeInsets.only(left: 15.0, right: 10),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),

        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(width: 1.0, color: Theme.of(context).primaryColor),
        ),

        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(width: 1.0, color: Theme.of(context).disabledColor),
        ),
      ),
      
      initialValue: dayselVal == '' ? null : dayselVal,
      hint: Text(widget.hintDay, style: widget.hintTextStyle),
      onChanged: widget.disabled ? null : (value) => daysSelected(value),
      icon: widget.icon ?? Icon(Icons.arrow_drop_down, color: widget.disabled ? Theme.of(context).disabledColor : Theme.of(context).primaryColor),
      
      validator: (value) {
        return widget.isFormValidator
          ? (value == null ? widget.errorDay : null) : null;
      },
      
      items: listdates.map((item) {
        return DropdownMenuItem<String>(
          value: item.toString(),
          child: Text(item.toString(),
              style: widget.textStyle ?? const TextStyle(
                fontSize: 16,
                color: Colors.black,
                fontWeight: FontWeight.w500,
            )
          ),
        );
      }
    ).toList());
  }
}
