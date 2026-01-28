import 'package:flutter/material.dart';
import 'verify_record_1.dart';
import 'login_screen.dart';
import '../widgets/custom_button.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BloodLink Rwanda'),
        backgroundColor: Colors.red[700],
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Icon(
              Icons.bloodtype,
              size: 100,
              color: Colors.red,
            ),
            const SizedBox(height: 30),
            const Text(
              'Welcome to\nBloodLink Rwanda',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Choose Your Path to continue using\nBloodLink Rwanda',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[700],
              ),
            ),
            const SizedBox(height: 50),
            CustomButton(
              text: 'Verify Your Record',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const VerifyRecord1Screen()),
                );
              },
            ),
            const SizedBox(height: 20),
            // TextButton(
            //   onPressed: () {
            //     Navigator.push(
            //       context,
            //       MaterialPageRoute(builder: (context) => LoginScreen()),
            //     );
            //   },
            //   // child: const Text(
            //   //   'Already have an account? Login',
            //   //   style: TextStyle(
            //   //     fontSize: 16,
            //   //     color: Colors.red,
            //   //   ),
            //   // ),
            // ),
          ],
        ),
      ),
    );
  }
}