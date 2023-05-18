library zezis_widget;

import 'package:flutter/material.dart';

class ZLoadingSimple extends StatelessWidget {
  final String image;

  final ThemeData? theme;
  final ThemeMode? themeMode;
  final Color? backgroundColor;

  const ZLoadingSimple({
    super.key,
    
    required this.image,

    this.theme,
    this.themeMode,
    this.backgroundColor,
  });

  @override 
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      /// Theme System
      theme: theme ?? ThemeData(),
      themeMode: themeMode ?? ThemeMode.system,

      home: Scaffold(
        backgroundColor: theme == null && backgroundColor == null 
          ? theme?.scaffoldBackgroundColor 
          : backgroundColor,
        body: Center(
          child: Image.asset(image),
        ),
      ),
    );
  }
}