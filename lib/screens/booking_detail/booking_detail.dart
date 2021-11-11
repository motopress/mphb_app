import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mphb_app/controller/booking_controller.dart';
import 'package:mphb_app/models/booking.dart';
import 'package:mphb_app/screens/booking_detail/booking_detail_dates.dart';
import 'package:mphb_app/screens/booking_detail/booking_detail_customer.dart';
import 'package:mphb_app/screens/booking_detail/booking_detail_accommodation.dart';

class BookingDetailScreen extends StatefulWidget {

	const BookingDetailScreen({Key? key}) : super(key: key);

	@override
	_BookingDetailScreenState createState() => _BookingDetailScreenState();

}

class _BookingDetailScreenState extends State<BookingDetailScreen> {

	late Future<Booking> _booking;

	int _id = 0;

	@override
	void initState() {
		super.initState();
	}

	Map getAccommodationById( List accommodation, int id ) {
		for (var acc in accommodation) {
			if ( acc['id'] == id) {
				return acc;
			}
		}
		return {};
	}

	Map getAccommodationTypeById( List accommodation_type, int id ) {
		for (var acc_type in accommodation_type) {
			if ( acc_type['id'] == id) {
				return acc_type;
			}
		}
		return {};
	}

	@override
	Widget build(BuildContext context) {

		_id = ModalRoute.of(context)!.settings.arguments as int;

		setState(() {});

		_booking = BookingController.wpGetBooking( _id );

		return Scaffold(
			appBar: AppBar(
				title: Text( 'Booking #$_id' ),
			),
			body: FutureBuilder(
				future: _booking,
				builder: (context, AsyncSnapshot snapshot) {
					if (snapshot.connectionState == ConnectionState.waiting) {
						return new Center(
							child: new CircularProgressIndicator(),
						);
					} else if (snapshot.hasError) {
						return new Text('Error: ${snapshot.error}');
					} else {

						Booking booking = snapshot.data;
						
						return SingleChildScrollView(
							child: Container(
								padding: const EdgeInsets.fromLTRB(20, 30, 20, 20),
								child: Column(
									children: [
										// booking id + status
										Container(
											margin: const EdgeInsets.only(bottom: 20.0),
											child: Row(
												mainAxisAlignment: MainAxisAlignment.spaceBetween,
												children: [
													Column(
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
												]
											),
										),

										// check_in_date / check_out_date
										BookingDetailDates( booking: booking ),

										// customer
										BookingDetailCustomer( customer: booking.customer ),

										// reserved_accommodations
										Container(
											margin: const EdgeInsets.only(top: 0, bottom: 20.0),
											child: Column(
												crossAxisAlignment: CrossAxisAlignment.start,
												children: [
													Text('Reservation'),
													for ( var reserved_accommodation in booking.reserved_accommodations )
														BookingDetailAccommodation( reserved_accommodation: reserved_accommodation ),
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
												color: Colors.white,
											),
											child: Row(
												mainAxisAlignment: MainAxisAlignment.center,
												children: [
													Text(
														booking.total_price.toString() + ' ' + booking.currency,
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
						);
					}
				}
			),
		);
	}
}