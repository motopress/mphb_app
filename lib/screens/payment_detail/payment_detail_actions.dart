import 'package:flutter/material.dart';
import 'package:mphb_app/models/payment.dart';
import 'package:mphb_app/models/enum/payment_status.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PaymentDetailActions extends StatelessWidget {

	const PaymentDetailActions({required this.payment, Key? key}) : super(key: key);

	final Payment payment;

	@override
	Widget build(BuildContext context) {

		return Wrap(
			children: [
				ListTile(
					leading: Icon(Icons.done),
					title: Text(AppLocalizations.of(context).paymentSetToCompletedButtonText),
					onTap: () {
						Navigator.pop(context, PaymentStatusEnum.COMPLETED);
					},
				),
				ListTile(
					leading: Icon(Icons.block),
					title: Text(AppLocalizations.of(context).paymentSetToCanceledButtonText),
					onTap: () {
						Navigator.pop(context, PaymentStatusEnum.CANCELLED);
					},
				),
				ListTile(
					leading: Icon(Icons.hourglass_empty),
					title: Text(AppLocalizations.of(context).paymentSetToOnHoldButtonText),
					onTap: () {
						Navigator.pop(context, PaymentStatusEnum.ON_HOLD);
					},
				),
				ListTile(
					leading: Icon(Icons.hourglass_empty),
					title: Text(AppLocalizations.of(context).paymentSetToPendingButtonText),
					onTap: () {
						Navigator.pop(context, PaymentStatusEnum.PENDING);
					},
				),
				ListTile(
					leading: Icon(Icons.block),
					title: Text(AppLocalizations.of(context).paymentSetToFailedButtonText),
					onTap: () {
						Navigator.pop(context, PaymentStatusEnum.FAILED);
					},
				),
				ListTile(
					leading: Icon(Icons.block),
					title: Text(AppLocalizations.of(context).paymentSetToRefundedButtonText),
					onTap: () {
						Navigator.pop(context, PaymentStatusEnum.REFUNDED);
					},
				),
			],
		);

	}
}