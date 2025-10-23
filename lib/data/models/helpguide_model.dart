import 'package:flutter/material.dart';

class HelpGuide {
  final int id;
  final String title;
  final IconData icon;
  final Color color;
  final String content;

  HelpGuide({
    required this.id,
    required this.title,
    required this.icon,
    required this.color,
    required this.content,
  });

  factory HelpGuide.fromJson(Map<String, dynamic> json) {
    return HelpGuide(
      id: json['id'] as int,
      title: json['title'] as String,
      icon: _getIconFromName(json['icon'] as String),
      color: _parseColor(json['color'] as String),
      content: json['content'] as String,
    );
  }
  
  static IconData _getIconFromName(String? name) {
    switch (name) {
      case 'local_fire_department':
        return Icons.local_fire_department_outlined;
      case 'cardiology':
        return Icons.heart_broken_outlined;
      case 'flood':
        return Icons.flood_outlined;
      case 'local_police':
        return Icons.local_police_outlined;
      default:
        return Icons.help_outline;
    }
  }

  static Color _parseColor(String? hex) {
    if (hex == null) return Colors.grey;
    final cleanHex = hex.replaceAll('#', '');
    return Color(int.parse('0xFF$cleanHex'));
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'icon': icon,
      'color': color,
      'content': content,
    };
  }
}