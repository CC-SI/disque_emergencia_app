import 'package:flutter/material.dart';

class CallPage extends StatelessWidget
{
	const CallPage({super.key, required this.title});

	final String title;

	Widget build(BuildContext context)
	{
		return Container(color: Theme.of(context).primaryColor);
	}
}