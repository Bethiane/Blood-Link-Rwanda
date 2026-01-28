import 'package:flutter/material.dart';
import 'verify_record_2.dart';
import '../widgets/custom_button.dart';
import '../services/mock_rbc_service.dart';

class VerifyRecord1Screen extends StatefulWidget {
  const VerifyRecord1Screen({super.key});

  @override
  State<VerifyRecord1Screen> createState() => _VerifyRecord1ScreenState();
}

class _VerifyRecord1ScreenState extends State<VerifyRecord1Screen> {
  final TextEditingController _idController = TextEditingController();
  bool _isLoading = false;
  String? _errorMessage;

  void _validateAndProceed() async {
    final donationId = _idController.text.trim();

    if (donationId.isEmpty) {
      setState(() {
        _errorMessage = 'Please enter your Donation ID';
      });
      return;
    }

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    final isValid = await MockRBCService.validateDonorId(donationId);

    setState(() {
      _isLoading = false;
    });

    if (isValid) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => VerifyRecord2Screen(donationId: donationId),
        ),
      );
    } else {
      setState(() {
        _errorMessage = 'Invalid Donation ID format. Please check and try again.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Verify Your Donor Record'),
        backgroundColor: Colors.red[700],
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Enter your Donation ID so we can securely check if your '
                  'blood donation record already exists with the Rwanda '
                  'Biomedical Centre (RBC).',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[700],
                height: 1.5,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'This helps us prefill your profile automatically and keep '
                  'your donation history accurate.',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[700],
                height: 1.5,
              ),
            ),
            const SizedBox(height: 40),
            const Text(
              'Donation ID',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _idController,
              decoration: InputDecoration(
                hintText: 'Enter your blood donation ID',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Colors.red),
                ),
                errorText: _errorMessage,
                suffixIcon: const Icon(Icons.credit_card),
              ),
              keyboardType: TextInputType.text,
            ),
            const SizedBox(height: 10),
            Text(
              "Format: 1999-011234567",
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 30),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey[200]!), // Add ! operator
              ),
              child: Row(
                children: [
                  Icon(Icons.security, color: Colors.green[700]),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      "We'll securely connect to RBC to fetch your donor information.",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[700],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(),
            if (_isLoading)
              const Center(
                child: CircularProgressIndicator(),
              )
            else
              CustomButton(
                text: 'Continue',
                onPressed: _validateAndProceed,
              ),
          ],
        ),
      ),
    );
  }
}