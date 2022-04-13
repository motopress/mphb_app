import 'package:flutter/material.dart';
import 'package:mphb_app/models/payment.dart';

class BookingDetailPayment extends StatelessWidget {

	const BookingDetailPayment({required this.payment, Key? key}) : super(key: key);

	final Payment payment;

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
						offset: Offset(0, 4),
					),
				],
			),
			child: Row(
				children: [
					Expanded(
						child: Text(payment.amount.toString() + ' ' + payment.currency,),
					),
					Expanded(
						child: Text(payment.status,),
					),
					Expanded(
						child: Text( '#' + payment.id.toString(),),
					),					
				],
			),
		);
	}
}

