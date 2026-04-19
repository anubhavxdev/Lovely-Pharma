class UserModel {
  final String uid;
  final String name;
  final String email;
  final List<Map<String, String>> addresses;

  UserModel({
    required this.uid,
    required this.name,
    required this.email,
    required this.addresses,
  });

  factory UserModel.fromMap(Map<String, dynamic> map, String documentId) {
    List<Map<String, String>> parsedAddresses = [];
    if (map['addresses'] != null) {
      for (var item in map['addresses']) {
        parsedAddresses.add(Map<String, String>.from(item));
      }
    } else {
      // Fallback for old data
      if (map['hostel'] != null && map['roomNo'] != null) {
        parsedAddresses.add({
          'hostel': map['hostel'] ?? '',
          'roomNo': map['roomNo'] ?? '',
        });
      }
    }

    return UserModel(
      uid: documentId,
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      addresses: parsedAddresses,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'addresses': addresses,
    };
  }
}
