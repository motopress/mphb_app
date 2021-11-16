import 'package:flutter/material.dart';
import 'package:mphb_app/models/reserved_service.dart';
import 'package:mphb_app/models/service.dart';
import 'package:mphb_app/models/booking.dart';

class BookingDetailService {

	static TableRow buildTableRow(Reserved_Service reserved_service, Booking booking) {

		return TableRow(
			key: ValueKey(reserved_service.id),
			children: [

				TableCell(
					child: Padding(
						padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
						child: Text(
							booking.getServiceByID(reserved_service.id)?.title ?? reserved_service.id.toString(),
						),
					),
				),
				TableCell(
					child: Padding(
						padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
						child: Text( reserved_service.adults != null ? reserved_service.adults.toString() + ' guest(s)' : ''),
					),
				),
				TableCell(
					child: Padding(
						padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
						child: Text( reserved_service.quantity != null ? reserved_service.quantity.toString() + ' time(s)' : '' ),
					),
				),
			]
		);
	}
}
