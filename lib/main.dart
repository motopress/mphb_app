import 'package:flutter/material.dart';
import 'package:mphb_app/screens/form.dart';
import 'package:mphb_app/screens/home.dart';
import 'package:mphb_app/local_storage.dart';

void main() {
	LocalStorage();
	runApp(MyApp());
}

class MyApp extends StatelessWidget {

	@override

	Widget build(BuildContext context) {
		return MaterialApp(
			title: 'Flutter Demo',
			theme: ThemeData(
				primarySwatch: Colors.blue,
				visualDensity: VisualDensity.adaptivePlatformDensity,
			),
			initialRoute: '/',
			routes: {
				'/': (context) => const MyCustomForm(),
				'/bookings': (context) => MyHomePage(),
			},
		);
	}
}


