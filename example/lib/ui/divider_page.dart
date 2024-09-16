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
        centerTitle: true,
        title: const Text("Divider"),
      ),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const ZDividerTitle(
              fontSize: 18,
              title: "Divider Title",
            ),

            const SizedBox(height: 10),
            
            ZDividerInformation(              
              fontSize: 18,
              icon: Icons.info_rounded,
              title: "Divider Information",

              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}