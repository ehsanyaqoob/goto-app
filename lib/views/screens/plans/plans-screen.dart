import 'package:flutter/material.dart';

class PlansScreen extends StatelessWidget {
  final List<Map<String, String>> plans = [
    {
      'title': 'Basic',
      'description': 'Access to basic features',
      'price': '\$9.99/mo',
    },
    {
      'title': 'Pro',
      'description': 'All basic features plus advanced tools',
      'price': '\$19.99/mo',
    },
    {
      'title': 'Enterprise',
      'description': 'Full features for teams',
      'price': '\$49.99/mo',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Plans'),
      ),
      body: ListView.builder(
        itemCount: plans.length,
        itemBuilder: (context, index) {
          final plan = plans[index];
          return Card(
            margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ListTile(
              title: Text(plan['title']!, style: TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text(plan['description']!),
              trailing: Text(plan['price']!, style: TextStyle(fontSize: 16, color: Colors.green)),
              onTap: () {
                // Handle plan selection
              },
            ),
          );
        },
      ),
    );
  }
}