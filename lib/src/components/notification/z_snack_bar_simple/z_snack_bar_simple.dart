import 'package:flutter/material.dart';
import 'package:get/get.dart';

void showSnackBar(
  String? message, {
  String? title,

  Widget? icon,
  Widget? titleText,
  Widget? mainButton,
  Widget? messageText,
  
  bool instantInit = true,
  bool isDismissible = true,
  bool shouldIconPulse = true, 
  bool showProgressIndicator = false,

  double barBlur = 0.0,
  double? maxWidth = 250,
  double overlayBlur = 0.0,
  double borderWidth = 1.0,
  double borderRadius = 15,
  
  EdgeInsets margin = const EdgeInsets.all(0.0),
  EdgeInsets padding = const EdgeInsets.all(16),
  
  Color? borderColor,
  Color? overlayColor,
  Color? leftBarIndicatorColor, 
  Color? progressIndicatorBackgroundColor,
  Animation<Color>? progressIndicatorValueColor,
  Color backgroundColor = const Color(0xFF303030),

  Curve forwardAnimationCurve = Curves.easeOutCirc,
  Curve reverseAnimationCurve = Curves.easeOutCirc,
  
  Duration? duration = const Duration(seconds: 2),
  Duration animationDuration = const Duration(seconds: 1),

  OnTap? onTap,
  Form? userInputForm,
  List<BoxShadow>? boxShadows,
  Gradient? backgroundGradient,
  DismissDirection? dismissDirection,
  SnackbarStatusCallback? snackbarStatus,
  SnackStyle snackStyle = SnackStyle.FLOATING,
  AnimationController? progressIndicatorController,
  SnackPosition snackPosition = SnackPosition.BOTTOM,
}) {
  Get.rawSnackbar(
    title: title ?? "",
    message: message ?? "",

    icon: icon,
    titleText: titleText,
    mainButton: mainButton,
    messageText: messageText,

    instantInit: instantInit,
    isDismissible: isDismissible,
    shouldIconPulse: shouldIconPulse,
    showProgressIndicator: showProgressIndicator,

    barBlur: barBlur,
    maxWidth: maxWidth,
    overlayBlur: overlayBlur,
    borderWidth: borderWidth,
    borderRadius: borderRadius,

    margin: margin,
    padding: padding,

    borderColor: borderColor,
    overlayColor: overlayColor,
    leftBarIndicatorColor: leftBarIndicatorColor,
    progressIndicatorBackgroundColor: progressIndicatorBackgroundColor,
    progressIndicatorValueColor: progressIndicatorValueColor,
    backgroundColor: backgroundColor,

    forwardAnimationCurve: forwardAnimationCurve,
    reverseAnimationCurve: reverseAnimationCurve,

    duration: duration,
    animationDuration: animationDuration,

    onTap: onTap,
    userInputForm: userInputForm,
    boxShadows: boxShadows,
    backgroundGradient: backgroundGradient,
    dismissDirection: dismissDirection,
    snackbarStatus: snackbarStatus,
    snackStyle: snackStyle,
    progressIndicatorController: progressIndicatorController,
    snackPosition: snackPosition,
  );
}