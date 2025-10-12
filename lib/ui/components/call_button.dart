import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class CallButton extends StatelessWidget
{
	const CallButton({super.key});

	@override
	Widget build(BuildContext context)
	{
		// Texto
		Text name = Text('Policia',
			style: TextStyle(
				fontSize: 24.0, // Sets the font size to 24 logical pixels
				),
		);
		Text number = Text('190',
			style: TextStyle(
				fontSize: 24.0, // Sets the font size to 24 logical pixels
			),
		);

		// Ícone
		Image image = Image(image: AssetImage('lib/assets/images/icones/policia.png'));

		// Layout
		Column column = Column(
			mainAxisAlignment: MainAxisAlignment.center,
			children: <Widget>[
				image,
				name,
				number,
			],
		);
		ButtonStyle style = ElevatedButton.styleFrom(
			shape: RoundedRectangleBorder(
				borderRadius: BorderRadius.circular(5),
			),
			padding: EdgeInsets.all(15),
			backgroundColor: Colors.red,
			foregroundColor: Colors.black,
			minimumSize: Size(150, 150),
			side: BorderSide(
			width: 4.0,
			color: Colors.grey,
			),
		);

		return ElevatedButton (onPressed: makeCall, style: style, child: column);
	}

	Future<void> makeCall() async
	{
			final Uri launchUri = Uri(
				scheme: 'tel',
				path: '190',
			);

			if (await canLaunchUrl(launchUri))
			{
				await launchUrl(launchUri);
			}
			else
			{
				// Handle the case where the URL cannot be launched (e.g., no phone app)
				throw 'Could not launch 190';
			}
	}
}