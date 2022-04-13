import 'package:flutter/material.dart';
import 'package:mphb_app/models/booking.dart';

class BookingDetailIcal extends StatelessWidget {

	const BookingDetailIcal({required this.booking, Key? key}) : super(key: key);

	final Booking booking;

	@override
	Widget build(BuildContext context) {

		return Container(

			padding: EdgeInsets.all(20.0),
			margin: const EdgeInsets.only(top: 20.0, bottom: 20.0),
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
						offset: Offset(0, 4),
					),
				],
			),
			child: Column(
				children: [
					if ( ! booking.ical_description.isEmpty )
						Row(
							children: [
								Flexible(
									child: Text(booking.ical_description,),
								),
							]
						),
					if ( ! booking.ical_prodid.isEmpty )
						Row(
							children: [
								Flexible(
									child: Text(booking.ical_prodid,),
								),
							]
						),
					if ( ! booking.ical_summary.isEmpty )
						Row(
							children: [
								Flexible(
									child: Text(booking.ical_summary,),
								),
							]
						),
				],
			),
		);

	}
}