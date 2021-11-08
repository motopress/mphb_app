import 'package:flutter/material.dart';
import 'package:mphb_app/screens/booking_detail.dart';

class MyListItem extends StatelessWidget {

	final Map booking;

	const MyListItem(this.booking, {Key? key}) : super(key: key);

	@override
	Widget build(BuildContext context) {

	return Card(
		shape: RoundedRectangleBorder(
			borderRadius: BorderRadius.all(
				Radius.circular(4)
			)
		),
		color: Colors.blueGrey.shade50,
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
							arguments: booking,
						),
					),
				);
			},
			child: Padding(
				padding: EdgeInsets.all(10),
				child: Row(
					mainAxisAlignment: MainAxisAlignment.spaceEvenly,
					children: [
						Column(
							children: [
								Text(
									booking['id'].toString(),
									style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
								),
							]
						),
						Column(
							children: [
								if ( booking['status'] == 'confirmed' ) Icon(Icons.done)
								else if ( booking['status'] == 'abandoned' ) Icon(Icons.remove)
								else if ( booking['status'] == 'cancelled' ) Icon(Icons.block)
							]
						),
						Column(
							children: [
								Text(
									booking['status'],
									style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
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
												size: 16
											)
										),
										Text(
											booking['check_in_date'],
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
												size: 16
											)
										),
										Text(
											booking['check_out_date'],
											style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
										),
									]
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