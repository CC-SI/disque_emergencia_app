import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

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