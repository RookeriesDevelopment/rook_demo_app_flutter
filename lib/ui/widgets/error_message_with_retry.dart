import 'package:flutter/material.dart';

class ErrorMessageWithRetry extends StatelessWidget {
  final String error;
  final Function() retry;

  const ErrorMessageWithRetry({
    Key? key,
    required this.error,
    required this.retry,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Icon(Icons.error_rounded),
        const SizedBox(height: 10),
        Text('There was an error: $error'),
        const SizedBox(height: 20),
        TextButton(onPressed: retry, child: const Text('Retry')),
      ],
    );
  }
}
