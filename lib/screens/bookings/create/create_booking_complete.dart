import 'package:flutter/material.dart';
import 'package:mphb_app/controller/bookings_controller.dart';
import 'package:mphb_app/models/create_booking.dart';
import 'package:mphb_app/models/accommodation.dart';
import 'package:mphb_app/models/reserved_accommodation.dart';
import 'package:mphb_app/screens/bookings/create/single_accommodation.dart';

class CreateBookingCompletePage extends StatefulWidget {

	const CreateBookingCompletePage({
		Key? key,
		required this.booking,
	}) : super(key: key);

	final Create_Booking booking;

	@override
	_CreateBookingCompletePageState createState() => _CreateBookingCompletePageState( booking: booking );

}

class _CreateBookingCompletePageState extends State<CreateBookingCompletePage> {

	_CreateBookingCompletePageState({
		required this.booking,
	});

	late Create_Booking booking;

	String _state = 'waiting';

	late final BookingsController _bookingsController;

	@override
	void initState() {

		super.initState();
		_bookingsController = new BookingsController();

		bookNow();

	}

	void bookNow() async {

		setState(() {_state = 'waiting';});

		List<Map> reserved_accommodations = [];

		Map params = {
			'reserved_accommodations': reserved_accommodations,
			'customer': {}
		};

		params['status'] = 'confirmed';
		params['check_in_date'] = booking.check_in_date;
		params['check_out_date'] = booking.check_out_date;

		booking.reserved_accommodations.forEach((reserved_accommodation) {
			reserved_accommodations.add({
				'accommodation': reserved_accommodation.accommodation,
				'adults': reserved_accommodation.adults,
				'children': reserved_accommodation.children
			});
		});

		params['customer']['first_name'] = booking.customer.first_name;
		params['customer']['last_name'] = booking.customer.last_name;
		params['customer']['email'] = booking.customer.email;
		params['customer']['phone'] = booking.customer.phone;

		print(params);

		/*await Future.delayed(const Duration(milliseconds: 5000));
		setState(() {_state = 'complete';});*/

		try {

			final bookingObj = await _bookingsController.wpCreateBooking( params );

			setState(() {_state = 'complete';});
			
			ScaffoldMessenger.of(context).showSnackBar(
				SnackBar(content: Text('Booking ${bookingObj.id} created.'))
			);

		} catch (error) {
			print(error);

			setState(() {
				_state = '';
			});

			ScaffoldMessenger.of(context).clearSnackBars();
			ScaffoldMessenger.of(context).showSnackBar(
				SnackBar(content: Text(error.toString()))
			);
		}
	}

	Widget getChild() {

		switch (_state) {
			case 'complete':
				return Icon(
					Icons.check_circle,
					size: 48,
					color: Colors.green,
				);
				break;

			case 'waiting':
				return CircularProgressIndicator();
				break;

			default:
				return Text('');
				break;
		}
	}

	@override
	Widget build(BuildContext context) {

		return Row(
			mainAxisAlignment: MainAxisAlignment.center,
    		crossAxisAlignment: CrossAxisAlignment.stretch,
			children: [
				Column(
					mainAxisAlignment: MainAxisAlignment.center,
					crossAxisAlignment: CrossAxisAlignment.center,
					children: [
						Container(
							padding: EdgeInsets.all(10.00),
							child: getChild(),
							decoration: BoxDecoration(
								color: Colors.white,
								borderRadius: BorderRadius.all(
									Radius.circular(100)
								),
								boxShadow: [
									BoxShadow(
										color: Colors.grey.withOpacity(0.1),
										spreadRadius: 0,
										blurRadius: 2,
										offset: Offset(0, 4), // changes position of shadow
									),
								],
							),
						),
					],
				),
			],
		);
	}

}
