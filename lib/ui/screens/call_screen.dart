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

		Container container = Container(color: Theme.of(context).primaryColor,
			child: Column(
				mainAxisAlignment: MainAxisAlignment.center,
				children: <Widget>[
					Text(
						'Tela de Discagem de Emergência',
						style: Theme.of(context).textTheme.headlineMedium,
					),
					policeButton,
					firemanButton,
					samuButton,
					civilDefenseButton,
				],
			)
		);
		return container;
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
				color: Colors.orange,
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