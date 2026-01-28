class BloodCompatibility {
  // Map of blood types and who they can donate to
  static final Map<String, List<String>> donorToRecipient = {
    'A+': ['A+', 'AB+'],
    'A-': ['A+', 'A-', 'AB+', 'AB-'],
    'B+': ['B+', 'AB+'],
    'B-': ['B+', 'B-', 'AB+', 'AB-'],
    'AB+': ['AB+'],
    'AB-': ['AB+', 'AB-'],
    'O+': ['A+', 'B+', 'AB+', 'O+'],
    'O-': ['A+', 'A-', 'B+', 'B-', 'AB+', 'AB-', 'O+', 'O-'],
  };

  // Map of blood types and who they can receive from
  static final Map<String, List<String>> recipientToDonor = {
    'A+': ['A+', 'A-', 'O+', 'O-'],
    'A-': ['A-', 'O-'],
    'B+': ['B+', 'B-', 'O+', 'O-'],
    'B-': ['B-', 'O-'],
    'AB+': ['A+', 'A-', 'B+', 'B-', 'AB+', 'AB-', 'O+', 'O-'],
    'AB-': ['A-', 'B-', 'AB-', 'O-'],
    'O+': ['O+', 'O-'],
    'O-': ['O-'],
  };

  // Check if donor can donate to recipient
  static bool canDonate(String donorType, String recipientType) {
    return donorToRecipient[donorType]?.contains(recipientType) ?? false;
  }

  // Get compatible blood types for a donor
  static List<String> getCompatibleRecipients(String donorType) {
    return donorToRecipient[donorType] ?? [];
  }

  // Get compatible donors for a recipient
  static List<String> getCompatibleDonors(String recipientType) {
    return recipientToDonor[recipientType] ?? [];
  }

  // Get priority level for a request (based on urgency and compatibility)
  static int getRequestPriority(String userBloodType, String requestBloodType, String urgency) {
    int priority = 0;

    // Base priority on compatibility
    if (canDonate(userBloodType, requestBloodType)) {
      priority += 10; // High priority if compatible
    }

    // Add urgency bonus
    if (urgency.toLowerCase() == 'critical') {
      priority += 5;
    } else if (urgency.toLowerCase() == 'urgent') {
      priority += 3;
    }

    return priority;
  }
}