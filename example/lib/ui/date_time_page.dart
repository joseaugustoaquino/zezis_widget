import 'package:flutter/material.dart';
import 'package:zezis_widget/z_date/z_date_picker.dart';

class DateTimePage extends StatefulWidget {
  const DateTimePage({super.key});

  @override
  State<DateTimePage> createState() => _DateTimePageState();
}

class _DateTimePageState extends State<DateTimePage> {
  var dateSelect = DateTime.now();
  var hourSelect = TimeOfDay.now();

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
              lastDate: DateTime(2050, 01, 01),
              firstDate: DateTime(2000, 01, 01), 

              initialDate: dateSelect, 
              initialTime: hourSelect, 
              
              onChangedDate: (value) => setState(() => dateSelect = value ?? dateSelect), 
              onChangedPicker: (value) => setState(() => hourSelect = value ?? hourSelect),
            ),
          ],
        ),
      ),
    );
  }
}