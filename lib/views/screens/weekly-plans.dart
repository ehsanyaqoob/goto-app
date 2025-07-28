import 'package:flutter/material.dart';

class WeeklyPlansScreen extends StatelessWidget {
  const WeeklyPlansScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weekly Plans'),
      ),
      body: ListView.builder(
        itemCount: 7,
        itemBuilder: (context, index) {
          final days = [
            'Monday',
            'Tuesday',
            'Wednesday',
            'Thursday',
            'Friday',
            'Saturday',
            'Sunday'
          ];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ListTile(
              leading: CircleAvatar(child: Text(days[index][0])),
              title: Text(days[index]),
              subtitle: const Text('No plans yet.'),
              trailing: IconButton(
                icon: const Icon(Icons.add),
                onPressed: () {
                  // Add plan logic here
                },
              ),
            ),
          );
        },
      ),
    );
  }
}