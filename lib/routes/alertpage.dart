import 'package:flutter/material.dart';

class AlertsPage extends StatelessWidget {
  const AlertsPage({super.key});

  final Map<String, List<String>> alerts = const {
    'January 21, 2025': [
      'System overload warning',
      'Temperature threshold exceeded',
      'Unauthorized access detected',
      'Network latency high',
      'Scheduled maintenance due',
    ],
    'January 20, 2025': [
      'Battery level critical',
    ],
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Alerts')),
      body: ListView.builder(
        itemCount: alerts.length,
        itemBuilder: (context, index) {
          String date = alerts.keys.elementAt(index);
          List<String> dailyAlerts = alerts[date]!;

          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              elevation: 3,
              child: ExpansionTile(
                title: Text(
                  date,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                children: dailyAlerts.map((alert) {
                  return ListTile(
                    leading: const Icon(Icons.warning, color: Colors.red),
                    title: Text(alert),
                  );
                }).toList(),
              ),
            ),
          );
        },
      ),
    );
  }
}
