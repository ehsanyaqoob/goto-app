import 'package:flutter/material.dart';

class FamilyPlansScreen extends StatelessWidget {
  const FamilyPlansScreen({Key? key}) : super(key: key);

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