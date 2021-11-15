import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mphb_app/models/booking.dart';

class BookingDetailStatus extends StatelessWidget {

	const BookingDetailStatus({required this.booking, Key? key}) : super(key: key);

	final Booking booking;

	@override
	Widget build(BuildContext context) {

		return Container(
			margin: const EdgeInsets.only(bottom: 20.0),
			child: Row(
				mainAxisAlignment: MainAxisAlignment.spaceBetween,
				children: [
					Column(
						crossAxisAlignment: CrossAxisAlignment.start,
						children: [
							Text(
								'Booking #' + booking.id.toString(),
								style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
							),
							Padding (
								padding: EdgeInsets.only(top: 5.0),
								child: Text(
									DateFormat('yyyy-MM-dd HH:mm').format( DateTime.parse(booking.date_created) ),
									style: TextStyle(fontSize: 12),
								),
							),
						],
					),
					Container(
						decoration: BoxDecoration(
							borderRadius: BorderRadius.all(Radius.circular(4)),
							color: booking.status == 'confirmed' ? Colors.green : Colors.orange,
						),
						padding: const EdgeInsets.only(top: 10, bottom: 10, left: 10.0, right: 10.0),
						child: Text(
							booking.status,
							style: TextStyle(
								color: Colors.white,
								fontSize: 16,
							),
						),
					),
					/*ElevatedButton(
						onPressed: () {
							var status = (booking.status == 'confirmed') ? 'cancelled' : 'confirmed';
							print('wpUpdateBookingStatus: ' + status);
							setState(() {
								_booking = _bookingController.wpUpdateBookingStatus( booking, status );
							});
						},
						child: Text('Set ' + (booking.status == 'confirmed' ? 'cancelled' : 'confirmed')),
					),*/
				]
			),
		);

	}
}