import 'package:flutter/material.dart';

class TermsScreen extends StatelessWidget {
  const TermsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Terms & Conditions'),
        backgroundColor: Colors.red[700],
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '1. Acceptance of Terms',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'By accessing or using BloodLink Rwanda, you agree to comply '
                  'with and be bound by these Terms & Conditions, our Privacy '
                  'Policy, and any additional guidelines we provide.\n\n'
                  'If you do not agree, please do not use the app.',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[700],
                height: 1.6,
              ),
            ),
            const SizedBox(height: 30),
            const Text(
              '2. Purpose of the App',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'BloodLink Rwanda is a digital platform designed to:\n'
                  '• Connect voluntary blood donors with registered donation centers.\n'
                  '• Provide real-time alerts when specific blood types are urgently needed.\n'
                  '• Display nearby donation centers and opening times.\n'
                  '• Track donor eligibility and donation intervals.\n'
                  '• Sync donor information with the Rwanda Biomedical Centre (RBC) when applicable.\n'
                  '• BloodLink does not replace medical advice or professional healthcare.',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[700],
                height: 1.6,
              ),
            ),
            const SizedBox(height: 30),
            const Text(
              '3. User Responsibilities',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              '• Provide accurate and truthful information\n'
                  '• Maintain confidentiality of your account\n'
                  '• Report any security breaches immediately\n'
                  '• Use the app only for its intended purposes\n'
                  '• Comply with all applicable laws and regulations',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[700],
                height: 1.6,
              ),
            ),
            const SizedBox(height: 30),
            const Text(
              '4. Privacy and Data Protection',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'We are committed to protecting your privacy. All personal '
                  'and health information is stored securely and used only for '
                  'the purpose of facilitating blood donations. Your data is '
                  'never shared with third parties without your explicit consent.',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[700],
                height: 1.6,
              ),
            ),
          ],
        ),
      ),
    );
  }
}