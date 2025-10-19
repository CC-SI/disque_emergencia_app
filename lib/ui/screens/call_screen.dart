import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/data/models/emergency_service.dart';
import 'package:flutter_application_1/ui/components/call_button.dart';

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
      "Selecione o serviço de emergência",
      style: TextStyle(
        fontSize: 28.0,
        fontWeight: FontWeight.bold,
        color: const Color.fromARGB(255, 23, 15, 15),
        decoration: TextDecoration.none,
      ),
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
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const SizedBox(height: 20),
              message,
              spacer,
              firemanButton,
              spacer,
              samuButton,
              spacer,
              policeButton,
              spacer,
              civilDefenseButton,
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
        name: 'Polícia',
        phoneNumber: '190',
        description: 'Para violência, furto, assalto',
        icon: Image.asset('images/icones/policia.png'),
        color: const Color.fromARGB(255, 79, 81, 216),
      ),

      // Bombeiros
      EmergencyService(
        name: 'Bombeiros',
        phoneNumber: '193',
        description: 'Para violência, furto, assalto',
        icon: Image.asset('images/icones/bombeiro.png'),
        color: const Color.fromARGB(255, 237, 51, 51),
      ),

      // SAMU
      EmergencyService(
        name: 'SAMU',
        phoneNumber: '192',
        description:
            'Para incêndios, vazamento de gás, resgate em acidentes, afogamentos',
        icon: Image.asset('images/icones/samu.png'),
        color: const Color.fromARGB(255, 88, 154, 229),
      ),

      // Defesa Civil
      EmergencyService(
        name: 'Defesa Civil',
        phoneNumber: '199',
        description: 'Alagamentos, inundações, deslizamentos de terra',
        icon: Image.asset('images/icones/defesa_civil.png'),
        color: const Color.fromARGB(255, 255, 124, 43),
      ),
    ];
  }
}
