import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mphb_app/controller/booking_controller.dart';
import 'package:mphb_app/models/booking.dart';
import 'package:mphb_app/screens/booking_detail/booking_detail_dates.dart';
import 'package:mphb_app/screens/booking_detail/booking_detail_customer.dart';
import 'package:mphb_app/screens/booking_detail/booking_detail_accommodation.dart';
import 'package:mphb_app/screens/booking_detail/booking_detail_price.dart';
import 'package:mphb_app/screens/booking_detail/booking_detail_payment.dart';
import 'package:mphb_app/screens/booking_detail/booking_detail_ical.dart';

class BookingDetailScreen extends StatefulWidget {

	const BookingDetailScreen({Key? key, required this.booking}) : super(key: key);

	final Booking booking;

	@override
	_BookingDetailScreenState createState() => _BookingDetailScreenState( bookingID: this.booking.id );

}

class _BookingDetailScreenState extends State<BookingDetailScreen> {

	_BookingDetailScreenState({
		required this.bookingID
	});

	late final BookingController _bookingController;

	late Future<Booking> _booking;
	
	final int bookingID;

	@override
	void initState() {
		super.initState();
		
		_bookingController = new BookingController();
		_booking = _bookingController.wpGetBooking( bookingID );
	}

	@override
	Widget build(BuildContext context) {

		return Scaffold(
			appBar: AppBar(
				title: Text( 'Booking #$bookingID' ),
				actions: <Widget>[
					IconButton(
						icon: const Icon(Icons.sync),
						tooltip: 'Refresh',
						onPressed: () {
							setState(() {});
						},
					),
					IconButton(
						icon: const Icon(Icons.more_vert),
						tooltip: 'Refresh',
						onPressed: () {
							showModalBottomSheet(
								context: context,
								builder: (context) {
									return Wrap(
										children: [
											ListTile(
												leading: Icon(Icons.share),
												title: Text('Share'),
											),
											ListTile(
												leading: Icon(Icons.link),
												title: Text('Get link'),
											),
											ListTile(
												leading: Icon(Icons.edit),
												title: Text('Edit name'),
											),
											ListTile(
												leading: Icon(Icons.delete),
												title: Text('Delete collection'),
											),
										],
									);
								},
							);
						},
					),
				],
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

						return RefreshIndicator(
							onRefresh: () => Future.sync(
								() => setState(() {}),
							),
							child: SingleChildScrollView(
								physics: AlwaysScrollableScrollPhysics(),
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
														ElevatedButton(
															onPressed: () {
																var status = (booking.status == 'confirmed') ? 'cancelled' : 'confirmed';
																print('wpUpdateBookingStatus: ' + status);
																setState(() {
																	_booking = _bookingController.wpUpdateBookingStatus( booking, status );
																});
															},
															child: Text('Set ' + (booking.status == 'confirmed' ? 'cancelled' : 'confirmed')),
														),
													]
												),
											),

											// check_in_date / check_out_date
											BookingDetailDates( booking: booking ),

											// customer
											if ( booking.imported == false )
												BookingDetailCustomer( customer: booking.customer ),
											
											if ( booking.imported == true )
												BookingDetailIcal( booking: booking ),

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
											if ( booking.imported == false )
												BookingDetailPrice( booking: booking ),

											// payments
											if ( booking.payments.length > 0 )
												Container(
													margin: const EdgeInsets.only(top: 0, bottom: 20.0),
													child: Column(
														crossAxisAlignment: CrossAxisAlignment.start,
														children: [
															Text('Payments'),
															for ( var payment in booking.payments )
																BookingDetailPayment( payment: payment ),
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
			),
		);
	}
}