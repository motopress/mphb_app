import 'package:flutter/material.dart';
import 'package:mphb_app/models/reserved_accommodation.dart';
import 'package:mphb_app/models/reserved_service.dart';
import 'package:mphb_app/models/service.dart';
import 'package:mphb_app/models/booking.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class BookingDetailServices extends StatelessWidget {

	const BookingDetailServices({
		required this.reserved_accommodation,
		required this.booking,
		Key? key
	}) : super(key: key);

	final Booking booking;

	final Reserved_Accommodation reserved_accommodation;

	@override
	Widget build(BuildContext context) {

		return Container(
			margin: const EdgeInsets.only(top: 0.0, bottom: 10.0),
			child: Table(
				border: TableBorder(
					horizontalInside: BorderSide(
						width: 1,
						color: Colors.grey.shade100,
						style: BorderStyle.solid)
				),
				columnWidths: const <int, TableColumnWidth>{
					0: FlexColumnWidth(),
					1: IntrinsicColumnWidth(),
					2: IntrinsicColumnWidth(),
				},
				defaultVerticalAlignment: TableCellVerticalAlignment.middle,
				children: reserved_accommodation.services.map(
					(item) => buildTableRow(context, item, booking)
				).toList(),
			),
		);

	}

	TableRow buildTableRow(BuildContext context, Reserved_Service reserved_service, Booking booking) {

		return TableRow(
			key: ValueKey(reserved_service.id),
			children: [

				TableCell(
					child: Padding(
						padding: const EdgeInsets.only(right: 10.0, top: 10.0, bottom: 10.0),
						child: Text(
							booking.getServiceByID(reserved_service.id)?.title ??
								reserved_service.id.toString(),
						),
					),
				),
				TableCell(
					child: Padding(
						padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
						child: Text(
							reserved_service.adults != null ?
								'x ' + reserved_service.adults.toString() + ' ' + AppLocalizations.of(context).guestsText : '',
							style: TextStyle(fontStyle: FontStyle.italic),
						),
					),
				),
				TableCell(
					child: Padding(
						padding: const EdgeInsets.only(left: 10.0, top: 10.0, bottom: 10.0),
						child: Text(
							reserved_service.quantity != null ?
								'x ' + reserved_service.quantity.toString() + ' '+ AppLocalizations.of(context).timesText :
									(
										booking.getServiceByID(
											reserved_service.id)?.periodicity['typeof'] == 'once' ?
												AppLocalizations.of(context).onceText : AppLocalizations.of(context).dailyText
									),
							style: TextStyle(fontStyle: FontStyle.italic),
						),
					),
				),
			]
		);
	}
}
