import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:zezis_widget/zezis_widget.dart';

class ComboBoxPage extends StatefulWidget {
  const ComboBoxPage({super.key});

  @override
  State<ComboBoxPage> createState() => _ComboBoxPageState();
}

class _ComboBoxPageState extends State<ComboBoxPage> {
  var loadingCustom = false;
  var loadingSimple = false;

  String country = "BRASIL";
  List<String> countries = [
    "BRASIL",
    "RÚSSIA",
    "ESTADOS UNIDOS",
    "PARAGUAI",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Combo Box"),
        backgroundColor: Colors.blue,
      ),

      body: Center(
        child: ZComboBox(
          labelText: "Curso",
          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
          contentPadding: const EdgeInsets.fromLTRB(10, 0, 5, 0),
        
          value: country,
          items: countries.map((x) {
            return DropdownMenuItem<String>(
              value: x,
              child: Text(
                x,
                style: GoogleFonts.roboto(color: Colors.black),
              ),
            );
          }).toList(),
            
          onChanged: (value) => setState(() => country = value ?? countries[0]),
        ),
      ),
    );
  }
}