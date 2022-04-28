import 'package:flutter/material.dart';
import 'package:mphb_app/models/booking.dart';

class BookingDetailPrice extends StatelessWidget {

	const BookingDetailPrice({required this.booking, Key? key}) : super(key: key);

	final Booking booking;

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
			child: Column(
				children: [
					Row(
						mainAxisAlignment: MainAxisAlignment.center,
						children: [
							Expanded(
								child: Column(
									children: [
										Text(
											booking.total_price.toStringAsFixed(2),
											style: TextStyle(
												fontSize: 16,
												fontWeight: FontWeight.bold,
												color: Colors.indigo
											),
										),
										Padding (
											padding: EdgeInsets.only(top: 5.0),
											child: Text(
												'Total',
												style: TextStyle(fontSize: 12),
											),
										),
									]
								)
							),
							Expanded(
								child: Column(
									children: [
										Text(
											booking.getPaid().toStringAsFixed(2),
											style: TextStyle(
												fontSize: 16,
												fontWeight: FontWeight.bold,
												color: booking.total_price == booking.getPaid() ?
													Colors.green : Colors.indigo
											),
										),
										Padding (
											padding: EdgeInsets.only(top: 5.0),
											child: Text(
												'Paid',
												style: TextStyle(fontSize: 12),
											),
										),
									]
								)
							),
							Expanded(
								child: Column(
									children: [
										Text(
											booking.getToPay().toStringAsFixed(2),
											style: TextStyle(
												fontSize: 16,
												fontWeight: FontWeight.bold,
												color: booking.getToPay() > 0 ?
													Colors.red : Colors.grey
											),
										),
										Padding (
											padding: EdgeInsets.only(top: 5.0),
											child: Text(
												'To Pay',
												style: TextStyle(fontSize: 12),
											),
										),
									]
								)
							),
						],
					),
					if ( ! booking.coupon_code.isEmpty )
						Padding(
							padding: EdgeInsets.only(top: 20.0),
							child: Text(
								'Coupon code used: ${booking.coupon_code}',
								style: TextStyle(fontSize: 12),
							),
						),
					//endif
				],
			),
		);

	}
}