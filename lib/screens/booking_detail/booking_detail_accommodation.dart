import 'package:flutter/material.dart';
import 'package:mphb_app/screens/booking_detail/booking_detail_services.dart';
import 'package:mphb_app/models/accommodation.dart';
import 'package:mphb_app/models/accommodation_type.dart';
import 'package:mphb_app/models/reserved_accommodation.dart';
import 'package:mphb_app/models/booking.dart';

class BookingDetailAccommodation extends StatelessWidget {

	const BookingDetailAccommodation({
		required this.reserved_accommodation,
		required this.booking,
		Key? key
	}) : super(key: key);

	final Reserved_Accommodation reserved_accommodation;

	final Booking booking;

	@override
	Widget build(BuildContext context) {

		return Container(

			padding: EdgeInsets.all(20.0),
			margin: const EdgeInsets.only(top: 10.0),
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
						offset: Offset(0, 4), // changes position of shadow
					),
				],
			),
			child: Column(
				crossAxisAlignment: CrossAxisAlignment.start,
				children: [
					Row(
						crossAxisAlignment: CrossAxisAlignment.start,
						children: [
							Expanded(
								child: Column(
									crossAxisAlignment: CrossAxisAlignment.start,
									children: [
										if ( booking.getAccommodationByID( reserved_accommodation.accommodation ) != null ) ...[
											Text(
												booking.getAccommodationByID( reserved_accommodation.accommodation )?.title ?? '',
												style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
											),
										] else ...[
											Text(
												reserved_accommodation.accommodation.toString(),
												style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
											),
										],
										if ( booking.getAccommodationTypeByID( reserved_accommodation.accommodation_type ) != null )
											Padding(
												padding: EdgeInsets.only(top: 5.0),
												child: Text(
													booking.getAccommodationTypeByID( reserved_accommodation.accommodation_type )?.title ?? '',
													style: TextStyle(fontSize: 12),
												),
											),
									]
								)
							),
							Container(
								padding: EdgeInsets.only(left: 10.0),
								child: Column(
									mainAxisSize: MainAxisSize.min,
									children: [
										Text(
											reserved_accommodation.adults.toString(),
											style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
										),
										Text(
											'adults',
											style: TextStyle(fontSize: 11),
										),
									]
								),
							),
							if ( reserved_accommodation.children > 0 )
								Container(
									padding: EdgeInsets.only(left: 10.0),
									child: Column(
										mainAxisSize: MainAxisSize.min,
										children: [
											Text(
												reserved_accommodation.children.toString(),
												style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
											),
											Text(
												'children',
												style: TextStyle(fontSize: 11),
											),
										]
									),
								),
						]
					),

					//rate
					if ( reserved_accommodation.rate > 0 )
						Padding (
							padding: EdgeInsets.only(top: 10.0),
							child: ListTileTheme(
								dense: true,
								contentPadding: EdgeInsets.zero,
								minVerticalPadding: 0,
								child: ExpansionTile(
									tilePadding: EdgeInsets.zero,
									childrenPadding: EdgeInsets.zero,
									title: Text(
										'Rate: ' + (booking.getRateByID( reserved_accommodation.rate )?.title ?? '-'),
										style: DefaultTextStyle.of(context).style
									),
									children: List.generate(1,(index){
										return Padding (
											padding: EdgeInsets.only(bottom: 10.0),
											child: Text(
												booking.getRateByID( reserved_accommodation.rate )?.description ?? ''
											),
										);
									}),
								),
							),
						),

					// services
					if ( reserved_accommodation.services.length > 0 )
						Padding (
							padding: EdgeInsets.only(top: 0.0),
							child: ListTileTheme(
								dense: true,
								contentPadding: EdgeInsets.zero,
								minVerticalPadding: 0,
								child: ExpansionTile(
									tilePadding: EdgeInsets.zero,
									childrenPadding: EdgeInsets.zero,
									title: Text(
										'Services (' + reserved_accommodation.services.length.toString() + ')',
										style: DefaultTextStyle.of(context).style
									),
									children: List.generate(1,(index){
										return BookingDetailServices(
											reserved_accommodation: reserved_accommodation,
											booking: booking,
										);
									}),
								),
							),
						),
				],
			),
		);
	}
}

