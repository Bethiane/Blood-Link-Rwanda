import 'package:flutter/material.dart';
import '../models/donor_model.dart';
import '../widgets/custom_button.dart';
import 'main_app_screen.dart';

class ResultsScreen extends StatelessWidget {
  final Donor? donor;

  const ResultsScreen({super.key, required this.donor});

  @override
  Widget build(BuildContext context) {
    final isSuccess = donor != null;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Information'),
        backgroundColor: Colors.red[700],
        foregroundColor: Colors.white,
        automaticallyImplyLeading: false, // Add this to remove back button
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (isSuccess) ...[
              _buildInfoCard(),
              const SizedBox(height: 30),
              _buildAdditionalInfo(),
            ] else ...[
              const Icon(
                Icons.error_outline,
                size: 80,
                color: Colors.red,
              ),
              const SizedBox(height: 20),
              const Text(
                'Record Not Found',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'We couldn\'t find a donor record with the provided ID. '
                    'Please check your Donation ID and try again.',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[700],
                  height: 1.5,
                ),
              ),
            ],
            const SizedBox(height: 40),
            if (isSuccess)
              CustomButton(
                text: 'Continue',
                onPressed: () {
                  // Navigate to main app screen
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const MainAppScreen(),
                    ),
                        (route) => false, // Remove all previous routes
                  );

                  // Optional: Show welcome message
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Welcome to BloodLink Rwanda!'),
                      backgroundColor: Colors.green,
                    ),
                  );
                },
              )
            else
              Row(
                children: [
                  Expanded(
                    child: CustomButton(
                      text: 'Try Again',
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        // Navigate to manual registration
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const MainAppScreen(), // Temporary - replace with registration screen
                          ),
                        );
                      },
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        side: const BorderSide(color: Colors.grey),
                      ),
                      child: const Text(
                        'Register Manually',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey,
                        ),
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

  Widget _buildInfoCard() {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Your ID',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
                Icon(Icons.verified, color: Colors.green[700]),
              ],
            ),
            const SizedBox(height: 5),
            Text(
              donor!.id,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            const Divider(height: 30),
            _buildInfoRow('Full Name', donor!.fullName),
            _buildInfoRow('Blood Type', donor!.bloodType),
            _buildInfoRow('Last Donation Date', donor!.lastDonationDate),
            _buildInfoRow('Deferral Status', donor!.deferralStatus),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              label,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[700],
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
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

  Widget _buildAdditionalInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Additional Information',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 15),
        _buildInfoRow('Phone Number', donor!.phoneNumber),
        _buildInfoRow('Email', donor!.email),
        _buildInfoRow('Location', donor!.location),
        _buildInfoRow('Total Donations', donor!.totalDonations.toString()),
        _buildInfoRow('Last Donation Center', donor!.lastDonationCenter),
      ],
    );
  }
}