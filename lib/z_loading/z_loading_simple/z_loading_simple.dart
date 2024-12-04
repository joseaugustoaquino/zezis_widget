import 'package:flutter/material.dart';

class ZLoadingSimple extends StatelessWidget {
  final String image;

  final ThemeData? theme;
  final ThemeMode? themeMode;
  final Color? backgroundColor;
  final EdgeInsetsGeometry? padding; 

  const ZLoadingSimple({
    super.key,
    
    required this.image,

    this.theme,
    this.padding,
    this.themeMode,
    this.backgroundColor,
  });

  @override 
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: theme ?? ThemeData(),
      debugShowCheckedModeBanner: false,
      themeMode: themeMode ?? ThemeMode.system,

      home: Scaffold(
        backgroundColor: (theme == null && backgroundColor == null) ? theme?.scaffoldBackgroundColor : backgroundColor,

        body: Padding(
          padding: padding ?? const EdgeInsets.all(8.0),

          child: Center(
            child: Image.asset(image),
          ),
        ),
      ),
    );
  }
}