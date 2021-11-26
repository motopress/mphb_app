import 'package:flutter/material.dart';
import 'package:mphb_app/controller/bookings_controller.dart';

class CreateBookingBookPage extends StatefulWidget {

	const CreateBookingBookPage({
		Key? key,
		required this.onSignupComplete,
		required this.booking,
	}) : super(key: key);

	final VoidCallback onSignupComplete;
	final Map booking;

	@override
	_CreateBookingBookPageState createState() => _CreateBookingBookPageState( booking: booking );

}

class _CreateBookingBookPageState extends State<CreateBookingBookPage> {

	_CreateBookingBookPageState({
		required this.booking,
	});

	final Map booking;

	String _state = '';

	late final BookingsController _bookingsController;

	@override
	void initState() {

		super.initState();
		_bookingsController = new BookingsController();
	}

	void bookNow() async {

		setState(() {_state = 'waiting';});

		List<Map> reserved_accommodations = [];

		Map params = {
			'reserved_accommodations': reserved_accommodations
		};

		params['status'] = 'confirmed';
		params['check_in_date'] = booking['check_in_date'];
		params['check_out_date'] = booking['check_out_date'];

		booking['selectedAccommodations'].forEach((id) {
			reserved_accommodations.add({
				'accommodation': id,
				'adults': 1
			});
		});

		print(params);

		final bookingObj = await _bookingsController.wpCreateBooking( params );

		setState(() {_state = '';});
		
		ScaffoldMessenger.of(context).showSnackBar(
			SnackBar(content: Text('Booking ${bookingObj.id} created.'))
		);
	}

	@override
	Widget build(BuildContext context) {

		return SingleChildScrollView(
			child: Column(
				mainAxisAlignment: MainAxisAlignment.start,
				crossAxisAlignment: CrossAxisAlignment.start,
				children: [
					Container(
						padding: EdgeInsets.all(20.00),
						margin: EdgeInsets.only(bottom: 10.00),
						child: ElevatedButton(
							onPressed: widget.onSignupComplete,
							child: const Text('Exit'),
						),
					),
					Container(
						padding: EdgeInsets.all(20.00),
						margin: EdgeInsets.only(bottom: 10.00),
						child: ElevatedButton(
							onPressed: bookNow,
							child: const Text('Book Now'),
						),
					),
					if ( _state == 'waiting' )
						Center(child:CircularProgressIndicator())
				],
			),
		);
	}

}
