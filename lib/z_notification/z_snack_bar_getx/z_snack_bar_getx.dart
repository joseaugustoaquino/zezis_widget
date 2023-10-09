import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

showSnackGetx(String? message, {String? info, SnackPosition? snackPosition}){
  Get.snackbar(info ?? "Alerta", "",
    messageText: Text(
      message ?? "Ops, tivemos um problema ao processar.",
      style: GoogleFonts.roboto(
        color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600
      ),
    ),

    backgroundColor: const Color.fromARGB(178, 102, 112, 146),
    icon: const Icon(
      Icons.info_outline,
      size: 28,
      color: Colors.white,
    ),

    duration: const Duration(seconds: 4),
    colorText: Colors.white,
    dismissDirection: DismissDirection.down,
    snackPosition: (snackPosition ?? (GetPlatform.isWeb ? SnackPosition.TOP : SnackPosition.BOTTOM)),
    margin: const EdgeInsets.all(10.0),
    borderRadius: 10,
    isDismissible: true
  );
}
