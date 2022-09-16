import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mphb_app/screens/booking_detail/booking_detail.dart';
import 'package:mphb_app/screens/common/booking_date.dart';
import 'package:mphb_app/models/booking.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:mphb_app/models/enum/booking_status.dart';

class BookingListItem extends StatefulWidget {

	const BookingListItem({
		required this.index,
		required this.booking,
		required this.deleteBookingCallback,
		required this.updateBookingCallback,
		Key? key,
	}) : super(key: key);

	final Booking booking;
	final int index;
	final Function(int)? deleteBookingCallback;
	final Function(int)? updateBookingCallback;

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
			widget.updateBookingCallback?.call( widget.index );
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
					child: Column(
						crossAxisAlignment: CrossAxisAlignment.start,
						children: [
							Row(
								mainAxisAlignment: MainAxisAlignment.spaceBetween,
								children: [
									Row(
										mainAxisSize: MainAxisSize.min,
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
														BookingDate( booking.check_in_date ),
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
														BookingDate( booking.check_out_date ),
													]
												),
											),
										],
									),
									Flexible(
										child: Container(
											padding: EdgeInsets.only(top: 4.0, bottom: 4.0, left: 6.0, right: 6.0),
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
							Container(
								padding: EdgeInsets.only(top: 10.0),
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

										if ( booking.reserved_accommodations.length > 0 &&
												booking.getAccommodationByID(
													booking.reserved_accommodations[0].accommodation ) != null ) ...[
											
											Padding(
												padding: EdgeInsets.only(right: 3.0, left: 8.0),
												child: Icon(
													Icons.bed,
													size: 12,
													color: Colors.indigo.shade100
												)
											),
											Flexible(
												child: Text(
													booking.getAccommodationByID(
														booking.reserved_accommodations[0].accommodation )?.title ?? '',
													style: TextStyle(fontSize: 12,),
													overflow: TextOverflow.ellipsis,
												),
											),

											if ( booking.reserved_accommodations.length > 1 )
												Padding(
													padding: EdgeInsets.only(left: 3.0),
													child: Container(
														padding: EdgeInsets.all(3.0),
														decoration: BoxDecoration(
															shape: BoxShape.circle,
															color: Colors.indigo.shade50,
														),
														child: Text(
															'+${booking.reserved_accommodations.length - 1}',
															style: TextStyle(fontSize: 10,),
														),
													),
												),
										]
									]
								),
							),
						]
					),
				),
			),
		);
  }
}