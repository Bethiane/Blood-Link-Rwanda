import 'package:flutter/material.dart';
import '../utils/blood_compatibility.dart';
import 'requests_screen.dart';

class HomeScreen extends StatelessWidget {
  final String userBloodType;

  const HomeScreen({super.key, required this.userBloodType});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BloodLink Home'),
        backgroundColor: const Color(0xFFD32F2F),
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Aline',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          'Blood Type: $userBloodType',
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(height: 5),
                        const Text(
                          'Eligible in: 25 days',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.green,
                          ),
                        ),
                      ],
                    ),
                    CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.red[100],
                      child: const Icon(
                        Icons.person,
                        size: 40,
                        color: Color(0xFFD32F2F),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Give Life, Stay Connected',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Your Menu',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 15),
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              crossAxisSpacing: 15,
              mainAxisSpacing: 15,
              childAspectRatio: 1.5,
              children: [
                _buildMenuCard(
                  title: 'Blood Group',
                  value: userBloodType,
                  icon: Icons.bloodtype,
                  color: _getBloodTypeColor(userBloodType), // FIXED HERE
                ),
                _buildMenuCard(
                  title: 'My Donations',
                  value: '204',
                  icon: Icons.history,
                  color: Colors.blue,
                ),
                _buildMenuCard(
                  title: 'Active Alerts',
                  value: '04',
                  icon: Icons.notifications_active,
                  color: Colors.orange,
                ),
                _buildMenuCard(
                  title: 'Don. Centers',
                  value: '56',
                  icon: Icons.location_on,
                  color: Colors.green,
                ),
              ],
            ),
            const SizedBox(height: 30),
            _buildCompatibleRequests(context),
          ],
        ),
      ),
    );
  }

  // ADD THIS HELPER METHOD:
  Color _getBloodTypeColor(String bloodType) {
    switch (bloodType) {
      case 'A+': return const Color(0xFF1976D2);
      case 'A-': return const Color(0xFF64B5F6);
      case 'B+': return const Color(0xFF388E3C);
      case 'B-': return const Color(0xFF81C784);
      case 'AB+': return const Color(0xFF7B1FA2);
      case 'AB-': return const Color(0xFFBA68C8);
      case 'O+': return const Color(0xFFF57C00);
      case 'O-': return const Color(0xFFFFB74D);
      default: return Colors.grey;
    }
  }

  Widget _buildMenuCard({
    required String title,
    required String value,
    required IconData icon,
    required Color color,
  }) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: color, size: 32),
            const SizedBox(height: 10),
            Text(
              title,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
              ),
            ),
            Text(
              value,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCompatibleRequests(BuildContext context) {
    // Mock compatible requests
    final compatibleRequests = [
      {
        'title': 'Emergency B+ Blood Needed',
        'bloodType': 'B+',
        'location': 'RBC Center, Kigali',
        'date': '12/10/2025',
        'compatible': BloodCompatibility.canDonate(userBloodType, 'B+'),
      },
      {
        'title': 'A+ Blood Required',
        'bloodType': 'A+',
        'location': 'King Faisal Hospital',
        'date': '15/10/2025',
        'compatible': BloodCompatibility.canDonate(userBloodType, 'A+'),
      },
    ].where((request) => request['compatible'] == true).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Compatible Requests',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => RequestsScreen(userBloodType: userBloodType),
                  ),
                );
              },
              child: const Text(
                'View all',
                style: TextStyle(
                  fontSize: 14,
                  color: Color(0xFFD32F2F),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 15),
        ...compatibleRequests.map((request) => _buildRequestCard(context, request)),
      ],
    );
  }

  Widget _buildRequestCard(BuildContext context, Map<String, dynamic> request) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              request['title'],
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              request['location'],
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 8),
            Text(
              request['date'],
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 15),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Handle donation
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFD32F2F),
                  foregroundColor: Colors.white,
                ),
                child: const Text('Donate Now'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}