import 'package:flutter/material.dart';
import '../services/auth_service.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({super.key});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  final AuthService _authService = AuthService();
  bool _isEditing = false;
  late Map<String, dynamic> _donor;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _donor = _getDefaultDonor();
    _initializeControllers();
  }

  Map<String, dynamic> _getDefaultDonor() {
    return {
      'id': '1999-011234567',
      'fullName': 'Rufatiro Aline',
      'bloodType': 'A+',
      'lastDonationDate': '30/07/2025',
      'deferralStatus': 'N/A',
      'phoneNumber': '0791476030',
      'email': 'rufatiro@gmail.com',
      'location': 'Nyarugenge, Kigali, Rwanda',
      'totalDonations': 204,
      'lastDonationCenter': 'RBC City Center',
    };
  }

  void _initializeControllers() {
    _nameController.text = _donor['fullName'];
    _emailController.text = _donor['email'];
    _phoneController.text = _donor['phoneNumber'];
    _locationController.text = _donor['location'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        backgroundColor: Colors.red[700],
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: Icon(_isEditing ? Icons.save : Icons.edit),
            onPressed: _toggleEditMode,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 60,
                    backgroundColor: Colors.red[100],
                    child: const Icon(
                      Icons.person,
                      size: 80,
                      color: Colors.red,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    _donor['fullName'],
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Eligible in: 25 days',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.green[700],
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            _buildProfileSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildProfileItem('Age', '22', isEditable: false),
        _buildProfileItem('Gender', 'Female', isEditable: false),
        _buildProfileItem('City', _donor['location'], isEditable: _isEditing),
        _buildProfileItem('Country', 'Rwanda', isEditable: false),
        _buildProfileItem('Email', _emailController.text, isEditable: _isEditing),
        _buildProfileItem('Phone Number', _phoneController.text, isEditable: _isEditing),
        const SizedBox(height: 30),
        if (_isEditing)
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _saveProfile,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red[700],
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                'Save Changes',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildProfileItem(String label, String value, {bool isEditable = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          SizedBox(
            width: 120,
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.grey,
              ),
            ),
          ),
          Expanded(
            child: isEditable
                ? _buildEditableField(label, value)
                : Text(
              value,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEditableField(String label, String value) {
    TextEditingController controller;

    switch (label) {
      case 'Email':
        controller = _emailController;
        break;
      case 'Phone Number':
        controller = _phoneController;
        break;
      case 'City':
        controller = _locationController;
        break;
      default:
        controller = TextEditingController(text: value);
    }

    return TextField(
      controller: controller,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      ),
    );
  }

  void _toggleEditMode() {
    if (_isEditing) {
      _saveProfile();
    }
    setState(() {
      _isEditing = !_isEditing;
    });
  }

  void _saveProfile() {
    final updatedDonor = {
      ..._donor,
      'fullName': _nameController.text,
      'email': _emailController.text,
      'phoneNumber': _phoneController.text,
      'location': _locationController.text,
    };

    setState(() {
      _donor = updatedDonor;
    });

    // Comment out or fix the auth service call if it's causing issues
    // _authService.updateUserProfile(updatedDonor);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Profile updated successfully'),
        backgroundColor: Colors.green,
      ),
    );
  }
}