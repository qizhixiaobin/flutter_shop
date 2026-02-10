import 'package:flutter/material.dart';

class Toastutils {
  static void show(BuildContext context, String? msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        width: 120,
        behavior: SnackBarBehavior.floating,
        duration: Duration(seconds: 3),
        content: Text(msg ?? '',textAlign: TextAlign.center,)
      ),
    );
  }
}