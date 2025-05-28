// ignore_for_file: depend_on_referenced_packages
import 'package:flutter/material.dart';
import 'package:zezis_widget/zezis_widget.dart';

class LoadingPage extends StatefulWidget {
  const LoadingPage({super.key});

  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  var loadingCustom = false;
  var loadingSimple = false;

  @override
  Widget build(BuildContext context) {
    if (loadingCustom) {
      return const ZLoadingCustom(
        radius: 30,
      );
    }

    if (loadingSimple) {
      return const ZLoadingSimple(image: "assets/loading.jpg");
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Loading"),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              "Loading Simple:",
              style: TextStyle(
                fontSize: 16,
                color: Colors.blue,
                fontWeight: FontWeight.bold,
              ),
            ),

            TextButton(
              style: const ButtonStyle(
                elevation: WidgetStatePropertyAll(3),
                backgroundColor: WidgetStatePropertyAll(Colors.blue),
                shape: WidgetStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10)))),
              ),
              child: const SizedBox(
                width: 120,
                child: Text(
                  "Loading Simple",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold
                  ),
                ),
              ),
              onPressed: () {
                setState(() => loadingSimple = true);
                Future.delayed(const Duration(milliseconds: 1200), () => setState(() => loadingSimple = false));
              },
            ),

            const SizedBox(height: 10),

            const Text(
              "Loading Custom:",
              style: TextStyle(
                fontSize: 16,
                color: Colors.blue,
                fontWeight: FontWeight.bold,
              ),
            ),
            
            TextButton(
              style: const ButtonStyle(
                elevation: WidgetStatePropertyAll(3),
                backgroundColor: WidgetStatePropertyAll(Colors.blue),
                shape: WidgetStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10)))),
              ),
              child: const SizedBox(
                width: 120,
                child: Text(
                  "Loading Custom",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold
                  ),
                ),
              ),
              onPressed: () {
                setState(() => loadingCustom = true);
                Future.delayed(const Duration(milliseconds: 1200), () => setState(() => loadingCustom = false));
              },
            ),
          ],
        ),
      ),
    );
  }
}