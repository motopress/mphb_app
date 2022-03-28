import 'package:flutter/material.dart';
import 'package:mphb_app/models/create_booking.dart';
import 'package:mphb_app/models/accommodation.dart';
import 'package:mphb_app/models/reserved_accommodation.dart';
import 'package:mphb_app/screens/bookings/create/single_accommodation.dart';

class CreateBookingCheckoutPage extends StatefulWidget {

	const CreateBookingCheckoutPage({
		Key? key,
		required this.booking,
	}) : super(key: key);

	final Create_Booking booking;

	@override
	_CreateBookingCheckoutPageState createState() => _CreateBookingCheckoutPageState( booking: booking );

}

class _CreateBookingCheckoutPageState extends State<CreateBookingCheckoutPage> {

	_CreateBookingCheckoutPageState({
		required this.booking,
	});

	late Create_Booking booking;

	@override
	void initState() {

		super.initState();
		
		//reset
		booking.reset();
	}

	@override
	Widget build(BuildContext context) {

		return SingleChildScrollView(
			child: Column(
				mainAxisAlignment: MainAxisAlignment.start,
				crossAxisAlignment: CrossAxisAlignment.start,
				children: [
					Container(
						padding: EdgeInsets.all(20.0),
						margin: EdgeInsets.all(10.00),
						decoration: BoxDecoration(
							color: Colors.white,
							borderRadius: BorderRadius.all(
								Radius.circular(6)
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
						child: Column(
							mainAxisAlignment: MainAxisAlignment.start,
							crossAxisAlignment: CrossAxisAlignment.start,
							children: [
								Text('Customer Information'),
								TextField(
									decoration: const InputDecoration(
										labelText: 'First Name',
									),
									keyboardType: TextInputType.name,
									textCapitalization: TextCapitalization.sentences,
									onChanged: (text) {
										booking.customer.first_name = text.trim();
									},
								),
								TextField(
									decoration: const InputDecoration(
										labelText: 'Last Name',
									),
									keyboardType: TextInputType.name,
									textCapitalization: TextCapitalization.words,
									onChanged: (text) {
										booking.customer.last_name = text.trim();
									},
								),
								TextField(
									decoration: const InputDecoration(
										labelText: 'Email',
									),
									keyboardType: TextInputType.emailAddress,
									onChanged: (text) {
										booking.customer.email = text.trim();
									},
								),
								TextField(
									decoration: const InputDecoration(
										labelText: 'Phone',
									),
									keyboardType: TextInputType.numberWithOptions(signed: true),
									onChanged: (text) {
										booking.customer.phone = text.trim();
									},
								),
							]
						),
					),
					Column(
						children: getChildren(),
					),
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
