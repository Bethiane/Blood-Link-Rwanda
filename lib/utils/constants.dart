class AppConstants {
  static const String appName = 'BloodLink Rwanda';
  static const String appTagline = 'Connecting Life to Lifesavers';
  static const String mockApiUrl = 'https://mock-rbc-api.com/donors';

  // Mock database data
  static final Map<String, Map<String, dynamic>> mockDonors = {
    '1999-011234567': {
      'id': '1999-011234567',
      'fullName': 'Rufatiro Aline',
      'bloodType': 'A+',
      'lastDonationDate': '30/07/2025',
      'deferralStatus': 'N/A',
      'phoneNumber': '+250788123456',
      'email': 'aline.rufatiro@example.com',
      'location': 'Kigali, Rwanda',
      'totalDonations': 204,
      'lastDonationCenter': 'King Faisal Hospital',
    }
  };
}