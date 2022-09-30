import 'package:flutter/material.dart';
import 'package:mphb_app/models/booking.dart';
import 'package:mphb_app/screens/common/booking_date.dart';

class BookingDetailDates extends StatelessWidget {

	const BookingDetailDates({required this.booking, Key? key}) : super(key: key);

	final Booking booking;

	@override
	Widget build(BuildContext context) {

		return Container(

			decoration: ShapeDecoration(
				shape: RoundedRectangleBorder(
					borderRadius: BorderRadius.all(
						Radius.circular(6)
					)
				),
			),
			child: Row(
				children: [
					
					Container(
						decoration: BoxDecoration(
							border: Border.all(
								width: 2.0,
								color: Colors.indigo.shade100
							),
							borderRadius: BorderRadius.all(
								Radius.circular(6.0)
							),
							color: Colors.white,
						),
						padding: EdgeInsets.only(
							left: 5.0, right: 10.0, top: 10.0, bottom: 10.0),
						margin: EdgeInsets.only(right: 10.0),
						child: Row(
							children: [
								Padding(
									padding: EdgeInsets.all(5),
									child: Icon(
										Icons.flight_land,
										size: 12,
										color: Colors.indigo.shade100
									)
								),
								BookingDate( booking.check_in_date ),
							]
						),
					),
					Container(
						decoration: BoxDecoration(
							border: Border.all(
								width: 2.0,
								color: Colors.indigo.shade100
							),
							borderRadius: BorderRadius.all(
								Radius.circular(6.0)
							),
							color: Colors.white,
						),
						padding: EdgeInsets.only(
							left: 5.0, right: 10.0, top: 10.0, bottom: 10.0),
						margin: EdgeInsets.only(left: 10.0),
						child: Row(
							children: [
								Padding(
									padding: EdgeInsets.all(5),
									child: Icon(
										Icons.flight_takeoff,
										size: 12,
										color: Colors.indigo.shade100
									)
								),
								BookingDate( booking.check_out_date ),
							]
						),
					),
				]
			),
		);
	}
}