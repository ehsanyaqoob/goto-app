import 'package:flutter/material.dart';

class StudyPlansScreen extends StatelessWidget {
  const StudyPlansScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Personal Plans'),
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