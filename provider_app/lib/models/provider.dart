import 'package:cloud_firestore/cloud_firestore.dart';

class Provider {
  final String id;
  final String name;
  final String email;
  final String phone;
  final String profileImageUrl;
  final List<String> serviceTypes;
  final double rating;
  final int completedJobs;
  final bool isVerified;
  final String status; // active, inactive, suspended
  final Map<String, dynamic> location;
  final double totalEarnings;
  final DateTime joinedDate;
  final List<String> certifications;
  final String? fcmToken;

  Provider({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.profileImageUrl,
    required this.serviceTypes,
    required this.rating,
    required this.completedJobs,
    required this.isVerified,
    required this.status,
    required this.location,
    required this.totalEarnings,
    required this.joinedDate,
    required this.certifications,
    this.fcmToken,
  });

  factory Provider.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Provider(
      id: doc.id,
      name: data['name'] ?? '',
      email: data['email'] ?? '',
      phone: data['phone'] ?? '',
      profileImageUrl: data['profileImageUrl'] ?? '',
      serviceTypes: List<String>.from(data['serviceTypes'] ?? []),
      rating: (data['rating'] ?? 0.0).toDouble(),
      completedJobs: data['completedJobs'] ?? 0,
      isVerified: data['isVerified'] ?? false,
      status: data['status'] ?? 'active',
      location: Map<String, dynamic>.from(data['location'] ?? {}),
      totalEarnings: (data['totalEarnings'] ?? 0.0).toDouble(),
      joinedDate: (data['joinedDate'] as Timestamp).toDate(),
      certifications: List<String>.from(data['certifications'] ?? []),
      fcmToken: data['fcmToken'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'profileImageUrl': profileImageUrl,
      'serviceTypes': serviceTypes,
      'rating': rating,
      'completedJobs': completedJobs,
      'isVerified': isVerified,
      'status': status,
      'location': location,
      'totalEarnings': totalEarnings,
      'joinedDate': Timestamp.fromDate(joinedDate),
      'certifications': certifications,
      'fcmToken': fcmToken,
    };
  }

  Provider copyWith({
    String? status,
    double? rating,
    int? completedJobs,
    double? totalEarnings,
    String? fcmToken,
  }) {
    return Provider(
      id: id,
      name: name,
      email: email,
      phone: phone,
      profileImageUrl: profileImageUrl,
      serviceTypes: serviceTypes,
      rating: rating ?? this.rating,
      completedJobs: completedJobs ?? this.completedJobs,
      isVerified: isVerified,
      status: status ?? this.status,
      location: location,
      totalEarnings: totalEarnings ?? this.totalEarnings,
      joinedDate: joinedDate,
      certifications: certifications,
      fcmToken: fcmToken ?? this.fcmToken,
    );
  }
}