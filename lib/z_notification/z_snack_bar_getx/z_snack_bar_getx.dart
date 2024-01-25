import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void showSnackGetx(
  String? message, {
    String info = "Alerta", 

    IconData? icon,
    double? borderRadius = 10,
    bool? isDismissible = true,
    SnackPosition? snackPosition,
    Color? colorText = Colors.white,
    DismissDirection? dismissDirection = DismissDirection.down,
    Color? backgroundColor = const Color.fromARGB(178, 102, 112, 146), 
  }) { 
  Get.snackbar(
    info, 
    "",

    colorText: colorText,
    borderRadius: borderRadius,
    isDismissible: isDismissible,
    snackPosition: snackPosition,
    backgroundColor: backgroundColor,
    dismissDirection: dismissDirection,

    margin: const EdgeInsets.all(10.0),
    duration: const Duration(seconds: 4),

    icon: Icon(
      icon ?? Icons.info_outline,
      size: 28,
      color: Colors.white,
    ),

    messageText: Text(
      message ?? "Ops, tivemos um problema ao processar! ⚠️",
      style: GoogleFonts.roboto(
        fontSize: 16, 
        color: Colors.white, 
        fontWeight: FontWeight.w600,
      ),
    ),
  );
}
