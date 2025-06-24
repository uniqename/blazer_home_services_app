import 'package:cloud_firestore/cloud_firestore.dart';

class Job {
  final String id;
  final String customerId;
  final String customerName;
  final String serviceType;
  final String description;
  final String address;
  final double latitude;
  final double longitude;
  final DateTime scheduledDate;
  final String status; // pending, accepted, in_progress, completed, cancelled
  final double price;
  final List<String> requirements;
  final DateTime createdAt;
  final String? providerId;
  final String? customerPhone;
  final String? specialInstructions;

  Job({
    required this.id,
    required this.customerId,
    required this.customerName,
    required this.serviceType,
    required this.description,
    required this.address,
    required this.latitude,
    required this.longitude,
    required this.scheduledDate,
    required this.status,
    required this.price,
    required this.requirements,
    required this.createdAt,
    this.providerId,
    this.customerPhone,
    this.specialInstructions,
  });

  factory Job.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Job(
      id: doc.id,
      customerId: data['customerId'] ?? '',
      customerName: data['customerName'] ?? '',
      serviceType: data['serviceType'] ?? '',
      description: data['description'] ?? '',
      address: data['address'] ?? '',
      latitude: (data['latitude'] ?? 0.0).toDouble(),
      longitude: (data['longitude'] ?? 0.0).toDouble(),
      scheduledDate: (data['scheduledDate'] as Timestamp).toDate(),
      status: data['status'] ?? 'pending',
      price: (data['price'] ?? 0.0).toDouble(),
      requirements: List<String>.from(data['requirements'] ?? []),
      createdAt: (data['createdAt'] as Timestamp).toDate(),
      providerId: data['providerId'],
      customerPhone: data['customerPhone'],
      specialInstructions: data['specialInstructions'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'customerId': customerId,
      'customerName': customerName,
      'serviceType': serviceType,
      'description': description,
      'address': address,
      'latitude': latitude,
      'longitude': longitude,
      'scheduledDate': Timestamp.fromDate(scheduledDate),
      'status': status,
      'price': price,
      'requirements': requirements,
      'createdAt': Timestamp.fromDate(createdAt),
      'providerId': providerId,
      'customerPhone': customerPhone,
      'specialInstructions': specialInstructions,
    };
  }

  Job copyWith({
    String? status,
    String? providerId,
  }) {
    return Job(
      id: id,
      customerId: customerId,
      customerName: customerName,
      serviceType: serviceType,
      description: description,
      address: address,
      latitude: latitude,
      longitude: longitude,
      scheduledDate: scheduledDate,
      status: status ?? this.status,
      price: price,
      requirements: requirements,
      createdAt: createdAt,
      providerId: providerId ?? this.providerId,
      customerPhone: customerPhone,
      specialInstructions: specialInstructions,
    );
  }
}