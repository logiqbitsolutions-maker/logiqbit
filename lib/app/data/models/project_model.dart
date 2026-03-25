import 'package:flutter/material.dart';

class ProjectModel {
  final String category;
  final String title;
  final String description;
  final List<String> tags;
  final Color imageBgColor;
  final String imageUrl;
  final List<String> images;
  final IconData icon;

  ProjectModel({
    required this.category,
    required this.title,
    required this.description,
    required this.tags,
    required this.imageBgColor,
    required this.imageUrl,
    required this.images,
    required this.icon,
  });

  // Helper to convert from old Map structure if needed
  factory ProjectModel.fromMap(Map<String, dynamic> map) {
    return ProjectModel(
      category: map['category'] ?? '',
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      tags: List<String>.from(map['tags'] ?? []),
      imageBgColor: map['imageBgColor'] ?? Colors.transparent,
      imageUrl: map['imageUrl'] ?? '',
      images: List<String>.from(map['images'] ?? []),
      icon: map['icon'] ?? Icons.help_outline,
    );
  }
}
