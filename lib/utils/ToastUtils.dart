import 'package:flutter/material.dart';

class Toastutils {
  static bool _isShowing = false;
  static void show(BuildContext context, String? msg) {
    if (_isShowing) return;
    _isShowing = true;
    Future.delayed(Duration(seconds: 3), () {
      _isShowing = false;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        width: 180,
        behavior: SnackBarBehavior.floating,
        duration: Duration(seconds: 3),
        content: Text(msg ?? '',textAlign: TextAlign.center,)
      ),
    );
  }
}