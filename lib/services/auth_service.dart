import 'dart:async';

class AuthService {
  static final AuthService _instance = AuthService._internal();
  factory AuthService() => _instance;
  AuthService._internal();

  Map<String, dynamic>? _currentUser;

  Map<String, dynamic>? get currentUser => _currentUser;
  bool get isLoggedIn => _currentUser != null;

  Future<bool> login(String email, String password) async {
    // Mock authentication - always returns true for testing
    await Future.delayed(const Duration(seconds: 1));

    _currentUser = {
      'id': '1999-011234567',
      'fullName': 'Rufatiro Aline',
      'bloodType': 'A+',
      'lastDonationDate': '30/07/2025',
      'deferralStatus': 'N/A',
      'phoneNumber': '0791476030',
      'email': email,
      'location': 'Nyarugenge, Kigali, Rwanda',
      'totalDonations': 204,
      'lastDonationCenter': 'RBC City Center',
    };

    return true;
  }

  Future<bool> register({
    required String email,
    required String password,
    required Map<String, dynamic> userData,
  }) async {
    // Mock registration - always returns true for testing
    await Future.delayed(const Duration(seconds: 1));

    _currentUser = {
      ...userData,
      'email': email,
      'id': '${DateTime.now().millisecondsSinceEpoch}',
    };

    return true;
  }

  Future<void> logout() async {
    _currentUser = null;
  }

  Future<void> updateUserProfile(Map<String, dynamic> donor) async {
    // Mock update
    await Future.delayed(const Duration(milliseconds: 500));
    _currentUser = donor;
  }

  Future<void> saveLoginState() async {
    // Save login state to shared preferences or secure storage
  }

  Future<void> loadLoginState() async {
    // Load login state from storage
  }
}