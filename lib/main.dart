import 'package:flutter/material.dart';
import 'package:mphb_app/screens/form.dart';
import 'package:mphb_app/screens/home.dart';
import 'package:mphb_app/local_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
			localizationsDelegates: [
				AppLocalizations.delegate,
				GlobalMaterialLocalizations.delegate,
				GlobalWidgetsLocalizations.delegate,
				GlobalCupertinoLocalizations.delegate,
			],
			supportedLocales: [
				Locale('en'), // English
				Locale('fr'), // French
			],
			theme: ThemeData(
				primarySwatch: Colors.indigo,
				scaffoldBackgroundColor: const Color(0xFFF4F5F8),
				visualDensity: VisualDensity.adaptivePlatformDensity,
				appBarTheme: AppBarTheme(
					backgroundColor: Colors.white,
					foregroundColor: Colors.black,
					elevation: 0,
				),
				elevatedButtonTheme: ElevatedButtonThemeData(
						style: ElevatedButton.styleFrom(
					primary: Colors.indigo.shade600,
				)),
				chipTheme: ChipTheme.of(context).copyWith(
					backgroundColor: Colors.white,
					selectedColor: Colors.indigo.shade100,
					secondarySelectedColor: Colors.indigo.shade100,
					secondaryLabelStyle: TextStyle(color: Colors.black),
				),
			),
			initialRoute: LocalStorage().hasData() ? '/home' : '/login',
			routes: {
				'/home': (context) => const HomePage(),
				'/login': (context) => const LoginForm(),
			},
		);
	}
}
