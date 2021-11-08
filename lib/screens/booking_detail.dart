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
			body: SingleChildScrollView(
				child: Container(
					padding: const EdgeInsets.fromLTRB(20, 30, 20, 20),
					child: Column(
						children: [
							// booking status
							Container(
								margin: const EdgeInsets.only(bottom: 20.0),
								child: Row(
									mainAxisAlignment: MainAxisAlignment.spaceBetween,
									children: [
										Text(
											'Booking #' + booking['id'].toString(),
											style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
										),
										Container(
											decoration: BoxDecoration(
												borderRadius: BorderRadius.all(Radius.circular(8)),
												color: Colors.green,
											),
											padding: const EdgeInsets.only(top: 10, bottom: 10, left: 20.0, right: 20.0),
											child: Text(
												booking['status'],
												style: TextStyle(
													color: Colors.white,
													fontSize: 16,
												),
											),
										),
									]
								),
							),
							// check_in_date / check_out_date
							Container(
								decoration: ShapeDecoration(
									shape: RoundedRectangleBorder(
										borderRadius: BorderRadius.all(
											Radius.circular(4)
										)
									),
									color: Colors.orange[50],
								),
								child: Row(
									mainAxisAlignment: MainAxisAlignment.spaceEvenly,
									children: [
										Column(
											children: [
												Padding(
													padding: EdgeInsets.only(left: 5.0, right: 10.0, top: 20.0, bottom: 20.0),
													child: Row(
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
												),
											]
										),
										Column(
											children: [
												Padding(
													padding: EdgeInsets.only(left: 5.0, right: 10.0, top: 20.0, bottom: 20.0),
													child: Row(
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
												),
											]
										),
									]
								),
							),
							// customer
							Container(
								margin: const EdgeInsets.only(top: 20.0, bottom: 20.0),
								decoration: ShapeDecoration(
									shape: RoundedRectangleBorder(
										borderRadius: BorderRadius.all(
											Radius.circular(4)
										)
									),
									color: Colors.blueGrey.shade50,
								),
								child: Padding(
									padding: EdgeInsets.all(20.0),
									child: Row(
										crossAxisAlignment: CrossAxisAlignment.start,
										children: [
											Column(
												children: [
													Padding(
														padding: EdgeInsets.only(right: 20.0),
														child: Icon(
															Icons.person,
															size: 24
														)
													),
												]
											),
											Column(
												crossAxisAlignment: CrossAxisAlignment.start,
												children: [
													Text(booking['customer']['first_name'] + ' ' + booking['customer']['last_name'],),
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
							// reserved_accommodations
							Container(
								margin: const EdgeInsets.only(top: 0, bottom: 20.0),
								child: Column(
									crossAxisAlignment: CrossAxisAlignment.start,
									children: [
										Text('reserved_accommodations'),
										for (var i = 0; i < booking['reserved_accommodations'].length; i++)
											Container(
												padding: EdgeInsets.all(20.0),
												margin: const EdgeInsets.only(top: 10.0, bottom: 10.0),
												decoration: ShapeDecoration(
													shape: RoundedRectangleBorder(
														borderRadius: BorderRadius.all(
															Radius.circular(4)
														)
													),
													color: Colors.blueGrey.shade50,
												),
												child: Row(
													children: [
														Column(
															crossAxisAlignment: CrossAxisAlignment.start,
															children: [
																Text( 'accommodation: ' + booking['reserved_accommodations'][i]['accommodation'].toString()),
																Text( 'accommodation_type: ' + booking['reserved_accommodations'][i]['accommodation_type'].toString()),
																Text( 'rate: ' + booking['reserved_accommodations'][i]['rate'].toString()),
																Text( 'adults: ' + booking['reserved_accommodations'][i]['adults'].toString()),
																Text( 'children: ' + booking['reserved_accommodations'][i]['children'].toString()),
															],
														),
													]
												),
											),
									],
								),
							),
							//total_price
							Container(
								margin: const EdgeInsets.only(top: 0, bottom: 20.0),
								padding: EdgeInsets.all(20.0),
								decoration: ShapeDecoration(
									shape: RoundedRectangleBorder(
										borderRadius: BorderRadius.all(
											Radius.circular(4)
										)
									),
									color: Colors.orange[50],
								),
								child: Row(
									mainAxisAlignment: MainAxisAlignment.center,
									children: [
										Text(
											booking['total_price'].toString() + ' ' + booking['currency'],
											style: TextStyle(
												fontWeight: FontWeight.w800,
												fontSize: 16,
											),
										),
									],
								),
							),
						],
					),
				),
			),
		);
	}
}