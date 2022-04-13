import 'package:flutter/material.dart';
import 'package:mphb_app/screens/bookings/create/create_booking_search.dart';
import 'package:mphb_app/screens/bookings/create/create_booking_checkout.dart';
import 'package:mphb_app/screens/bookings/create/create_booking_complete.dart';
import 'package:mphb_app/models/create_booking.dart';

class CreateBookingPage extends StatefulWidget {

	const CreateBookingPage({
		Key? key
	}) : super(key: key);

	@override
	_CreateBookingPageState createState() => _CreateBookingPageState();

}

class _CreateBookingPageState extends State<CreateBookingPage> {

	final _navigatorKey = GlobalKey<NavigatorState>();

	final Create_Booking _booking = new Create_Booking();

	void _onBackPressed() {

		if ( _navigatorKey.currentState!.canPop() &&
				_booking.state != Create_Booking.COMPLETE ) {

			_navigatorKey.currentState!.pop();

			String state = ( _booking.state == Create_Booking.COMPLETE ) ?
				Create_Booking.CHECKOUT : Create_Booking.INITIAL;

			setState(() {
				_booking.state = state;
			});

		} else {
	
			Navigator.maybePop(context);
		}
	}

	@override
	Widget build(BuildContext context) {

		return NotificationListener<Notification>(

			child: Scaffold(

				appBar: AppBar(
					title: const Text('Add Booking'),
					leading: BackButton(onPressed: _onBackPressed),
				),
				body: Navigator(
					key: _navigatorKey,
					initialRoute: 'create_booking/search',
					onGenerateRoute: (RouteSettings settings) {

						WidgetBuilder builder;

						switch (settings.name) {

							case 'create_booking/search':
								builder = (BuildContext context) =>
									CreateBookingSearchPage(
										booking: _booking
									);
								break;

							case 'create_booking/checkout':
								builder = (BuildContext _) =>
									CreateBookingCheckoutPage(
										booking: _booking
									);
								break;

							case 'create_booking/complete':
								builder = (BuildContext _) =>
									CreateBookingCompletePage(
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

					if ( _booking.state == Create_Booking.INITIAL )
						ElevatedButton(
							child: const Text('Continue'),
							onPressed: _booking.accommodations.isEmpty ? null : () {

								_navigatorKey.currentState!.pushNamed(
									'create_booking/checkout',
								);

								setState(() {
									_booking.state = Create_Booking.CHECKOUT;
								});

							},
						),

					if ( _booking.state == Create_Booking.CHECKOUT )
						ElevatedButton(
							child: const Text('Book Now'),
							onPressed: _booking.reserved_accommodations.isEmpty ? null : () {
								_navigatorKey.currentState!.pushNamed(
									'create_booking/complete',
								);

								setState(() {
									_booking.state = Create_Booking.COMPLETE;
								});
							},
						),

					if ( _booking.state == Create_Booking.COMPLETE )
						OutlinedButton(
							child: const Text('Quit'),
							onPressed: _onBackPressed,
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
