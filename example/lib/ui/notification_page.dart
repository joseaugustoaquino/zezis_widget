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
            const Text(
              "Alert Custom Gif:",
              style: TextStyle(
                fontSize: 16,
                color: Colors.blue,
                fontWeight: FontWeight.bold,
              ),
            ),

            TextButton(
              style: const ButtonStyle(
                elevation: MaterialStatePropertyAll(3),
                backgroundColor: MaterialStatePropertyAll(Colors.blue),
                shape: MaterialStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10)))),
              ),
              child: const SizedBox(
                width: 120,
                child: Text(
                  "Alert Custom Gif",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold
                  ),
                ),
              ),
              onPressed: () async {
                return await showDialog(
                  context: context, 
                  builder: (context) => const ZAlertCustomGif(
                    title: "Alert Gif", 
                    description: "Alert Custom Gif - Zezis Widget"
                  ),
                );
              },
            ),

            const SizedBox(height: 10),

            const Text(
              "Alert Simple:",
              style: TextStyle(
                fontSize: 16,
                color: Colors.blue,
                fontWeight: FontWeight.bold,
              ),
            ),

            TextButton(
              style: const ButtonStyle(
                elevation: MaterialStatePropertyAll(3),
                backgroundColor: MaterialStatePropertyAll(Colors.blue),
                shape: MaterialStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10)))),
              ),
              child: const SizedBox(
                width: 120,
                child: Text(
                  "Alert Simple",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold
                  ),
                ),
              ),
              onPressed: () async {
                return await zAlertSimple(
                  context: context, 
                  message: "Alert Simple - Zezis Widget"
                );
              },
            ),

            const SizedBox(height: 10),

            const Text(
              "SnackBar Custom:",
              style: TextStyle(
                fontSize: 16,
                color: Colors.blue,
                fontWeight: FontWeight.bold,
              ),
            ),

            TextButton(
              style: const ButtonStyle(
                elevation: MaterialStatePropertyAll(3),
                backgroundColor: MaterialStatePropertyAll(Colors.blue),
                shape: MaterialStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10)))),
              ),
              child: const SizedBox(
                width: 120,
                child: Text(
                  "SnackBar Custom",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold
                  ),
                ),
              ),
              onPressed: () {
                zSnackBarCustom(context: context, message: "SnackBar Custom - Zezis Widget", backgroundColor: Colors.blue);
              },
            ),

            const SizedBox(height: 10),

            const Text(
              "SnackBar Simple:",
              style: TextStyle(
                fontSize: 16,
                color: Colors.blue,
                fontWeight: FontWeight.bold,
              ),
            ),

            TextButton(
              style: const ButtonStyle(
                elevation: MaterialStatePropertyAll(3),
                backgroundColor: MaterialStatePropertyAll(Colors.blue),
                shape: MaterialStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10)))),
              ),
              child: const SizedBox(
                width: 120,
                child: Text(
                  "SnackBar Simple",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold
                  ),
                ),
              ),
              onPressed: () {
                zSnackBarSimple(context: context, message: "SnackBar Simple - Zezis Widget");
              },
            ),
          ],
        ),
      ),
    );
  }
}