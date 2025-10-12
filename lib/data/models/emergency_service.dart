import 'package:flutter/material.dart';

class EmergencyService
{
	final String name;
	final String phoneNumber;
	final Image icon;
	final Color color;

	EmergencyService({
		required this.name,
		required this.phoneNumber,
		required this.icon,
		required this.color,
	});
}