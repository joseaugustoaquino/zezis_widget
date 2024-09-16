import 'package:flutter/material.dart';
import 'package:zezis_widget/z_button/z_button.dart';
import 'package:zezis_widget/z_date/z_date_picker.dart';
import 'package:zezis_widget/z_date/date_period/z_date_period.dart';

class DateTimePage extends StatefulWidget {
  const DateTimePage({super.key});

  @override
  State<DateTimePage> createState() => _DateTimePageState();
}

class _DateTimePageState extends State<DateTimePage> {
  var disabled = false;
  var dateSelect = DateTime.now();
  var hourSelect = TimeOfDay.now();
  DateTime? dateTime = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Date Time"),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ZDateTimePicker(
              space: 5,
              paddingDate: const EdgeInsets.all(0),
              paddingTime: const EdgeInsets.all(0),
              
              lastDate: DateTime(2050, 01, 01),
              firstDate: DateTime(2000, 01, 01), 

              initialDate: dateSelect, 
              initialTime: hourSelect, 
              
              onChangedDate: (value) => setState(() => dateSelect = value ?? dateSelect), 
              onChangedPicker: (value) => setState(() => hourSelect = value ?? hourSelect),
            ),

            ZDatePeriod(
              width: 10,
              endYear: 2050,
              startYear: 2020,
              disabled: disabled,
              isFormValidator: true,
                                
              selectedDay: dateTime?.day,
              selectedYear: dateTime?.year, 
              selectedMonth: dateTime?.month,

              inputDecoration: InputDecoration(
                contentPadding: const EdgeInsets.only(left: 15.0),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),

                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(width: 1.0, color: Theme.of(context).primaryColor),
                ),
              ), 
                                
              onChangedDay: (value) {
                setState(() => dateTime = DateTime(
                  dateTime?.year ?? DateTime.now().year,
                  dateTime?.month ?? DateTime.now().month,
                  int.parse(value ?? dateTime?.day.toString() ?? DateTime.now().day.toString()),
                ));
              },
              onChangedYear: (value) {
                setState(() => dateTime = DateTime(
                  int.parse(value ?? dateTime?.year.toString() ?? DateTime.now().year.toString()),
                  dateTime?.month ?? DateTime.now().month,
                  dateTime?.day ?? DateTime.now().day,
                ));
              },
              onChangedMonth: (value) {
               setState(() =>  dateTime = DateTime(
                  dateTime?.year ?? DateTime.now().year,
                  int.parse(value ?? dateTime?.month.toString() ?? DateTime.now().month.toString()),
                  dateTime?.day ?? DateTime.now().day,
                ));
              },
            ),
          
            ZButton(
              label: "Disable", 
              onTap: () {
                disabled = !disabled;
                dateTime = null;

                setState(() {});
              }
            )
          ],
        ),
      ),
    );
  }
}