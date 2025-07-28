import 'package:flutter/material.dart';

class WorkPlansScreen extends StatelessWidget {
  const WorkPlansScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Work Plans'),
      ),
      body: Center(
        child: Text(
          'Your personal plans will appear here.',
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
    );
  }
}