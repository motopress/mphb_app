import 'package:flutter/material.dart';
import 'package:mphb_app/models/booking.dart';
import 'package:mphb_app/models/enum/booking_status.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class BookingDetailActions extends StatelessWidget {

	const BookingDetailActions({required this.booking, Key? key}) : super(key: key);

	final Booking booking;

	@override
	Widget build(BuildContext context) {

		return Wrap(
			children: [
				ListTile(
					leading: Icon(Icons.done),
					title: Text(AppLocalizations.of(context).bookingSetToConfirmedButtonText),
					onTap: () {
						Navigator.pop(context, BookingStatusEnum.CONFIRMED);
					},
				),
				ListTile(
					leading: Icon(Icons.block),
					title: Text(AppLocalizations.of(context).bookingSetToCanceledButtonText),
					onTap: () {
						Navigator.pop(context, BookingStatusEnum.CANCELLED);
					},
				),
				ListTile(
					leading: Icon(Icons.hourglass_empty),
					title: Text(AppLocalizations.of(context).bookingSetToPendingAdminButtonText),
					onTap: () {
						Navigator.pop(context, BookingStatusEnum.PENDING);
					},
				),
				ListTile(
					leading: Icon(Icons.mail_outline),
					title: Text(AppLocalizations.of(context).bookingSetToPendingUserConfirmationButtonText),
					onTap: () {
						Navigator.pop(context, BookingStatusEnum.PENDING_USER);
					},
				),
				ListTile(
					leading: Icon(Icons.payment),
					title: Text(AppLocalizations.of(context).bookingSetToPendingPaymentButtonText),
					onTap: () {
						Navigator.pop(context, BookingStatusEnum.PENDING_PAYMENT);
					},
				),
				Divider(),
				ListTile(
					leading: Icon(Icons.delete),
					title: Text(AppLocalizations.of(context).deleteButtonText),
					onTap: () {
						Navigator.pop(context, 'delete');
					},
				),
			],
		);

	}
}