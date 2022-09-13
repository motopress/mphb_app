import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mphb_app/screens/booking_detail/booking_detail.dart';
import 'package:mphb_app/models/booking.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:mphb_app/models/enum/booking_status.dart';

class BookingListItem extends StatefulWidget {

	const BookingListItem({
		required this.pagingController,
		required this.index,
		required this.booking,
		required this.deleteBookingCallback,
		Key? key,
	}) : super(key: key);

	final Booking booking;
	final PagingController? pagingController;
	final int index;
	final Function(int)? deleteBookingCallback;

	void onDelete() {

		deleteBookingCallback?.call( index );
	}

	@override
	_BookingListItemState createState() => _BookingListItemState( booking: this.booking );

}

class _BookingListItemState extends State<BookingListItem> {

	_BookingListItemState({
		required this.booking
	});

	late Booking booking;

	void _showBookingDetails(BuildContext context) async {

		final Booking newBooking = await Navigator.push(context,
			MaterialPageRoute(builder: (context) => BookingDetailScreen(
				booking: booking, onDelete: widget.onDelete
			)),
		);

		/*
		 * https://github.com/EdsonBueno/infinite_scroll_pagination/issues/17
		 */
		if ( widget.booking.status != newBooking.status ) {
			widget.booking.status = newBooking.status;
			widget.pagingController?.notifyListeners();
		}
	}

	@override
	Widget build(BuildContext context) {

		return Container(
			decoration: BoxDecoration(
				color: Colors.white,
				borderRadius: BorderRadius.all(
					Radius.circular(6)
				),
				boxShadow: [
					BoxShadow(
						color: Colors.grey.withOpacity(0.1),
						spreadRadius: 0,
						blurRadius: 2,
						offset: Offset(0, 2),
					),
				],
			),
			margin: EdgeInsets.only(bottom: 10.0),
			child: InkWell(
				onTap: () {
					_showBookingDetails(context);
				},
				child: Padding(
					padding: EdgeInsets.all(15),
					child: Row(
						mainAxisAlignment: MainAxisAlignment.spaceBetween,
						children: [
							Column(
								crossAxisAlignment: CrossAxisAlignment.start,
								children: [
									Row(
										children: [
											Padding(
												padding: EdgeInsets.only(right: 10.0),
												child: Row(
													children: [
														Padding(
															padding: EdgeInsets.only(right: 5.0),
															child: Icon(
																Icons.flight_land,
																size: 12,
																color: Colors.indigo.shade100
															)
														),
														Text(
															booking.check_in_date,
															style: TextStyle(fontWeight: FontWeight.bold),
														),
													]
												),
											),
											Padding(
												padding: EdgeInsets.only(right: 10.0),
												child: Row(
													children: [
														Padding(
															padding: EdgeInsets.only(right: 5.0),
															child: Icon(
																Icons.flight_takeoff,
																size: 12,
																color: Colors.indigo.shade100
															)
														),
														Text(
															booking.check_out_date,
															style: TextStyle(fontWeight: FontWeight.bold),
														),
													]
												),
											),
										]
									),
									Container(
										padding: EdgeInsets.only(top: 15.0),
										child: Row(
											children: [
												Padding(
													padding: EdgeInsets.only(right: 1.0),
													child: Icon(
														Icons.tag,
														size: 12,
														color: Colors.indigo.shade100
													)
												),
												Text(
													booking.id.toString(),
													style: TextStyle(
														fontSize: 12,
													),
												),
												Padding(
													padding: EdgeInsets.only(right: 3.0, left: 8.0),
													child: Icon(
														Icons.event_available,
														size: 12,
														color: Colors.indigo.shade100
													)
												),
												Text(
													DateFormat('yyyy-MM-dd').format(
														DateTime.parse(booking.date_created) ),
													style: TextStyle(
														fontSize: 12,
													),
												),

												if ( booking.imported == true )
													Row(
														children: [
															Padding(
																padding: EdgeInsets.only(right: 2.0, left: 8.0),
																child: Icon(
																	Icons.import_export,
																	size: 12,
																	color: Colors.indigo.shade100
																)
															),
															Text(
																'Imported',
																style: TextStyle(
																	fontSize: 12,
																),
															),
														]
													),

												if ( booking.imported == false )
													Row(
														children: [
															Padding(
																padding: EdgeInsets.only(right: 0.0, left: 8.0),
																child: Icon(
																	Icons.attach_money,
																	size: 12,
																	color: Colors.indigo.shade100
																)
															),
															Text(
																booking.total_price.toString(),
																style: TextStyle(
																	fontSize: 12,
																),
															),
														]
													),
											]
										),
									),
								]
							),
							Flexible(
								child: Container(
									padding: EdgeInsets.only(top: 6.0, bottom: 6.0, left: 6.0, right: 6.0),
									decoration: ShapeDecoration(
										shape: RoundedRectangleBorder(
											borderRadius: BorderRadius.all(
												Radius.circular(4)
											)
										),
										color:
											booking.status == BookingStatusEnum.CONFIRMED ?
												Colors.green
											: (booking.status == BookingStatusEnum.CANCELLED) ?
												Colors.orange
											:  Colors.blueGrey,
									),
									child: Text(
										booking.status,
										style: TextStyle(color: Colors.white, fontSize: 12),
										overflow: TextOverflow.ellipsis,
									),
								),
							),
						]
					),
				),
			),
		);
  }
}