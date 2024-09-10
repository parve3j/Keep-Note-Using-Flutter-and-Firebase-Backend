import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppStyles {
  progressDialog(context) {
    showDialog(
        context: context,
        builder: (_) {
          return Dialog(
            elevation: 0,
            backgroundColor: Colors.transparent,
            child: Image.asset(
              'assets/files/loading.gif',
              height: 150,
            ),
          );
        });
  }

  GetSnackBar failedSnacBar(message)=> GetSnackBar(
    message: message,
    backgroundColor: Colors.redAccent,
    duration: const Duration(seconds: 3),
    icon: const Icon(Icons.warning, color: Colors.white,),
    snackPosition: SnackPosition.BOTTOM,
  );

  GetSnackBar successSnacBar(message)=> GetSnackBar(
    message: message,
    backgroundColor: Colors.teal,
    duration: const Duration(seconds: 3),
    icon: const Icon(Icons.done, color: Colors.white,),
    snackPosition: SnackPosition.BOTTOM,
  );

}