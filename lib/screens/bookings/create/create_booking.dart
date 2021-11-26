import 'package:flutter/material.dart';
import 'package:mphb_app/screens/bookings/create/create_booking_search.dart';
import 'package:mphb_app/screens/bookings/create/create_booking_book.dart';

class CreateBookingPage extends StatefulWidget {

	const CreateBookingPage({
		Key? key
	}) : super(key: key);

	@override
	_CreateBookingPageState createState() => _CreateBookingPageState();

}

class _CreateBookingPageState extends State<CreateBookingPage> {

	final _navigatorKey = GlobalKey<NavigatorState>();

	final Map _booking = {
		'selectedAccommodations':[],
	};

	@override
	Widget build(BuildContext context) {

		return Scaffold(
			backgroundColor: Colors.white,
			appBar: AppBar(
				title: const Text('Add Booking'),
				actions: <Widget>[
					Padding(
						padding: EdgeInsets.all(10.0),
						child: TextButton(
							onPressed: () {},
							child: const Text('Reset'),
							style: TextButton.styleFrom(
								primary: Colors.black,
							),
						),
					),
				],
			),
			body: Navigator(
				key: _navigatorKey,
				initialRoute: 'create_booking/search',
				onGenerateRoute: (RouteSettings settings) {
					WidgetBuilder builder;
					switch (settings.name) {

						case 'create_booking/search':
							builder = (BuildContext context) => CreateBookingSearchPage(
								booking: _booking
							);
							break;

						case 'create_booking/book':
							builder = (BuildContext _) => CreateBookingBookPage(
								onSignupComplete: () {

									Navigator.of(context).pop();
								},
								booking: _booking
							);
							break;

						default:
							throw Exception('Invalid route: ${settings.name}');
					}
					return MaterialPageRoute<void>(builder: builder, settings: settings);
				},
			),
			persistentFooterButtons: [
				OutlinedButton(
					onPressed: () {
						_navigatorKey.currentState!.pop();
					},
					child: const Text('Back'),
				),
				ElevatedButton(
					onPressed: () {
						var exampleArgument = 'example string';
						_navigatorKey.currentState!.pushNamed(
							'create_booking/book',
							arguments: {'booking': exampleArgument},
						);
					},
					child: const Text('Continue'),
				),
			],
		);
	}

}
