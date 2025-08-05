import 'package:flutter/material.dart';

extension SnackBarExtension on BuildContext {
  void showErrorSnackBar(String message, {double heightPosition = 16}) {
    ScaffoldMessenger.of(this).hideCurrentSnackBar();
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(Icons.error_outline, color: Theme.of(this).colorScheme.onError),
            const SizedBox(width: 12),
            Expanded(
              child: Text(message, style: TextStyle(color: Theme.of(this).colorScheme.onError, fontSize: 14)),
            ),
          ],
        ),
        backgroundColor: Theme.of(this).colorScheme.error,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        margin: EdgeInsets.symmetric(horizontal: 16, vertical: heightPosition),
        duration: const Duration(seconds: 4),
        action: SnackBarAction(
          label: 'OK',
          textColor: Theme.of(this).colorScheme.onError,
          onPressed: () {
            ScaffoldMessenger.of(this).hideCurrentSnackBar();
          },
        ),
      ),
    );
  }

  void showSuccessSnackBar(String message) {
    ScaffoldMessenger.of(this).hideCurrentSnackBar();
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(Icons.check_circle_outline, color: Theme.of(this).colorScheme.onSurface),
            const SizedBox(width: 12),
            Expanded(
              child: Text(message, style: TextStyle(color: Theme.of(this).colorScheme.onSurface, fontSize: 14)),
            ),
          ],
        ),
        backgroundColor: Theme.of(this).colorScheme.surface,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        margin: const EdgeInsets.all(16),
        duration: const Duration(seconds: 3),
      ),
    );
  }
}
