import 'package:flutter/material.dart';
import 'package:flutter_application_1/data/models/emergency_service.dart';
import 'package:url_launcher/url_launcher.dart';

class CallButton extends StatelessWidget {
  const CallButton({super.key, required this.service});

  final EmergencyService service;

  @override
  Widget build(BuildContext context) {
    // Texto
    Text name = Text(
      service.name,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
    );
    Text number = Text(
      service.phoneNumber,
      style: TextStyle(fontSize: 28.0, fontWeight: FontWeight.bold),
    );
    Text description = Text(
      service.description,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 23.0,
        fontWeight: FontWeight.normal,
        color: Colors.white,
      ),
    );

    // Ícone

    Icon icon = Icon(service.icon, size: 60, color: Colors.white);

    // Layout
    Column column = Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        icon,
        name,
        number,
        const SizedBox(height: 5),
        description,
      ],
    );

    ButtonStyle style = ElevatedButton.styleFrom(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      padding: EdgeInsets.all(15),
      backgroundColor: service.color,
      foregroundColor: const Color.fromARGB(255, 255, 255, 255),
      minimumSize: Size(double.infinity, 120),
      side: BorderSide.none,
    );

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: ElevatedButton(onPressed: makeCall, style: style, child: column),
    );
  }

  Future<void> makeCall() async {
    final Uri launchUri = Uri(scheme: 'tel', path: service.phoneNumber);

    if (await canLaunchUrl(launchUri)) {
      await launchUrl(launchUri);
    } else {
      // Handle the case where the URL cannot be launched (e.g., no phone app)
      throw 'Could not launch ${service.phoneNumber}';
    }
  }
}
