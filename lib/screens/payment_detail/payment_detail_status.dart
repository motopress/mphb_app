import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mphb_app/models/payment.dart';
import 'package:mphb_app/models/enum/payment_status.dart';

class PaymentDetailStatus extends StatelessWidget {

	const PaymentDetailStatus({required this.payment, Key? key}) : super(key: key);

	final Payment payment;

	@override
	Widget build(BuildContext context) {

		return Container(
			margin: const EdgeInsets.only(bottom: 20.0),
			child: Row(
				mainAxisAlignment: MainAxisAlignment.spaceBetween,
				children: [
					Column(
						crossAxisAlignment: CrossAxisAlignment.start,
						children: [
							Text(
								'Payment #' + payment.id.toString(),
								style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
							),
							Padding (
								padding: EdgeInsets.only(top: 5.0),
								child: Text(
									DateFormat('yyyy-MM-dd HH:mm').format( DateTime.parse(payment.date_created) ),
									style: TextStyle(fontSize: 12),
								),
							),
						],
					),
					Container(
						decoration: BoxDecoration(
							borderRadius: BorderRadius.all(Radius.circular(4)),
							color:
								(payment.status == PaymentStatusEnum.COMPLETED || payment.status == PaymentStatusEnum.ON_HOLD) ?
									Colors.green
								: (payment.status == PaymentStatusEnum.CANCELLED || payment.status == PaymentStatusEnum.REFUNDED) ?
									Colors.orange
								:  Colors.blueGrey,
						),
						padding: const EdgeInsets.only(top: 10, bottom: 10, left: 10.0, right: 10.0),
						child: Text(
							payment.status,
							style: TextStyle(
								color: Colors.white,
								fontSize: 16,
							),
						),
					),
				]
			),
		);

	}
}