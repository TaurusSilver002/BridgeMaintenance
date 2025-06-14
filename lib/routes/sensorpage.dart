import 'package:flutter/material.dart';

class SensorsPage extends StatefulWidget {
  const SensorsPage({super.key});

  @override
  State<SensorsPage> createState() => _SensorsPageState();
}

class _SensorsPageState extends State<SensorsPage> {
  final List<Map<String, dynamic>> _sensors = [
    {'name': 'MOD001', 'isOn': false},
  ];

  final TextEditingController _sensorController = TextEditingController();

  void _addSensor() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add Sensor'),
          content: TextField(
            controller: _sensorController,
            decoration: const InputDecoration(hintText: 'Enter sensor name'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                _sensorController.clear();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                if (_sensorController.text.isNotEmpty) {
                  setState(() {
                    _sensors.add({
                      'name': _sensorController.text,
                      'isOn': false,
                    });
                  });
                  _sensorController.clear();
                  Navigator.pop(context);
                }
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }

  void _toggleSensor(int index) {
    setState(() {
      _sensors[index]['isOn'] = !_sensors[index]['isOn'];
    });
  }

  @override
  void dispose() {
    _sensorController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sensors')),
      body: ListView.builder(
        itemCount: _sensors.length,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.all(8.0),
            child: ListTile(
              title: Text(_sensors[index]['name']),
              trailing: Switch(
                value: _sensors[index]['isOn'],
                onChanged: (value) => _toggleSensor(index),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addSensor,
        child: const Icon(Icons.add),
      ),
    );
  }
}
