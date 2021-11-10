import 'package:flutter/material.dart';
import 'package:mphb_app/screens/booking_detail.dart';
import 'package:mphb_app/models/booking.dart';

class MyListItem extends StatelessWidget {

	final Booking booking;

	const MyListItem({
		required this.booking,
		Key? key
	}) : super(key: key);

	@override
	Widget build(BuildContext context) {

	return Container(
		decoration: ShapeDecoration(
			shape: RoundedRectangleBorder(
				borderRadius: BorderRadius.all(
					Radius.circular(4)
				)
			),
			color: Colors.blueGrey.shade50,
		),
		margin: EdgeInsets.all(5),
		child: InkWell(
			onTap: () {
				Navigator.push(
					context,
					MaterialPageRoute(
						builder: (context) => const BookingDetailScreen(),
						// Pass the arguments as part of the RouteSettings. The
						// DetailScreen reads the arguments from these settings.
						settings: RouteSettings(
							arguments: booking.id,
						),
					),
				);
			},
			child: Padding(
				padding: EdgeInsets.all(10),
				child: Row(
					mainAxisAlignment: MainAxisAlignment.spaceBetween,
					children: [
						Column(
							children: [
								Text(
									booking.id.toString(),
									style: TextStyle(fontSize: 12),
								),
							]
						),
						Column(
							children: [
								Row(
									children: [
										Padding(
											padding: EdgeInsets.all(4),
											child: Icon(
												Icons.flight_land,
												size: 12
											)
										),
										Text(
											booking.check_in_date,
											style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
										),
									]
								),
							]
						),
						Column(
							children: [
								Row(
									children: [
										Padding(
											padding: EdgeInsets.all(4),
											child: Icon(
												Icons.flight_takeoff,
												size: 12
											)
										),
										Text(
											booking.check_out_date,
											style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
										),
									]
								),
							]
						),
						Column(
							children: [
								Row(
									children: [
										Text(
											booking.total_price.toString() + ' ' + booking.currency,
										),
									]
								),
							]
						),
						Column(
							children: [
								Container(
									padding: EdgeInsets.all(6.0),
									decoration: ShapeDecoration(
										shape: RoundedRectangleBorder(
											borderRadius: BorderRadius.all(
												Radius.circular(4)
											)
										),
										color: booking.status == 'confirmed' ? Colors.green : Colors.orange,
									),
									child: Text(
										booking.status,
										style: TextStyle(color: Colors.white,),
									),
								),
							]
						),
					]
				),
			),
		),
	);
  }
}