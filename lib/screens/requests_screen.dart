import 'package:flutter/material.dart';
import '../utils/blood_compatibility.dart';

class RequestsScreen extends StatefulWidget {
  final String userBloodType;

  const RequestsScreen({super.key, required this.userBloodType});

  @override
  State<RequestsScreen> createState() => _RequestsScreenState();
}

class _RequestsScreenState extends State<RequestsScreen> {
  List<Map<String, dynamic>> _allRequests = [];
  List<Map<String, dynamic>> _filteredRequests = [];
  bool _isLoading = false;
  String _filterType = 'compatible';

  @override
  void initState() {
    super.initState();
    // Load requests immediately (no database delay)
    _allRequests = _getSampleRequests();
    _applyFilter(widget.userBloodType);
  }

  List<Map<String, dynamic>> _getSampleRequests() {
    return [
      {
        'id': '1',
        'title': 'Emergency B+ Blood Needed',
        'description': 'Urgent need for B+ blood for emergency surgery at King Faisal Hospital',
        'bloodType': 'B+',
        'quantity': '2 units',
        'urgency': 'Critical',
        'hospital': 'King Faisal Hospital',
        'location': 'Kigali',
        'date': '12/10/2025',
      },
      {
        'id': '2',
        'title': 'Emergency O- Blood Needed',
        'description': 'Critical need for O- blood for accident victim at CHUK',
        'bloodType': 'O-',
        'quantity': '3 units',
        'urgency': 'Critical',
        'hospital': 'CHUK',
        'location': 'Kigali',
        'date': '15/10/2025',
      },
      {
        'id': '3',
        'title': 'A+ Blood Required',
        'description': 'Blood needed for cancer patient treatment at Kibagabaga Hospital',
        'bloodType': 'A+',
        'quantity': '1 unit',
        'urgency': 'High',
        'hospital': 'Kibagabaga Hospital',
        'location': 'Kigali',
        'date': '18/10/2025',
      },
      {
        'id': '4',
        'title': 'AB+ Blood Needed',
        'description': 'Rare blood type needed for surgery at King Faisal Hospital',
        'bloodType': 'AB+',
        'quantity': '2 units',
        'urgency': 'Medium',
        'hospital': 'King Faisal Hospital',
        'location': 'Kigali',
        'date': '20/10/2025',
      },
    ];
  }

  void _applyFilter(String userBloodType) {
    List<Map<String, dynamic>> filtered = [];

    switch (_filterType) {
      case 'all':
        filtered = List.from(_allRequests);
        break;
      case 'compatible':
        filtered = _allRequests.where((request) {
          final requestBloodType = request['bloodType'] ?? '';
          return BloodCompatibility.canDonate(userBloodType, requestBloodType);
        }).toList();
        break;
      case 'urgent':
        filtered = _allRequests.where((request) {
          final urgency = (request['urgency'] ?? '').toLowerCase();
          return urgency == 'critical' || urgency == 'urgent';
        }).toList();
        break;
    }

    // Sort by priority
    filtered.sort((a, b) {
      final priorityA = _getRequestPriority(userBloodType, a);
      final priorityB = _getRequestPriority(userBloodType, b);
      return priorityB.compareTo(priorityA);
    });

    setState(() {
      _filteredRequests = filtered;
    });
  }

  int _getRequestPriority(String userBloodType, Map<String, dynamic> request) {
    int priority = 0;
    final requestBloodType = request['bloodType'] ?? '';
    final urgency = (request['urgency'] ?? '').toLowerCase();

    if (BloodCompatibility.canDonate(userBloodType, requestBloodType)) {
      priority += 10;
    }

    if (urgency == 'critical') {
      priority += 5;
    } else if (urgency == 'urgent') {
      priority += 3;
    } else if (urgency == 'high') {
      priority += 1;
    }

    return priority;
  }

