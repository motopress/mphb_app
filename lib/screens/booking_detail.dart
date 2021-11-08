import 'package:flutter/material.dart';

class BookingDetailScreen extends StatelessWidget {

	const BookingDetailScreen({Key? key}) : super(key: key);

	@override
	Widget build(BuildContext context) {

		final booking = ModalRoute.of(context)!.settings.arguments as Map;

		return Scaffold(
			appBar: AppBar(
				title: Text( 'Booking #' + booking['id'].toString()),
			),
			body: Column(
				children: [
				
					Container(
						decoration: BoxDecoration(
							borderRadius: BorderRadius.all(Radius.circular(8)),
							color: Colors.green,
						),
						padding: const EdgeInsets.all(8.0),
						margin: const EdgeInsets.only(top: 20.0, bottom: 20.0),
						child: Text(
							booking['status'],
							style: TextStyle(
								color: Colors.white,
								fontWeight: FontWeight.w800,
								fontSize: 16,
							),
						),
					),
					Row(
						mainAxisAlignment: MainAxisAlignment.spaceEvenly,
						children: [
							Column(
								children: [
									Row(
										children: [
											Padding(
												padding: EdgeInsets.all(10),
												child: Icon(
													Icons.flight_land,
													size: 16
												)
											),
											Text(
												booking['check_in_date'],
												style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
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
												padding: EdgeInsets.all(10),
												child: Icon(
													Icons.flight_takeoff,
													size: 16
												)
											),
											Text(
												booking['check_out_date'],
												style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
											),
										]
									),
								]
							),
						]
					),
					Container(
						margin: const EdgeInsets.only(top: 20.0, bottom: 20.0),
						child: Card(
							shape: RoundedRectangleBorder(
								borderRadius: BorderRadius.all(
									Radius.circular(4)
								)
							),
							color: Colors.blueGrey.shade50,
							margin: EdgeInsets.all(20.0),
							child: Padding(
								padding: EdgeInsets.all(20.0),
								child: Row(
									children: [
										Column(
											children: [
												Padding(
													padding: EdgeInsets.all(10),
													child: Icon(
														Icons.person,
														size: 36
													)
												),
											]
										),
										Column(
											crossAxisAlignment: CrossAxisAlignment.start,
											children: [
												Text(booking['customer']['first_name'],),
												Text(booking['customer']['last_name'],),
												SizedBox(height: 10),
												Text(booking['customer']['email'],),
												SizedBox(height: 10),
												Text(booking['customer']['phone'],),
											]
										),
									]
								)
							),
						),
					),
				],
			),
		);
	}
}