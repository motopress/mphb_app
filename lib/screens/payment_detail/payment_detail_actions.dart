import 'package:flutter/material.dart';
import 'package:mphb_app/models/payment.dart';
import 'package:mphb_app/models/enum/payment_status.dart';

class PaymentDetailActions extends StatelessWidget {

	const PaymentDetailActions({required this.payment, Key? key}) : super(key: key);

	final Payment payment;

	@override
	Widget build(BuildContext context) {

		return Wrap(
			children: [
				ListTile(
					leading: Icon(Icons.done),
					title: Text('Set to Completed'),
					onTap: () {
						Navigator.pop(context, PaymentStatusEnum.COMPLETED);
					},
				),
				ListTile(
					leading: Icon(Icons.block),
					title: Text('Set to Cancelled'),
					onTap: () {
						Navigator.pop(context, PaymentStatusEnum.CANCELLED);
					},
				),
				ListTile(
					leading: Icon(Icons.hourglass_empty),
					title: Text('Set to On Hold'),
					onTap: () {
						Navigator.pop(context, PaymentStatusEnum.ON_HOLD);
					},
				),
				ListTile(
					leading: Icon(Icons.hourglass_empty),
					title: Text('Set to Pending'),
					onTap: () {
						Navigator.pop(context, PaymentStatusEnum.PENDING);
					},
				),
				ListTile(
					leading: Icon(Icons.block),
					title: Text('Set to Failed'),
					onTap: () {
						Navigator.pop(context, PaymentStatusEnum.FAILED);
					},
				),
				ListTile(
					leading: Icon(Icons.block),
					title: Text('Set to Refunded'),
					onTap: () {
						Navigator.pop(context, PaymentStatusEnum.REFUNDED);
					},
				),
			],
		);

	}
}