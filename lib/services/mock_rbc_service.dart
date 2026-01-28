import 'dart:async';
import '../models/donor_model.dart';
import '../utils/constants.dart';
import 'database_service.dart';

class MockRBCService {
  static const Duration fetchDelay = Duration(seconds: 2);

  // Fetch donor by ID (from local database)
  static Future<Donor?> fetchDonorById(String donationId) async {
    await Future.delayed(fetchDelay);

    // Check local database first
    try {
      final dbService = DatabaseService.instance;
      final donorData = await dbService.getDonorById(donationId);

      if (donorData != null) {
        return Donor.fromJson(donorData);
      }
    } catch (e) {
      // If database fails, use mock data
      print('Database error: $e');
    }

    // Fallback to mock data if not in local DB
    if (AppConstants.mockDonors.containsKey(donationId)) {
      final donorData = AppConstants.mockDonors[donationId]!;
      return Donor.fromJson(donorData);
    }

    return null;
  }

  // Simulate validating donor record
  static Future<bool> validateDonorId(String donationId) async {
    await Future.delayed(const Duration(milliseconds: 500));

    // Rwanda ID pattern: YYYY-XXXXXXXXX
    final pattern = RegExp(r'^\d{4}-\d{9}$');
    return pattern.hasMatch(donationId);
  }
}