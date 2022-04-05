import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mphb_app/models/payment.dart';

class PaymentDetailGateway extends StatelessWidget {

	const PaymentDetailGateway({required this.payment, Key? key}) : super(key: key);

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
						offset: Offset(0, 4), // changes position of shadow
					),
				],
			),
			child: Column(
				mainAxisAlignment: MainAxisAlignment.center,
				children: [
					Row(
						children: [
							Expanded(
								child: Text(
									payment.gateway_id,
									style: TextStyle(fontWeight: FontWeight.bold),
								),
							),
							if ( payment.gateway_mode == 'sandbox' )
								Text(
									payment.gateway_mode,
									style: TextStyle(
										fontSize: 12,
										color: Colors.indigo.shade100,
									),
								),
						]
					),
					if ( ! payment.transaction_id.isEmpty )
						Padding (
							padding: EdgeInsets.only(top: 10.0),
							child: Row(
								children: [
									Text(
										payment.transaction_id,
									),
									IconButton(
										icon: const Icon(Icons.content_copy, size: 14),
										tooltip: 'Copy',
										onPressed: () {
											Clipboard.setData(ClipboardData(text: payment.transaction_id))
												.then((_) {
													final snackBar = SnackBar( content: Text('${payment.transaction_id} copied') );

													ScaffoldMessenger.of(context).clearSnackBars();
													ScaffoldMessenger.of(context).showSnackBar(snackBar);
												});
										},
									),
								]
							),
						),
				],
			),
		);

	}
}