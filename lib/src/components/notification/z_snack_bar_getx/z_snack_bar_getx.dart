import 'package:get/get.dart';
import 'package:flutter/material.dart';

void showSnackBarX(
  String? message, {
  String title = "Alerta",
  Duration? duration = const Duration(seconds: 3),
  
  IconData? icon,
  Widget? titleText,

  double? barBlur,
  double? maxWidth,
  double? overlayBlur,
  double? borderWidth,
  double? borderRadius = 10,

  bool? shouldIconPulse,
  bool instantInit = true,
  bool? isDismissible = true,
  bool? showProgressIndicator,

  Color? borderColor,
  Color? overlayColor,
  Color? leftBarIndicatorColor,
  Color? colorText = Colors.white,
  Color? progressIndicatorBackgroundColor,
  Animation<Color>? progressIndicatorValueColor,
  Color? backgroundColor = const Color.fromARGB(178, 102, 112, 146),

  EdgeInsets? margin = const EdgeInsets.all(10.0),
  EdgeInsets? padding,

  Curve? forwardAnimationCurve,
  Curve? reverseAnimationCurve,

  OnTap? onTap,
  Form? userInputForm,
  SnackStyle? snackStyle,
  TextButton? mainButton,
  List<BoxShadow>? boxShadows,
  Duration? animationDuration,
  SnackPosition? snackPosition,
  Gradient? backgroundGradient,
  SnackbarStatusCallback? snackbarStatus,
  AnimationController? progressIndicatorController,
  DismissDirection? dismissDirection = DismissDirection.down,
}) { 
  Get.snackbar(
    title, 
    "",

    duration: duration,

    icon: Icon(
      icon ?? Icons.info_outline,
      size: 28,
      color: Colors.white,
    ),
    
    titleText: titleText,
    messageText: Text(
      message ?? "",
      style: const TextStyle(
        fontSize: 16, 
        color: Colors.white, 
        fontWeight: FontWeight.w600,
      ),
    ),

    barBlur: barBlur,
    maxWidth: maxWidth,
    overlayBlur: overlayBlur,
    borderWidth: borderWidth,
    borderRadius: borderRadius,

    shouldIconPulse: shouldIconPulse,
    instantInit: instantInit,
    isDismissible: isDismissible,
    showProgressIndicator: showProgressIndicator,

    borderColor: borderColor,
    overlayColor: overlayColor,
    leftBarIndicatorColor: leftBarIndicatorColor,
    colorText: colorText,
    progressIndicatorBackgroundColor: progressIndicatorBackgroundColor,
    progressIndicatorValueColor: progressIndicatorValueColor,
    backgroundColor: backgroundColor,

    margin: margin,
    padding: padding,

    forwardAnimationCurve: forwardAnimationCurve,
    reverseAnimationCurve: reverseAnimationCurve,

    onTap: onTap,
    userInputForm: userInputForm,
    snackStyle: snackStyle,
    mainButton: mainButton,
    boxShadows: boxShadows,
    animationDuration: animationDuration,
    snackPosition: snackPosition,
    backgroundGradient: backgroundGradient,
    snackbarStatus: snackbarStatus,
    progressIndicatorController: progressIndicatorController,
    dismissDirection: dismissDirection,
  );
}
