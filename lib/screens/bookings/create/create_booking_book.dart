import 'package:flutter/material.dart';
import 'package:mphb_app/controller/bookings_controller.dart';
import 'package:mphb_app/models/new_booking.dart';

class CreateBookingBookPage extends StatefulWidget {

	const CreateBookingBookPage({
		Key? key,
		required this.booking,
	}) : super(key: key);

	final NewBooking booking;

	@override
	_CreateBookingBookPageState createState() => _CreateBookingBookPageState( booking: booking );

}

class _CreateBookingBookPageState extends State<CreateBookingBookPage> {

	_CreateBookingBookPageState({
		required this.booking,
	});

	final NewBooking booking;

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
		params['check_in_date'] = booking.check_in_date;
		params['check_out_date'] = booking.check_out_date;

		booking.accommodations.forEach((accommodation) {
			reserved_accommodations.add({
				'accommodation': accommodation.id,
				'adults': 1
			});
		});

		print(params);

		/*final bookingObj = await _bookingsController.wpCreateBooking( params );

		setState(() {_state = '';});
		
		ScaffoldMessenger.of(context).showSnackBar(
			SnackBar(content: Text('Booking ${bookingObj.id} created.'))
		);*/
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