  void _showDonationConfirmation(BuildContext context, Map<String, dynamic> request) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirm Donation'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              request['title'] ?? '',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text('Blood Type: ${request['bloodType'] ?? ''}'),
            Text('Hospital: ${request['hospital'] ?? ''}'),
            Text('Urgency: ${request['urgency'] ?? ''}'),
            Text('Date: ${request['date'] ?? ''}'),
            const SizedBox(height: 15),
            const Text('Are you sure you want to volunteer for this blood donation?'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              _processDonation(request);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFD32F2F),
            ),
            child: const Text('Confirm Donation'),
          ),
        ],
      ),
    );
  }

  void _processDonation(Map<String, dynamic> request) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Thank you! You have volunteered for "${request['title']}"'),
        backgroundColor: Colors.green,
        duration: const Duration(seconds: 3),
        action: SnackBarAction(
          label: 'OK',
          textColor: Colors.white,
          onPressed: () {},
        ),
      ),
    );
  }

  // ADD THIS METHOD FOR REFRESH
  Future<void> _refreshRequests() async {
    // Simulate loading
    await Future.delayed(const Duration(seconds: 1));
    setState(() {
      // You could reload data here if using database
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Blood Requests'),
        backgroundColor: const Color(0xFFD32F2F),
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          // Filter buttons
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                _buildFilterButton('All', 'all'),
                const SizedBox(width: 10),
                _buildFilterButton('Compatible', 'compatible'),
                const SizedBox(width: 10),
                _buildFilterButton('Urgent', 'urgent'),
              ],
            ),
          ),

          // Blood type indicator
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.red[100],
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    'Your Blood Type: ${widget.userBloodType}',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.red[700],
                    ),
                  ),
                ),
                const Spacer(),
                Text(
                  '${_filteredRequests.length} requests',
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),

          // Search bar
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search requests...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                filled: true,
                fillColor: Colors.grey[100],
              ),
              onChanged: (value) {
                // Implement search functionality
                if (value.isEmpty) {
                  _applyFilter(widget.userBloodType);
                } else {
                  final filtered = _allRequests.where((request) {
                    final title = (request['title'] ?? '').toLowerCase();
                    final description = (request['description'] ?? '').toLowerCase();
                    final bloodType = (request['bloodType'] ?? '').toLowerCase();
                    final searchTerm = value.toLowerCase();

                    return title.contains(searchTerm) ||
                        description.contains(searchTerm) ||
                        bloodType.contains(searchTerm);
                  }).toList();

                  setState(() {
                    _filteredRequests = filtered;
                  });
                }
              },
            ),
          ),

          // Requests list
          Expanded(
            child: _filteredRequests.isEmpty
                ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.bloodtype, size: 80, color: Colors.grey),
                  const SizedBox(height: 20),
                  const Text(
                    'No matching requests found',
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Try changing the filter or check back later',
                    style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _filterType = 'all';
                      });
                      _applyFilter(widget.userBloodType);
                    },
                    child: const Text('Show All Requests'),
                  ),
                ],
              ),
            )
                : RefreshIndicator(
              onRefresh: _refreshRequests, // FIXED: Changed from _loadRequests to _refreshRequests
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: _filteredRequests.length,
                itemBuilder: (context, index) {
                  return _buildRequestCard(_filteredRequests[index]);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterButton(String text, String type) {
    final isSelected = _filterType == type;

    return GestureDetector(
      onTap: () {
        setState(() {
          _filterType = type;
        });
        _applyFilter(widget.userBloodType);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFD32F2F) : Colors.grey[200],
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: isSelected ? Colors.white : Colors.grey[700],
          ),
        ),
      ),
    );
  }

  Widget _buildRequestCard(Map<String, dynamic> request) {
    final requestBloodType = request['bloodType'] ?? '';
    final isCompatible = BloodCompatibility.canDonate(widget.userBloodType, requestBloodType);
    final urgency = request['urgency'] ?? '';

    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 2,
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
                    request['title'] ?? '',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                if (isCompatible)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.green[100],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.check_circle, size: 12, color: Colors.green),
                        const SizedBox(width: 4),
                        Text(
                          'Compatible',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Colors.green[800],
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: _getBloodTypeColor(requestBloodType),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    requestBloodType,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: _getUrgencyColor(urgency),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    urgency,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              request['description'] ?? '',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[700],
                height: 1.5,
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                const Icon(Icons.location_on, size: 16, color: Colors.grey),
                const SizedBox(width: 6),
                Text(
                  request['location'] ?? '',
                  style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                ),
                const Spacer(),
                const Icon(Icons.calendar_today, size: 16, color: Colors.grey),
                const SizedBox(width: 6),
                Text(
                  request['date'] ?? '',
                  style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                ),
              ],
            ),
            const SizedBox(height: 15),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: isCompatible ? () => _showDonationConfirmation(context, request) : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: isCompatible ? const Color(0xFFD32F2F) : Colors.grey[400],
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                child: Text(
                  isCompatible ? 'Donate Now' : 'Not Compatible',
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

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

  Color _getUrgencyColor(String urgency) {
    switch (urgency.toLowerCase()) {
      case 'critical': return Colors.red;
      case 'urgent': return Colors.orange;
      case 'high': return const Color(0xFFF57C00);
      default: return const Color(0xFF2196F3);
    }
  }
}