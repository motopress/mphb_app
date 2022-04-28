import 'package:flutter/material.dart';
import 'package:mphb_app/models/booking.dart';
import 'package:intl/intl.dart';

class BookingDetailInternalNotes extends StatelessWidget {

	const BookingDetailInternalNotes({required this.booking, Key? key}) : super(key: key);

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
						offset: Offset(0, 4),
					),
				],
			),
			child: ListView.separated(
				padding: const EdgeInsets.all(0),
				shrinkWrap: true,
				itemCount: booking.internal_notes.length,
				itemBuilder: (context, index) {

					final item = booking.internal_notes[index];

					return Column(
						crossAxisAlignment: CrossAxisAlignment.start,
						children: [
							Text(
								DateFormat.yMMMd().format(
									DateTime.parse(item.date_utc)
								),
								style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
							),
							SizedBox(height: 10.0),
							Text(item.note),
						],
					);
				},
				separatorBuilder: (BuildContext context, int index) => const Divider(),
			),
		);

	}
}