import 'package:flutter/material.dart';
import 'package:mphb_app/models/booking.dart';

class BookingDetailNote extends StatelessWidget {

	const BookingDetailNote({required this.booking, Key? key}) : super(key: key);

	final Booking booking;

	@override
	Widget build(BuildContext context) {

		return Container(

			padding: EdgeInsets.all(20.0),
			margin: const EdgeInsets.only(top: 10.0),
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
				children: [
					Row(
						children: [
							Flexible(
								child: Text(booking.note,),
							),
						]
					),
				],
			),
		);

	}
}