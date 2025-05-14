import 'package:flutter/material.dart';
import 'package:zezis_widget/zezis_widget.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notification"),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ZButton(
              width: 145,
              label: "Alert Custom Gif",

              onTap: () async => await showDialog(
                context: context, 
                builder: (context) => const ZAlertCustomGif(
                  title: "Alert Gif", 
                  description: "Alert Custom Gif - Zezis Widget"
                ),
              )
            ),

            ZButton(
              width: 145,
              label: "Alert Simple",

              onTap: () async => await zAlertSimple(
                context: context, 
                message: "Alert Simple - Zezis Widget"
              ),
            ),

            ZButton(
              width: 145,
              label: "SnackBar Custom",

              onTap: () => zSnackBarCustom(
                context: context, 
                message: "SnackBar Custom - Zezis Widget", backgroundColor: Colors.blue),
            ),

            ZButton(
              width: 145,
              label: "SnackBar Simple",

              onTap: () => showSnackBar("SnackBar Simple - Zezis Widget"),
            ),
          ],
        ),
      ),
    );
  }
}