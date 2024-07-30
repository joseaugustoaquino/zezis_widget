// ignore_for_file: depend_on_referenced_packages
import 'package:example/ui/combo_box_page.dart';
import 'package:example/ui/date_time_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:zezis_widget/z_button/z_button_icon.dart';

import 'ui/divider_page.dart';
import 'ui/loading_page.dart';
import 'ui/notification_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Zezis Widget"),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextButton(
              style: const ButtonStyle(
                elevation: WidgetStatePropertyAll(3),
                backgroundColor: WidgetStatePropertyAll(Colors.blue),
                shape: WidgetStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10)))),
              ),
              child: SizedBox(
                width: 120,
                child: Text(
                  "Divider",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.roboto(
                    color: Colors.white,
                    fontWeight: FontWeight.bold
                  ),
                ),
              ),
              onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => const DividerPage())),
            ),

            TextButton(
              style: const ButtonStyle(
                elevation: WidgetStatePropertyAll(3),
                backgroundColor: WidgetStatePropertyAll(Colors.blue),
                shape: WidgetStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10)))),
              ),
              child: SizedBox(
                width: 120,
                child: Text(
                  "Loading",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.roboto(
                    color: Colors.white,
                    fontWeight: FontWeight.bold
                  ),
                ),
              ),
              onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => const LoadingPage())),
            ),

            TextButton(
              style: const ButtonStyle(
                elevation: WidgetStatePropertyAll(3),
                backgroundColor: WidgetStatePropertyAll(Colors.blue),
                shape: WidgetStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10)))),
              ),
              child: SizedBox(
                width: 120,
                child: Text(
                  "Notification",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.roboto(
                    color: Colors.white,
                    fontWeight: FontWeight.bold
                  ),
                ),
              ),
              onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => const NotificationPage())),
            ),
          
            TextButton(
              style: const ButtonStyle(
                elevation: WidgetStatePropertyAll(3),
                backgroundColor: WidgetStatePropertyAll(Colors.blue),
                shape: WidgetStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10)))),
              ),
              child: SizedBox(
                width: 120,
                child: Text(
                  "Date Time",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.roboto(
                    color: Colors.white,
                    fontWeight: FontWeight.bold
                  ),
                ),
              ),
              onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => const DateTimePage())),
            ),

            TextButton(
              style: const ButtonStyle(
                elevation: WidgetStatePropertyAll(3),
                backgroundColor: WidgetStatePropertyAll(Colors.blue),
                shape: WidgetStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10)))),
              ),
              child: SizedBox(
                width: 120,
                child: Text(
                  "Combo Box",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.roboto(
                    color: Colors.white,
                    fontWeight: FontWeight.bold
                  ),
                ),
              ),
              onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => const ComboBoxPage())),
            ),

            ZButtonIcon(
              icon: Icons.whatshot,
              label: "Whatsapp", 
              onTap: () {}
            ),
          ],
        ),
      ),
    );
  }
}
