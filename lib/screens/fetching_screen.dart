import 'package:flutter/material.dart';
import 'results_screen.dart';
import '../services/mock_rbc_service.dart';

class FetchingScreen extends StatefulWidget {
  final String donationId;

  const FetchingScreen({super.key, required this.donationId});

  @override
  State<FetchingScreen> createState() => _FetchingScreenState();
}

class _FetchingScreenState extends State<FetchingScreen> {
  double _progress = 0.0;
  bool _isComplete = false;

  @override
  void initState() {
    super.initState();
    _fetchDonorData();
  }

  void _fetchDonorData() async {
    // Simulate progress
    const totalSteps = 10;
    for (int i = 0; i <= totalSteps; i++) {
      await Future.delayed(const Duration(milliseconds: 200));
      if (mounted) {
        setState(() {
          _progress = i / totalSteps;
        });
      }
    }

    // Fetch actual data
    final donor = await MockRBCService.fetchDonorById(widget.donationId);

    if (mounted) {
      setState(() {
        _isComplete = true;
      });

      // Navigate to results screen
      await Future.delayed(const Duration(milliseconds: 500));
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => ResultsScreen(donor: donor),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(40.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.bloodtype,
                size: 60,
                color: Colors.red,
              ),
              const SizedBox(height: 30),
              Text(
                '${(_progress * 100).toInt()}%',
                style: const TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Fetching your donor\nrecord from RBC...',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'This may take a few seconds. Please don\'t\nclose the app.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: 40),
              LinearProgressIndicator(
                value: _progress,
                backgroundColor: Colors.grey[200],
                color: Colors.red,
                minHeight: 12,
                borderRadius: BorderRadius.circular(6),
              ),
              const SizedBox(height: 20),
              if (_isComplete)
                const CircularProgressIndicator(
                  color: Colors.red,
                ),
            ],
          ),
        ),
      ),
    );
  }
}