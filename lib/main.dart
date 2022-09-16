import 'package:flutter/material.dart';
import 'package:mphb_app/screens/form.dart';
import 'package:mphb_app/screens/home.dart';
import 'package:mphb_app/local_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {

	// Required for async calls in `main`
	WidgetsFlutterBinding.ensureInitialized();

	// Quick fix to initialize SharedPreferences
	final prefs = await SharedPreferences.getInstance();

	// Initialize SharedPrefs instance.
	await LocalStorage();

	runApp(MyApp());
}

class MyApp extends StatelessWidget {

	@override
	Widget build(BuildContext context) {
		return MaterialApp(
			debugShowCheckedModeBanner: false,
			theme: ThemeData(
				primarySwatch: Colors.indigo,
				scaffoldBackgroundColor: const Color(0xFFF3F4F6),
				visualDensity: VisualDensity.adaptivePlatformDensity,
				appBarTheme: AppBarTheme(
					backgroundColor: Colors.white,
					foregroundColor: Colors.black,
					elevation: 0,
				),
				elevatedButtonTheme: ElevatedButtonThemeData(
					style: ElevatedButton.styleFrom(
						primary: Colors.indigo.shade900,
					)
				),

			),
			initialRoute: LocalStorage().hasData() ? '/home' : '/login',
			routes: {
				'/home': (context) => const MyHomePage(),
				'/login': (context) => const MyCustomForm(),
			},
		);
	}
}


