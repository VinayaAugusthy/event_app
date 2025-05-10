import 'package:flutter/material.dart';

void showSnackbar({required var msg, required BuildContext ctx}) {
  ScaffoldMessenger.of(ctx).showSnackBar(
    SnackBar(
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.red,
      margin: const EdgeInsets.all(12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      content: Text(msg),
    ),
  );
}
