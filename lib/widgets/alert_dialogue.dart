import 'package:flutter/material.dart';

class AlertDialogBox extends StatelessWidget {
  final String error;

  const AlertDialogBox({super.key, required this.error});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Error'),
      content: Text(error),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.pushNamedAndRemoveUntil(
                  context, '/login', (route) => false);
            },
            child: const Text('Go to login page')),
        TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Ok')),
      ],
    );
  }
}
