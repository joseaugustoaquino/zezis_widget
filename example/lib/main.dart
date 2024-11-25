// ignore_for_file: depend_on_referenced_packages
import 'package:example/ui/drag_and_drop_page.dart';
import 'package:example/ui/input_page.dart';
import 'package:example/ui/date_time_page.dart';
import 'package:flutter/material.dart';
import 'package:zezis_widget/z_button/z_button.dart';
import 'package:zezis_widget/z_button/z_button_icon.dart';

import 'ui/divider_page.dart';
import 'ui/loading_page.dart';
import 'ui/notification_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
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
        useMaterial3: true,
        primaryColor: Colors.blueAccent,
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

      body: FocusScope(
        child: FocusTraversalGroup(
          policy: OrderedTraversalPolicy(),

          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                FocusTraversalOrder(
                  order: const NumericFocusOrder(1.0),

                  child: ZButton(
                    width: 145,
                    label: "Divider",
                    onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => const DividerPage())),
                  ),
                ),

                FocusTraversalOrder(
                  order: const NumericFocusOrder(2.0),

                  child: ZButton(
                    width: 145,
                    label: "Loading",
                    onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => const LoadingPage())),
                  ),
                ),
          
                FocusTraversalOrder(
                  order: const NumericFocusOrder(3.0),

                  child: ZButton(
                    width: 145,
                    label: "Notification",
                    onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => const NotificationPage())),
                  ),
                ),
              
                FocusTraversalOrder(
                  order: const NumericFocusOrder(4.0),

                  child: ZButton(
                    width: 145,
                    label: "Date Time",
                    onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => const DateTimePage())),
                  ),
                ),
          
                FocusTraversalOrder(
                  order: const NumericFocusOrder(5.0),

                  child: ZButton(
                    width: 145,
                    label: "Input",
                    onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => const InputPage())),
                  ),
                ),
          
                FocusTraversalOrder(
                  order: const NumericFocusOrder(6.0),

                  child: ZButtonIcon(
                    width: 145,
                    label: "Whatsapp", 
                    icon: Icons.whatshot,
                  
                    onTap: () {},
                  ),
                ),

                FocusTraversalOrder(
                  order: const NumericFocusOrder(6.0),

                  child: ZButtonIcon(
                    width: 145,
                    label: "Drag And Drop", 
                    icon: Icons.drag_handle_rounded,
                    onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => const DragAndDropPage())),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
