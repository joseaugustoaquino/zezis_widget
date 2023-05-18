library zezis_widget;

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:zezis_widget/z_loading/z_loading_custom/z_dot_color.dart';

class ZLoadingCustom extends StatefulWidget {
  final double radius;
  final double radiusDots;

  final ThemeData? theme;
  final ThemeMode? themeMode;
  final Color? backgroundColor;

  const ZLoadingCustom({
    super.key,
    
    this.radius = 3.0,
    this.radiusDots = 3.0,
    
    this.theme,
    this.themeMode,
    this.backgroundColor,
  });

  @override
  State<ZLoadingCustom> createState() => _ZLoadingCustomState();
}

class _ZLoadingCustomState extends State<ZLoadingCustom> with SingleTickerProviderStateMixin {
  late AnimationController animationController;

  Animation<double>? animationRotation;
  Animation<double>? animationRadiusIn;
  Animation<double>? animationRadiusOut;

  double radius = 3.0;
  double radiusDot = 3.0;

  @override
  void initState() {
    radius = widget.radius;
    radiusDot = widget.radiusDots;

    animationController = AnimationController(
      lowerBound: 0.0,
      upperBound: 1.0,
      duration: const Duration(milliseconds: 3000),
      vsync: this
    );

    animationRotation = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: animationController,
        curve: const Interval(0.0, 1.0, curve: Curves.linear),
      ),
    );

    animationRadiusIn = Tween(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(
        parent: animationController,
        curve: const Interval(0.75, 1.0, curve: Curves.elasticIn),
      ),
    );

    animationRadiusOut = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: animationController,
        curve: const Interval(0.0, 0.25, curve: Curves.elasticOut),
      ),
    );

    animationController.addListener(() {
      setState(() {
        if (animationController.value >= 0.75 && animationController.value <= 1.0) {
          radius = widget.radius * animationRadiusIn!.value;
        } else if (animationController.value >= 0.0 && animationController.value <= 0.25) {
          radius = widget.radius * animationRadiusOut!.value;
        }
      });
    });

    animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {}
    });

    animationController.repeat();

    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (animationRotation == null) return Container();

    return MaterialApp(
      debugShowCheckedModeBanner: false,

      /// Theme System
      theme: widget.theme ?? ThemeData(),
      themeMode: widget.themeMode ?? ThemeMode.system,

      home: Scaffold(
        backgroundColor: const Color(0xFFF0F0F0),
    
        body: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Center(
            child: RotationTransition(
              turns: animationRotation!,
              child: Center(
                child: Stack(
                  children: [
                    Transform.translate(
                      offset: const Offset(0.0, 0.0),
                      child: DotColor(
                        radius: radius,
                        color: Colors.black12,
                      ),
                    ),
                    Transform.translate(
                      offset: Offset(
                        radius * cos(0.0),
                        radius * sin(0.0),
                      ),
                      child: DotColor(
                        radius: radiusDot,
                        color: Colors.amber,
                      ),
                    ),
                    Transform.translate(
                      offset: Offset(
                        radius * cos(0.0 + 1 * pi / 4),
                        radius * sin(0.0 + 1 * pi / 4),
                      ),
                      child: DotColor(
                        radius: radiusDot,
                        color: Colors.deepOrangeAccent,
                      ),
                    ),
                    Transform.translate(
                      offset: Offset(
                        radius * cos(0.0 + 2 * pi / 4),
                        radius * sin(0.0 + 2 * pi / 4),
                      ),
                      child: DotColor(
                        radius: radiusDot,
                        color: Colors.pinkAccent,
                      ),
                    ),
                    Transform.translate(
                      offset: Offset(
                        radius * cos(0.0 + 3 * pi / 4),
                        radius * sin(0.0 + 3 * pi / 4),
                      ),
                      child: DotColor(
                        radius: radiusDot,
                        color: Colors.purple,
                      ),
                    ),
                    Transform.translate(
                      offset: Offset(
                        radius * cos(0.0 + 4 * pi / 4),
                        radius * sin(0.0 + 4 * pi / 4),
                      ),
                      child: DotColor(
                        radius: radiusDot,
                        color: Colors.yellow,
                      ),
                    ),
                    Transform.translate(
                      offset: Offset(
                        radius * cos(0.0 + 5 * pi / 4),
                        radius * sin(0.0 + 5 * pi / 4),
                      ),
                      child: DotColor(
                        radius: radiusDot,
                        color: Colors.lightGreen,
                      ),
                    ),
                    Transform.translate(
                      offset: Offset(
                        radius * cos(0.0 + 6 * pi / 4),
                        radius * sin(0.0 + 6 * pi / 4),
                      ),
                      child: DotColor(
                        radius: radiusDot,
                        color: Colors.orangeAccent,
                      ),
                    ),
                    Transform.translate(
                      offset: Offset(
                        radius * cos(0.0 + 7 * pi / 4),
                        radius * sin(0.0 + 7 * pi / 4),
                      ),
                      child: DotColor(
                        radius: radiusDot,
                        color: Colors.blueAccent,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}