import 'package:flutter/material.dart';
import 'package:zezis_widget/zezis_widget.dart';

class DividerPage extends StatefulWidget {
  const DividerPage({super.key});

  @override
  State<DividerPage> createState() => _DividerPageState();
}

class _DividerPageState extends State<DividerPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Divider"),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ZDividerTitle(
              title: "Divider Title",
              colorTitle: Colors.blue[300],
              colorDivider: Colors.black45,
              fontSize: 18,
            ),

            const SizedBox(height: 10),
            
            ZDividerInformation(
              title: "Divider Information",
              colorTitle: Colors.blue[300],
              colorDivider: Colors.black45,
              fontSize: 18,
            ),
          ],
        ),
      ),
    );
  }
}