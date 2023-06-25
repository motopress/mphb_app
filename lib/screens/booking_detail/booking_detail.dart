import 'package:flutter/material.dart';
import 'package:mphb_app/controller/booking_controller.dart';
import 'package:mphb_app/models/booking.dart';
import 'package:mphb_app/screens/booking_detail/booking_detail_actions.dart';
import 'package:mphb_app/screens/booking_detail/booking_detail_status.dart';
import 'package:mphb_app/screens/booking_detail/booking_detail_dates.dart';
import 'package:mphb_app/screens/booking_detail/booking_detail_customer.dart';
import 'package:mphb_app/screens/booking_detail/booking_detail_accommodation.dart';
import 'package:mphb_app/screens/booking_detail/booking_detail_price.dart';
import 'package:mphb_app/screens/booking_detail/booking_detail_payment.dart';
import 'package:mphb_app/screens/booking_detail/booking_detail_ical.dart';
import 'package:mphb_app/screens/booking_detail/booking_detail_note.dart';
import 'package:mphb_app/screens/booking_detail/booking_detail_internal_notes.dart';
import 'package:sprintf/sprintf.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class BookingDetailScreen extends StatefulWidget {

	const BookingDetailScreen({
		Key? key,
		required this.booking,
		required this.onDelete,
	}) : super(key: key);

	final Booking booking;
	final VoidCallback onDelete;

	@override
	_BookingDetailScreenState createState() => _BookingDetailScreenState( bookingID: this.booking.id );

}

class _BookingDetailScreenState extends State<BookingDetailScreen> {

	_BookingDetailScreenState({
		required this.bookingID
	});

	late final BookingController _bookingController;

	late Future<Booking> _bookingFuture;

	final int bookingID;

	@override
	void initState() {

		_bookingController = new BookingController();

		_bookingFuture = _getBooking( bookingID );

		super.initState();
	}

	Future<Booking> _getBooking( int id ) {

		var bookingFuture;

		try {

			bookingFuture = _bookingController.wpGetBooking( id );

		} catch (error) {

			bookingFuture = null;

			ScaffoldMessenger.of(context).showSnackBar(
				SnackBar(content: Text(error.toString()))
			);
		}

		return bookingFuture;
	}

	void deleteBooking( Booking booking ) async {

		try {

			Booking deletedBooking = await _bookingController.wpDeleteBooking(booking.id);

			ScaffoldMessenger.of(context).showSnackBar(
				SnackBar(content: Text(sprintf(AppLocalizations.of(context).bookingDeletedMessage, [deletedBooking.id])))
			);

			Navigator.maybePop(context);
			widget.onDelete();

		} catch (error) {

			ScaffoldMessenger.of(context).showSnackBar(
				SnackBar(content: Text(error.toString()))
			);
		}
	}

	_showModalBottomSheet ( BuildContext context, Booking booking ) {

		showModalBottomSheet(
			context: context,
			builder: (context) {
				return BookingDetailActions( booking: booking );
			},

		).then((action) {

			if ( action != null ) {

				switch ( action ) {

					case 'delete':
						deleteBooking( booking );
						break;

					default:
						try {

							setState(() {
								_bookingFuture =
									_bookingController.wpUpdateBookingStatus(
										booking, action );
							});

						} catch (error) {

							ScaffoldMessenger.of(context).showSnackBar(
								SnackBar(content: Text(error.toString()))
							);
						}
						break;
				}
			}
		});
	}

	@override
	Widget build(BuildContext context) {

		return WillPopScope(
			child: Scaffold(
				appBar: AppBar(
					title: Text( AppLocalizations.of(context).bookingLabelText + ' #$bookingID' ),
					actions: <Widget>[
						IconButton(
							icon: const Icon(Icons.sync),
							tooltip: AppLocalizations.of(context).refreshTootlipText,
							onPressed: () {
								setState(() {
									_bookingFuture = _getBooking( bookingID );
								});
							},
						),
						FutureBuilder(
							future: _bookingFuture,
							builder: (context, AsyncSnapshot snapshot) {
								if (snapshot.connectionState == ConnectionState.waiting) {
									return new Center(
										child: Padding(
											padding: const EdgeInsets.all(14),
											child: SizedBox(
												child: CircularProgressIndicator(
													color: Colors.black,
													strokeWidth: 2.0,
												),
												height: 20.0,
												width: 20.0,
											),
										),
									);
								} else if (snapshot.hasError) {
									return new Container();
								} else {

									Booking booking = snapshot.data;

									return IconButton(
										icon: const Icon(Icons.more_vert),
										tooltip: AppLocalizations.of(context).actionsTooltipText,
										onPressed: () => _showModalBottomSheet( context, booking ),
									);
								}
							}
						),
					],
				),
				body: FutureBuilder(
					future: _bookingFuture,
					initialData: widget.booking,
					builder: (context, AsyncSnapshot snapshot) {

						if (snapshot.hasError) {

							return new Center(child: Text(AppLocalizations.of(context).errorText + ': ${snapshot.error}') );

						} else {

							Booking booking = snapshot.data;

							return RefreshIndicator(
								onRefresh: () => Future.sync(
									() => setState(() {
										_bookingFuture = _getBooking( bookingID );
									}),
								),
								child: SingleChildScrollView(
									physics: AlwaysScrollableScrollPhysics(),
									child: Container(
										padding: const EdgeInsets.fromLTRB(20, 30, 20, 20),
										child: Column(
											children: [
												// booking id + status
												BookingDetailStatus( booking: booking ),

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
															Text(AppLocalizations.of(context).reservationText),
															for (
																	var reserved_accommodation
																	in booking.reserved_accommodations
															)

																BookingDetailAccommodation(
																	reserved_accommodation:
																		reserved_accommodation,
																	booking: booking
																),
															//end:for
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
																Text(AppLocalizations.of(context).paymentsLabelText),
																for ( var payment in booking.payments )
																	BookingDetailPayment( payment: payment ),
															],
														),
													),
												//note
												if ( ! booking.note.isEmpty )
													Container(
														margin: const EdgeInsets.only(top: 0, bottom: 20.0),
														child: Column(
															crossAxisAlignment: CrossAxisAlignment.start,
															children: [
																Text(AppLocalizations.of(context).customerNoteText),
																BookingDetailNote( booking: booking ),
															],
														),
													),
												//internal notes
												if ( ! booking.internal_notes.isEmpty )
													Container(
														margin: const EdgeInsets.only(top: 0, bottom: 20.0),
														child: Column(
															crossAxisAlignment: CrossAxisAlignment.start,
															children: [
																Text(AppLocalizations.of(context).internalNotesText),
																BookingDetailInternalNotes( booking: booking ),
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
			),
			onWillPop: () async {
				Navigator.pop(context, _bookingFuture);
				return false;
			}
		);
	}
}
