import 'package:flutter/material.dart';
import 'package:mphb_app/models/booking.dart';

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
						Navigator.pop(context, 'pending');
					},
				),
				ListTile(
					leading: Icon(Icons.mail_outline),
					title: Text('Set to Pending User Confirmation'),
					onTap: () {
						Navigator.pop(context, 'pending-user');
					},
				),
				ListTile(
					leading: Icon(Icons.payment),
					title: Text('Set to Pending Payment'),
					onTap: () {
						Navigator.pop(context, 'pending-payment');
					},
				),
				ListTile(
					leading: Icon(Icons.block),
					title: Text('Set to Cancelled'),
					onTap: () {
						Navigator.pop(context, 'cancelled');
					},
				),
				ListTile(
					leading: Icon(Icons.done),
					title: Text('Set to Confirmed'),
					onTap: () {
						Navigator.pop(context, 'confirmed');
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