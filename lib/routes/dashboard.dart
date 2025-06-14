import 'package:bridge_maintenence/routes/alertpage.dart';
import 'package:bridge_maintenence/routes/maintenance.dart';
import 'package:bridge_maintenence/routes/sensorpage.dart';
import 'package:bridge_maintenence/routes/teampage.dart';
import 'package:flutter/material.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          ),
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: const Color(0xFFC8E6C9),
              ),
              child: Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Settings'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.notifications),
              title: const Text('Alerts'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          children: [
            _buildDashboardCard(
              title: 'Alerts',
              color: const Color(0xFFFFD1DC), // Pastel Pink
              icon: Icons.notification_important,
              onTap: () => _navigateTo(context, const AlertsPage()),
            ),
            _buildDashboardCard(
              title: 'Maintennance',
              color: const Color(0xFFB3E5FC), // Pastel Blue
              icon: Icons.build,
              onTap: () => _navigateTo(context, const MaintenanceDate()),
            ),
            _buildDashboardCard(
              title: 'Sensors',
              color: const Color(0xFFFFF9C4), // Pastel Yellow
              icon: Icons.sensors,
              onTap: () => _navigateTo(context, const SensorsPage()),
            ),
            _buildDashboardCard(
              title: 'Team',
              color: const Color(0xFFC8E6C9), // Pastel Green
              icon: Icons.group,
              onTap: () => _navigateTo(context, const TeamPage()),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDashboardCard({
    required String title,
    required Color color,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 4,
              offset: Offset(2, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 48, color: Colors.black87),
            const SizedBox(height: 10),
            Text(
              title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _navigateTo(BuildContext context, Widget page) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => page),
    );
  }
}




