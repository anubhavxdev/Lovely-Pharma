class OrderModel {
  final String id;
  final String userId;
  final List<dynamic> items; // Will store basic info like name, qty, price
  final double totalPrice;
  final String status; // Pending, Delivered
  final DateTime timestamp;
  final String hostel;
  final String roomNo;

  OrderModel({
    required this.id,
    required this.userId,
    required this.items,
    required this.totalPrice,
    required this.status,
    required this.timestamp,
    required this.hostel,
    required this.roomNo,
  });

  factory OrderModel.fromMap(Map<String, dynamic> map, String documentId) {
    return OrderModel(
      id: documentId,
      userId: map['userId'] ?? '',
      items: map['items'] ?? [],
      totalPrice: (map['totalPrice'] ?? 0.0).toDouble(),
      status: map['status'] ?? 'Pending',
      timestamp: map['timestamp'] != null 
          ? map['timestamp'].toDate() 
          : DateTime.now(),
      hostel: map['hostel'] ?? '',
      roomNo: map['roomNo'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'items': items,
      'totalPrice': totalPrice,
      'status': status,
      'timestamp': timestamp,
      'hostel': hostel,
      'roomNo': roomNo,
    };
  }
}
