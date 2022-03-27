import 'package:flutter/material.dart';
import 'package:mphb_app/controller/bookings_controller.dart';
import 'package:mphb_app/models/new_booking.dart';
import 'package:mphb_app/models/accommodation.dart';
import 'package:mphb_app/models/reserved_accommodation.dart';
import 'package:mphb_app/screens/bookings/create/single_accommodation.dart';

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

	late NewBooking booking;

	String _state = '';

	late final BookingsController _bookingsController;

	@override
	void initState() {

		super.initState();
		_bookingsController = new BookingsController();

		/*for (var accommodation in booking.accommodations) {

			var reserved_accommodation = new Reserved_Accommodation(

				accommodation: accommodation.id,
				accommodation_type: accommodation.accommodation_type_id,
				rate: 0,
				adults: 1,
				children: 0,
				services: [],
				accommodation_price_per_days: [],
				fees: [],
				taxes: {},
				discount: 0

			);

			booking.reserved_accommodations.add( reserved_accommodation );
		}*/
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
					Column(
						crossAxisAlignment: CrossAxisAlignment.start,
						children: getChildren(),
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

	List<Widget> getChildren() {

		return buildAccommodations.toList();
	}

	Iterable<Widget> get buildAccommodations sync* {

		var accommodations = booking.accommodations;

		for (var i = 0; i < accommodations.length; i++) {

			Accommodation accommodation = accommodations[i];

			yield SingleAccommodation(
				accommodation:accommodation,
				booking: booking
			);
		}
	}


}
