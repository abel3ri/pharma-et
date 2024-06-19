import 'package:flutter/material.dart';

class ErrorMessage {
  final String body;
  ErrorMessage({
    required this.body,
  });

  void showError(BuildContext context) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          body,
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                color: Colors.white,
              ),
        ),
        duration: Duration(seconds: 3),
        action: SnackBarAction(
          textColor: Colors.white,
          label: "OK",
          onPressed: () {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
          },
        ),
        padding: EdgeInsets.all(12),
        backgroundColor: Theme.of(context).colorScheme.error,
      ),
    );
  }
}