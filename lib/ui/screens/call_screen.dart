import 'package:flutter/material.dart';
import 'package:flutter_application_1/ui/components/call_button.dart';

class CallScreen extends StatelessWidget
{
	const CallScreen({super.key});

	final String title = "Discagem de Emergência";

	@override
	Widget build(BuildContext context)
	{
		CallButton policeButton = CallButton();

		Container container = Container(color: Theme.of(context).primaryColor,
			child: Column(
				mainAxisAlignment: MainAxisAlignment.center,
				children: <Widget>[
					Text(
						'Tela de Discagem de Emergência',
						style: Theme.of(context).textTheme.headlineMedium,
					),
					policeButton,
				],
			)
		);
		return container;
	}
}