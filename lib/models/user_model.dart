class UserModel {
  final String uid;
  final String name;
  final String email;
  final String hostel;
  final String roomNo;

  UserModel({
    required this.uid,
    required this.name,
    required this.email,
    required this.hostel,
    required this.roomNo,
  });

  factory UserModel.fromMap(Map<String, dynamic> map, String documentId) {
    return UserModel(
      uid: documentId,
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      hostel: map['hostel'] ?? '',
      roomNo: map['roomNo'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'hostel': hostel,
      'roomNo': roomNo,
    };
  }
}
