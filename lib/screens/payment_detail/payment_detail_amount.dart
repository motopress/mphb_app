import 'package:flutter/material.dart';
import 'package:mphb_app/models/payment.dart';

class PaymentDetailAmount extends StatelessWidget {

	const PaymentDetailAmount({required this.payment, Key? key}) : super(key: key);

	final Payment payment;

	@override
	Widget build(BuildContext context) {

		return Container(

			margin: const EdgeInsets.only(top: 0, bottom: 20.0),
			padding: EdgeInsets.all(20.0),
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
						offset: Offset(0, 4),
					),
				],
			),
			child: Row(
				mainAxisAlignment: MainAxisAlignment.center,
				children: [
					Expanded(
						child: Column(
							children: [
								Text(
									payment.amount.toStringAsFixed(2),
									style: TextStyle(fontWeight: FontWeight.bold),
								),
								Padding (
									padding: EdgeInsets.only(top: 5.0),
									child: Text(
										payment.currency,
										style: TextStyle(fontSize: 12),
									),
								),
							]
						)
					),
				],
			),
		);

	}
}