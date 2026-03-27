import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/booking_model.dart';

class BookingService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> saveBooking(BookingModel booking) async {
    try {
      // 1. Save to `bookcalls` collection
      final docRef = await _db.collection('bookcalls').add(booking.toJson());
      debugPrint("Booking saved with ID: ${docRef.id}");

      // 2. Generate Notification Emails
      await _triggerEmails(booking);
    } catch (e) {
      debugPrint("Error saving booking: $e");
      rethrow;
    }
  }

  Future<void> _triggerEmails(BookingModel booking) async {
    final dateFormat = DateFormat('MMMM d, yyyy');
    final formattedDate = dateFormat.format(booking.bookingDate);
    final meetingTime = "$formattedDate at ${booking.timeSlot}";

    final String scriptUrl = 'https://script.google.com/macros/s/AKfycbyz5SauEWh7BEMhA4WT7yshMYUIvjZJWmhZ4qgepVdtDCb8CmUSa0uILZpowS7kHbmP/exec';
    
    try {
      final response = await http.post(
        Uri.parse(scriptUrl),
        body: jsonEncode({
          "name": booking.name,
          "email": booking.email,
          "phone": booking.phone,
          "service": booking.service,
          "meetingTime": meetingTime,
          "details": booking.details ?? "",
        }),
      );
      
      debugPrint("Email Webhook Response: ${response.statusCode} - ${response.body}");
    } catch (e) {
      debugPrint("Email Webhook Error: $e");
    }
  }

  Future<void> triggerInquiryEmail({
    required String name,
    required String email,
    required String helpTopic,
    required String subject,
  }) async {
    final String scriptUrl = 'https://script.google.com/macros/s/AKfycbyz5SauEWh7BEMhA4WT7yshMYUIvjZJWmhZ4qgepVdtDCb8CmUSa0uILZpowS7kHbmP/exec';
    try {
      final response = await http.post(
        Uri.parse(scriptUrl),
        body: jsonEncode({
          "name": name,
          "email": email,
          "phone": "N/A",  // Not collected in general inquiry
          "service": helpTopic,
          "meetingTime": "General Inquiry",
          "details": subject,
        }),
      );
      debugPrint("Inquiry Webhook Response: ${response.statusCode} - ${response.body}");
    } catch (e) {
      debugPrint("Inquiry Webhook Error: $e");
    }
  }
}
