import 'package:flutter/material.dart';

class EmergencyService {
  final String name;
  final String phoneNumber;
  final IconData icon;
  final Color color;
  final String description;

  EmergencyService({
    required this.name,
    required this.phoneNumber,
    required this.icon,
    required this.color,
    required this.description,
  });
}
