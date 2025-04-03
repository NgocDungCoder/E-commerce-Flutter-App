import 'package:flutter/material.dart';

class CustomAlertDialog extends StatelessWidget {
  final String title;
  final String message;
  final VoidCallback onConfirm;
  final VoidCallback onCancel;
  final String confirmText;
  final String cancelText;

  const CustomAlertDialog({
    Key? key,
    required this.title,
    required this.message,
    required this.onConfirm,
    required this.onCancel,
    this.confirmText = "Xác nhận",
    this.cancelText = "Hủy",
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
      content: Text(message),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      actions: [
        TextButton(
          onPressed: onCancel,
          child: Text(cancelText, style: TextStyle(color: Colors.grey)),
        ),
        ElevatedButton(
          onPressed: onConfirm,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.redAccent,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
          child: Text(confirmText, style: TextStyle(color: Colors.white),),
        ),
      ],
    );
  }
}
