import 'package:flutter/material.dart';
import 'package:mphb_app/wp-api.dart';
import 'package:mphb_app/screens/bookings.dart';

//TODO: StatefulWidget
class MyHomePage extends StatelessWidget {

	@override
	Widget build(BuildContext context) {
		return Scaffold(

			appBar: AppBar(
				title: Text('Bookings'),
				actions: <Widget>[
					IconButton(
						icon: const Icon(Icons.sync),
						tooltip: 'Refresh',
						onPressed: () {
						},
					),
					IconButton(
						icon: const Icon(Icons.settings),
						tooltip: 'Settings',
						onPressed: () {
							Navigator.push(context, MaterialPageRoute<void>(
								builder: (BuildContext context) {
									return Scaffold(
										appBar: AppBar(
											title: const Text('Settings'),
										),
										body: const Center(
											child: Text(
												'Settings page',
												style: TextStyle(fontSize: 24),
											),
										),
									);
								},
							));
						},
					),
				],
			),

			body: BookingsPage(),
		);
	}
}