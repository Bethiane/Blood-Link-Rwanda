class Campaign {
  final String id;
  final String title;
  final String description;
  final String startDate;
  final String endDate;
  final String location;
  final String organizer;
  final String contactInfo;
  final String status;
  final DateTime createdAt;

  Campaign({
    required this.id,
    required this.title,
    required this.description,
    required this.startDate,
    required this.endDate,
    required this.location,
    required this.organizer,
    required this.contactInfo,
    required this.status,
    required this.createdAt,
  });

  factory Campaign.fromJson(Map<String, dynamic> json) {
    return Campaign(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      startDate: json['startDate'] ?? '',
      endDate: json['endDate'] ?? '',
      location: json['location'] ?? '',
      organizer: json['organizer'] ?? '',
      contactInfo: json['contactInfo'] ?? '',
      status: json['status'] ?? 'active',
      createdAt: DateTime.parse(json['createdAt'] ?? DateTime.now().toIso8601String()),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'startDate': startDate,
      'endDate': endDate,
      'location': location,
      'organizer': organizer,
      'contactInfo': contactInfo,
      'status': status,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  // Helper methods
  bool get isActive {
    final now = DateTime.now();
    final start = DateTime.parse(startDate);
    final end = DateTime.parse(endDate);
    return now.isAfter(start) && now.isBefore(end);
  }

  String get duration {
    return '$startDate - $endDate';
  }
}