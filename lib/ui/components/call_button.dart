import 'package:flutter/material.dart';

class CallButton extends StatelessWidget
{
	const CallButton({super.key});

	@override
	Widget build(BuildContext context)
	{
		Text label = Text('Ligar');

		Image image = Image(image: AssetImage('lib/assets/images/icones/policia.png'));
		ButtonStyle style = ElevatedButton.styleFrom(
			shape: RoundedRectangleBorder(
				borderRadius: BorderRadius.circular(5),
			)
		);

		return ElevatedButton.icon (onPressed: makeCall, style: style, icon: image, label: label);
	}

	void makeCall()
	{
		// Implementar a funcionalidade de chamada aqui
	}
}