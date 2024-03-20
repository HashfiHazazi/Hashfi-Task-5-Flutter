import 'package:flutter/material.dart';

class NotFoundPage extends StatelessWidget {
  const NotFoundPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const CircularProgressIndicator(),
          Text(
            'Exception: Not found page!',
            style: Theme.of(context)
                .textTheme
                .headlineLarge!
                .copyWith(color: Colors.red),
          )
        ],
      ),
    );
  }
}
