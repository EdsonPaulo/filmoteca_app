import 'package:flutter/material.dart';

enum ToastType { success, danger, info }

void showToast({
  required BuildContext context,
  required String message,
  ToastType? type,
}) {
  Color backgroundColor;

  switch (type) {
    case ToastType.success:
      backgroundColor = Colors.greenAccent;
      break;
    case ToastType.danger:
      backgroundColor = Colors.redAccent;
      break;
    case ToastType.info:
      backgroundColor = Colors.blueAccent;
      break;
    default:
      backgroundColor = Colors.black54;
  }

  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      duration: const Duration(seconds: 2),
      backgroundColor: backgroundColor,
    ),
  );
}
