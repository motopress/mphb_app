import 'package:flutter/material.dart';
import 'package:lazy_load_indexed_stack/lazy_load_indexed_stack.dart';
import 'package:mphb_app/screens/calendar.dart';
import 'package:mphb_app/screens/bookings.dart';
import 'package:mphb_app/screens/payments.dart';
import 'package:mphb_app/screens/settings.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomePage extends StatefulWidget {

	const HomePage({Key? key}) : super(key: key);

	@override
	_HomePageState createState() => _HomePageState();
}

typedef PageBuilder = Widget Function();

class _HomePageState extends State<HomePage> {

	int _selectedIndex = 0;

	static final List<Widget> _widgetOptions = [
		CalendarPage(),
		BookingsPage(),
		PaymentsPage(),
		SettingsPage(),
	];

	@override
	Widget build(BuildContext context) {
		return Scaffold(
			body: LazyLoadIndexedStack(
				sizing: StackFit.expand,
				children: _widgetOptions,
				index: _selectedIndex,
			),
			bottomNavigationBar: Container(
				decoration: BoxDecoration(
    				border: Border(top: BorderSide(color: const Color(0xFFF4F5F8), width: 1.0))
    			),
				child: BottomNavigationBar(
					type: BottomNavigationBarType.fixed,
					backgroundColor: Color(0xffffffff),
					elevation: 0,
					showSelectedLabels: false,
					showUnselectedLabels: false,
					unselectedFontSize: 0.0, //fix for Failed assertion error.
					selectedFontSize: 0.0,
					items: <BottomNavigationBarItem>[
						BottomNavigationBarItem(
							icon: Icon(Icons.event_outlined),
							activeIcon: Icon(Icons.event),
							label: AppLocalizations.of(context).calendarLabelText,
						),
						BottomNavigationBarItem(
							icon: Icon(Icons.source_outlined),
							activeIcon: Icon(Icons.source),
							label: AppLocalizations.of(context).bookingsLabelText,
						),
						BottomNavigationBarItem(
							icon: Icon(Icons.payments_outlined),
							activeIcon: Icon(Icons.payments),
							label: AppLocalizations.of(context).paymentsLabelText,
						),
						BottomNavigationBarItem(
							icon: Icon(Icons.manage_accounts_outlined),
							activeIcon: Icon(Icons.manage_accounts),
							label: AppLocalizations.of(context).settingsLabelText,
						),
					],
					currentIndex: _selectedIndex,
					selectedItemColor: Colors.black,
					unselectedItemColor: Colors.grey[800],
					onTap: (index) => setState(() => _selectedIndex = index),
				),
			),
		);
	}

}
