class BloodRequest {
  final String id;
  final String title;
  final String description;
  final String bloodType;
  final String quantity;
  final String urgency;
  final String hospital;
  final String location;
  final String date;
  final String contactNumber;
  final String status;
  final DateTime createdAt;

  BloodRequest({
    required this.id,
    required this.title,
    required this.description,
    required this.bloodType,
    required this.quantity,
    required this.urgency,
    required this.hospital,
    required this.location,
    required this.date,
    required this.contactNumber,
    required this.status,
    required this.createdAt,
  });

  factory BloodRequest.fromJson(Map<String, dynamic> json) {
    return BloodRequest(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      bloodType: json['bloodType'] ?? '',
      quantity: json['quantity'] ?? '',
      urgency: json['urgency'] ?? '',
      hospital: json['hospital'] ?? '',
      location: json['location'] ?? '',
      date: json['date'] ?? '',
      contactNumber: json['contactNumber'] ?? '',
      status: json['status'] ?? 'active',
      createdAt: DateTime.parse(json['createdAt'] ?? DateTime.now().toIso8601String()),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'bloodType': bloodType,
      'quantity': quantity,
      'urgency': urgency,
      'hospital': hospital,
      'location': location,
      'date': date,
      'contactNumber': contactNumber,
      'status': status,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  // Helper methods
  bool get isUrgent => urgency.toLowerCase() == 'critical';
}