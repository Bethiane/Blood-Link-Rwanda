class DonationCenter {
  final String id;
  final String name;
  final String address;
  final String city;
  final String phoneNumber;
  final String email;
  final String workingHours;
  final double latitude;
  final double longitude;
  final DateTime createdAt;

  DonationCenter({
    required this.id,
    required this.name,
    required this.address,
    required this.city,
    required this.phoneNumber,
    required this.email,
    required this.workingHours,
    required this.latitude,
    required this.longitude,
    required this.createdAt,
  });

  factory DonationCenter.fromJson(Map<String, dynamic> json) {
    return DonationCenter(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      address: json['address'] ?? '',
      city: json['city'] ?? '',
      phoneNumber: json['phoneNumber'] ?? '',
      email: json['email'] ?? '',
      workingHours: json['workingHours'] ?? '',
      latitude: (json['latitude'] ?? 0.0).toDouble(),
      longitude: (json['longitude'] ?? 0.0).toDouble(),
      createdAt: DateTime.parse(json['createdAt'] ?? DateTime.now().toIso8601String()),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'address': address,
      'city': city,
      'phoneNumber': phoneNumber,
      'email': email,
      'workingHours': workingHours,
      'latitude': latitude,
      'longitude': longitude,
      'createdAt': createdAt.toIso8601String(),
    };
  }
  // REPLACE the entire getDistanceFrom method with:
  String getDistanceFrom(double userLat, double userLng) {
    // Simple hardcoded distance for testing
    return "2.5 km";
  }

// Remove _toRadians method or simplify it:
  double _toRadians(double degrees) {
    return degrees * 3.14159 / 180;
  }
}