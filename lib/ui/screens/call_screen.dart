import 'package:flutter/material.dart';
import 'package:flutter_application_1/data/models/emergency_service.dart';
import 'package:flutter_application_1/ui/components/call_button.dart';

class CallScreen extends StatelessWidget
{
	const CallScreen({super.key});

	final String title = "Discagem de Emergência";

	@override
	Widget build(BuildContext context)
	{
		List<EmergencyService> services = CallScreen.loadEmergencyServices();

		CallButton policeButton = CallButton(service: services[0]);
		CallButton firemanButton = CallButton(service: services[1]);
		CallButton samuButton = CallButton(service: services[2]);
		CallButton civilDefenseButton = CallButton(service: services[3]);
		CallButton contactButton = CallScreen.getContactButton();

		SizedBox spacer = SizedBox(height: 40, width: 20);

		Text message = Text( "Selecione o serviço de emergência",
			style: TextStyle(
				fontSize: 28.0,
				fontWeight: FontWeight.bold,
				color: Colors.white,
				decoration: TextDecoration.none,
			)
		);

		Row firstRow = Row(
			mainAxisAlignment: MainAxisAlignment.center,
			children: <Widget>[
				policeButton,
				spacer,
				firemanButton,
			],
		);
		Row secondRow = Row(
			mainAxisAlignment: MainAxisAlignment.center,
			children: <Widget>[
				samuButton,
				spacer,
				civilDefenseButton,
			],
		);

		Container container = Container(color: Theme.of(context).primaryColor,
			child: Column(
				mainAxisAlignment: MainAxisAlignment.center,
				children: <Widget>[
					message,
					spacer,
					firstRow,
					spacer,
					secondRow,
					spacer,
					contactButton,
				],
			)
		);
		return container;
	}

	static CallButton getContactButton()
	{
		EmergencyService contactService = EmergencyService(
			name: 'Contato de Emergência',
			// TODO: Pegar número do contato de emergência
			phoneNumber: '000000000',
			icon: Image.asset('lib/assets/images/icones/contato.png'),
			color: const Color.fromARGB(255, 239, 233, 240),
		);
		return CallButton(service: contactService);
	}

	static List<EmergencyService> loadEmergencyServices()
	{
		return [
			// Policia
			EmergencyService(
				name: 'Polícia',
				phoneNumber: '190',
				icon: Image.asset('lib/assets/images/icones/policia.png'),
				color: Colors.blue,
			),

			// Bombeiros
			EmergencyService(
				name: 'Bombeiros',
				phoneNumber: '193',
				icon: Image.asset('lib/assets/images/icones/bombeiro.png'),
				color: Colors.red,
			),

			// SAMU
			EmergencyService(
				name: 'SAMU',
				phoneNumber: '192',
				icon: Image.asset('lib/assets/images/icones/samu.png'),
				color: const Color.fromARGB(255, 219, 137, 14),
			),

			// Defesa Civil
			EmergencyService(
				name: 'Defesa Civil',
				phoneNumber: '199',
				icon: Image.asset('lib/assets/images/icones/defesa_civil.png'),
				color: Colors.green,
			),
		];
	}
}