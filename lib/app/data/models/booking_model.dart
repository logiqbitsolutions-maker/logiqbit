import 'package:cloud_firestore/cloud_firestore.dart';

class BookingModel {
  final String? id;
  final String name;
  final String email;
  final String phone;
  final String service;
  final DateTime bookingDate;
  final String timeSlot;
  final String? details;
  final DateTime? createdAt;

  BookingModel({
    this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.service,
    required this.bookingDate,
    required this.timeSlot,
    this.details,
    this.createdAt,
  });

  factory BookingModel.fromJson(Map<String, dynamic> json, String documentId) {
    return BookingModel(
      id: documentId,
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'] ?? '',
      service: json['service'] ?? '',
      bookingDate: (json['bookingDate'] as Timestamp).toDate(),
      timeSlot: json['timeSlot'] ?? '',
      details: json['details'],
      createdAt: json['createdAt'] != null
          ? (json['createdAt'] as Timestamp).toDate()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'service': service,
      'bookingDate': Timestamp.fromDate(bookingDate),
      'timeSlot': timeSlot,
      if (details != null && details!.trim().isNotEmpty) 'details': details,
      'createdAt': FieldValue.serverTimestamp(),
    };
  }
}
