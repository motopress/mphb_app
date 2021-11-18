import 'package:flutter/material.dart';
import 'package:mphb_app/models/booking.dart';
import 'package:mphb_app/models/enum/booking_status.dart';

class BookingDetailActions extends StatelessWidget {

	const BookingDetailActions({required this.booking, Key? key}) : super(key: key);

	final Booking booking;

	@override
	Widget build(BuildContext context) {

		return Wrap(
			children: [
				ListTile(
					leading: Icon(Icons.hourglass_empty),
					title: Text('Set to Pending Admin'),
					onTap: () {
						Navigator.pop(context, BookingStatusEnum.PENDING);
					},
				),
				ListTile(
					leading: Icon(Icons.mail_outline),
					title: Text('Set to Pending User Confirmation'),
					onTap: () {
						Navigator.pop(context, BookingStatusEnum.PENDING_USER);
					},
				),
				ListTile(
					leading: Icon(Icons.payment),
					title: Text('Set to Pending Payment'),
					onTap: () {
						Navigator.pop(context, BookingStatusEnum.PENDING_PAYMENT);
					},
				),
				ListTile(
					leading: Icon(Icons.block),
					title: Text('Set to Cancelled'),
					onTap: () {
						Navigator.pop(context, BookingStatusEnum.CANCELLED);
					},
				),
				ListTile(
					leading: Icon(Icons.done),
					title: Text('Set to Confirmed'),
					onTap: () {
						Navigator.pop(context, BookingStatusEnum.CONFIRMED);
					},
				),
				Divider(),
				ListTile(
					leading: Icon(Icons.delete),
					title: Text('Delete'),
					onTap: () {
						Navigator.pop(context, 'delete');
					},
				),
			],
		);

	}
}