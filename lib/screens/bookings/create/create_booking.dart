import 'package:flutter/material.dart';
import 'package:mphb_app/screens/bookings/create/create_booking_search.dart';
import 'package:mphb_app/screens/bookings/create/create_booking_book.dart';
import 'package:mphb_app/models/new_booking.dart';

class CreateBookingPage extends StatefulWidget {

	const CreateBookingPage({
		Key? key
	}) : super(key: key);

	@override
	_CreateBookingPageState createState() => _CreateBookingPageState();

}

class _CreateBookingPageState extends State<CreateBookingPage> {

	final _navigatorKey = GlobalKey<NavigatorState>();

	final NewBooking _booking = new NewBooking();

	@override
	Widget build(BuildContext context) {

		return NotificationListener<Notification>(
			child: Scaffold(
				//backgroundColor: Colors.white,
				appBar: AppBar(
					title: const Text('Add Booking'),
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

						if ( _booking.state != NewBooking.INITIAL )
							OutlinedButton(
								onPressed: () {
									if ( _navigatorKey.currentState!.canPop() ) {

										_navigatorKey.currentState!.pop();

										setState(() {
											_booking.state = NewBooking.INITIAL;
										});
									}
								},
								child: const Text('Back'),
							),

						if ( _booking.state != NewBooking.CHECKOUT )
							ElevatedButton(
								onPressed: _booking.accommodations.isEmpty ? null : () {

									_navigatorKey.currentState!.pushNamed(
										'create_booking/book',
									);

									setState(() {
										_booking.state = NewBooking.CHECKOUT;
									});

								},
								child: const Text('Continue'),
							),
				],
			),
			onNotification: (n) {

				setState( () {} );

				return true;
			}
		);
	}

}
