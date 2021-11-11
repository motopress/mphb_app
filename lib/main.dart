import 'package:flutter/material.dart';
import 'package:mphb_app/screens/form.dart';
import 'package:mphb_app/screens/home.dart';
import 'package:mphb_app/local_storage.dart';

void main() async {
  // Required for async calls in `main`
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize SharedPrefs instance.
  await LocalStorage();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {

	@override

	Widget build(BuildContext context) {
		return MaterialApp(
			title: 'Flutter Demo',
			theme: ThemeData(
				primarySwatch: Colors.indigo,
				scaffoldBackgroundColor: const Color(0xFFF3F4F6),
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


