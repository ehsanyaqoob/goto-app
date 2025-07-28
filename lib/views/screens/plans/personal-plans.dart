import 'package:flutter/material.dart';

class PersonalPlansScreen extends StatelessWidget {
  const PersonalPlansScreen({Key? key}) : super(key: key);

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