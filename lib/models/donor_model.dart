class Donor {
  final String id;
  final String fullName;
  final String bloodType;
  final String lastDonationDate;
  final String deferralStatus;
  final String phoneNumber;
  final String email;
  final String location;
  final int totalDonations;
  final String lastDonationCenter;
  final String? password; // Add password field for authentication
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Donor({
    required this.id,
    required this.fullName,
    required this.bloodType,
    required this.lastDonationDate,
    required this.deferralStatus,
    required this.phoneNumber,
    required this.email,
    required this.location,
    required this.totalDonations,
    required this.lastDonationCenter,
    this.password,
    this.createdAt,
    this.updatedAt,
  });

  factory Donor.fromJson(Map<String, dynamic> json) {
    return Donor(
      id: json['id'] ?? '',
      fullName: json['fullName'] ?? '',
      bloodType: json['bloodType'] ?? '',
      lastDonationDate: json['lastDonationDate'] ?? '',
      deferralStatus: json['deferralStatus'] ?? 'N/A',
      phoneNumber: json['phoneNumber'] ?? '',
      email: json['email'] ?? '',
      location: json['location'] ?? '',
      totalDonations: json['totalDonations'] ?? 0,
      lastDonationCenter: json['lastDonationCenter'] ?? '',
      password: json['password'],
      createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
      updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'fullName': fullName,
      'bloodType': bloodType,
      'lastDonationDate': lastDonationDate,
      'deferralStatus': deferralStatus,
      'phoneNumber': phoneNumber,
      'email': email,
      'location': location,
      'totalDonations': totalDonations,
      'lastDonationCenter': lastDonationCenter,
      'password': password,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }

  // Helper methods
  int get daysUntilEligible {
    if (lastDonationDate.isEmpty) return 0;

    try {
      final lastDate = DateTime.parse(lastDonationDate);
      final nextDate = lastDate.add(const Duration(days: 90)); // 3 months gap
      final now = DateTime.now();

      if (now.isAfter(nextDate)) return 0;
      return nextDate.difference(now).inDays;
    } catch (e) {
      return 0;
    }
  }

  bool get isEligible => daysUntilEligible == 0;
}