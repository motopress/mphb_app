import 'package:flutter/material.dart';
import 'package:mphb_app/screens/bookings.dart';
import 'package:mphb_app/screens/payments.dart';

class MyHomePage extends StatefulWidget {
  
	const MyHomePage({Key? key}) : super(key: key);

	@override
	_MyHomePageState createState() => _MyHomePageState();
}

typedef PageBuilder = Widget Function();

class _MyHomePageState extends State<MyHomePage> {

	int _selectedIndex = 0;

	static final List<Widget> _widgetOptions = [
		BookingsPage(),
		PaymentsPage(),
	];

	@override
	Widget build(BuildContext context) {
		return Scaffold(
			body: IndexedStack(
				sizing: StackFit.expand,
				children: _widgetOptions,
				index: _selectedIndex,
			),
			bottomNavigationBar: BottomNavigationBar(
				items: const <BottomNavigationBarItem>[
					BottomNavigationBarItem(
						icon: Icon(Icons.event),
						label: 'Bookings',
					),
					BottomNavigationBarItem(
						icon: Icon(Icons.payments),
						label: 'Payments',
					),
				],
				currentIndex: _selectedIndex,
				selectedItemColor: Colors.indigo,
				onTap: (index) => setState(() => _selectedIndex = index),
			),
		);
	}

}
