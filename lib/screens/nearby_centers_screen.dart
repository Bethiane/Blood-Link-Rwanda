import 'package:flutter/material.dart';
import '../models/donation_center_model.dart';
import '../services/database_service.dart';

class NearbyCentersScreen extends StatefulWidget {
  const NearbyCentersScreen({super.key});

  @override
  State<NearbyCentersScreen> createState() => _NearbyCentersScreenState();
}

class _NearbyCentersScreenState extends State<NearbyCentersScreen> {
  List<DonationCenter> _centers = [];
  bool _isLoading = true;
  String _selectedCity = 'Kigali';

  @override
  void initState() {
    super.initState();
    _loadCenters();
  }

  Future<void> _loadCenters() async {
    // For now, use mock data since we removed database calls
    // Replace with actual database calls later
    setState(() {
      _centers = [
        DonationCenter(
          id: '1',
          name: 'RBC City Center',
          address: 'KN 3 Ave, Kigali',
          city: 'Kigali',
          phoneNumber: '+250788123456',
          email: 'rbc@example.com',
          workingHours: 'Mon-Fri: 8AM-5PM',
          latitude: -1.9575,
          longitude: 30.0647,
          createdAt: DateTime.now(),
        ),
        DonationCenter(
          id: '2',
          name: 'King Faisal Hospital',
          address: 'KK 15 Rd, Kigali',
          city: 'Kigali',
          phoneNumber: '+250788234567',
          email: 'kfh@example.com',
          workingHours: '24/7',
          latitude: -1.9441,
          longitude: 30.0619,
          createdAt: DateTime.now(),
        ),
        DonationCenter(
          id: '3',
          name: 'CHUK Hospital',
          address: 'KN 4 Ave, Kigali',
          city: 'Kigali',
          phoneNumber: '+250788345678',
          email: 'chuk@example.com',
          workingHours: 'Mon-Sun: 7AM-7PM',
          latitude: -1.9497,
          longitude: 30.0588,
          createdAt: DateTime.now(),
        ),
      ];
      _isLoading = false;
    });
  }

  void _callCenter(String phoneNumber) {
    // Show dialog instead of actually calling
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Call Center'),
        content: Text('Would you like to call $phoneNumber?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Calling $phoneNumber...'),
                  backgroundColor: Colors.green,
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red[700],
            ),
            child: const Text('Call'),
          ),
        ],
      ),
    );
  }

  void _openMaps(double lat, double lng) {
    // Show dialog instead of opening maps
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Get Directions'),
        content: const Text('Directions feature would open in Google Maps.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Opening directions...'),
                  backgroundColor: Colors.green,
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red[700],
            ),
            child: const Text('Open Maps'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nearby Centers'),
        backgroundColor: Colors.red[700],
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: DropdownButtonFormField<String>(
              value: _selectedCity,
              decoration: InputDecoration(
                labelText: 'Select City',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              items: const [
                DropdownMenuItem(value: 'Kigali', child: Text('Kigali')),
                DropdownMenuItem(value: 'Huye', child: Text('Huye')),
                DropdownMenuItem(value: 'Musanze', child: Text('Musanze')),
                DropdownMenuItem(value: 'Rubavu', child: Text('Rubavu')),
              ],
              onChanged: (value) {
                setState(() {
                  _selectedCity = value!;
                });
              },
            ),
          ),
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: _centers.length,
              itemBuilder: (context, index) {
                return _buildCenterCard(_centers[index]);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCenterCard(DonationCenter center) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    center.name,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.red[100],
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    center.city,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.red[700],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                const Icon(Icons.location_on, size: 16, color: Colors.grey),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    center.address,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.access_time, size: 16, color: Colors.grey),
                const SizedBox(width: 8),
                Text(
                  center.workingHours,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    icon: const Icon(Icons.phone, size: 18),
                    label: const Text('Call'),
                    onPressed: () => _callCenter(center.phoneNumber),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.red,
                      side: const BorderSide(color: Colors.red),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: OutlinedButton.icon(
                    icon: const Icon(Icons.directions, size: 18),
                    label: const Text('Directions'),
                    onPressed: () => _openMaps(center.latitude, center.longitude),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.red,
                      side: const BorderSide(color: Colors.red),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}