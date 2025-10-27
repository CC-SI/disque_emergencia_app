import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/data/models/emergency_service.dart';
import 'package:flutter_application_1/ui/components/call_button.dart';
import 'package:google_fonts/google_fonts.dart';

class CallScreen extends StatelessWidget {
  const CallScreen({super.key});

  final String title = "Discagem de Emergência";

  @override
  Widget build(BuildContext context) {
    List<EmergencyService> services = CallScreen.loadEmergencyServices();

    CallButton policeButton = CallButton(service: services[0]);
    CallButton firemanButton = CallButton(service: services[1]);
    CallButton samuButton = CallButton(service: services[2]);
    CallButton civilDefenseButton = CallButton(service: services[3]);

    SizedBox spacer = SizedBox(height: 40, width: 20);

    Text message = Text(
      "DISQUE EMERGÊNCIA",
      style: GoogleFonts.luckiestGuy(fontSize: 38.0, color: Colors.black87),
    );

    /* Row firstRow = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[firemanButton, spacer, samuButton],
    );
    Row secondRow = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[policeButton, spacer, civilDefenseButton],
    );*/

    return Scaffold(
      backgroundColor: const Color(0xFFEEEEEE),
      appBar: AppBar(
        toolbarHeight: 80,
        titleSpacing: 0,
        title: message,
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              spacer,
              firemanButton,
              spacer,
              samuButton,
              spacer,
              civilDefenseButton,
              spacer,
              policeButton,
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  static List<EmergencyService> loadEmergencyServices() {
    return [
      // Policia
      EmergencyService(
        name: 'POLICIA MILITAR',
        phoneNumber: '190',
        description: 'Para violência, furto, assalto',
        icon: Icons
            .local_police_outlined, //Image.asset('images/icones/policia.png'),
        color: const Color.fromARGB(220, 26, 16, 204),
      ),

      // Bombeiros
      EmergencyService(
        name: 'BOMBEIROS',
        phoneNumber: '193',
        description: ' Para incêndios, vazamento de gás, afogamento, resgates',
        icon: Icons
            .local_fire_department_outlined, //Image.asset('images/icones/bombeiro.png'),
        color: const Color.fromARGB(255, 237, 51, 51),
      ),

      // SAMU
      EmergencyService(
        name: 'SAMU',
        phoneNumber: '192',
        description:
            'Para acidentes, sinais de avc, queimaduras , choque elétrico, falta de ar',
        icon: Icons
            .medical_services_outlined, //Image.asset('images/icones/samu.png'),
        color: const Color.fromARGB(255, 20, 135, 9),
      ),

      // Defesa Civil
      EmergencyService(
        name: 'DEFESA CIVIL',
        phoneNumber: '199',
        description: ' Para alagamentos, inundações, deslizamentos de terra',
        icon: Icons
            .flood_outlined, //Image.asset('images/icones/defesa_civil.png'),
        color: const Color.fromARGB(255, 255, 124, 43),
      ),
    ];
  }
}
