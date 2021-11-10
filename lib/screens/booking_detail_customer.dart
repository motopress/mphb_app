import 'package:flutter/material.dart';
import 'package:mphb_app/models/customer.dart';

class BookingDetailCustomer extends StatelessWidget {

	const BookingDetailCustomer({required this.customer, Key? key}) : super(key: key);

	final Customer customer;

	@override
	Widget build(BuildContext context) {
		return Container(

			margin: const EdgeInsets.only(top: 20.0, bottom: 20.0),
			decoration: ShapeDecoration(
				shape: RoundedRectangleBorder(
					borderRadius: BorderRadius.all(
						Radius.circular(4)
					)
				),
				color: Colors.blueGrey.shade50,
			),
			child: Padding(
				padding: EdgeInsets.all(20.0),
				child: Row(
					crossAxisAlignment: CrossAxisAlignment.start,
					children: [
						Column(
							crossAxisAlignment: CrossAxisAlignment.start,
							children: [
								Row(
									children: [
										Padding(
											padding: EdgeInsets.only(right: 10.0),
											child: Icon(
												Icons.person,
												size: 16
											)
										),
										Text(
											customer.first_name + ' ' + customer.last_name,
											style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
										),
										TextButton(
											style: ButtonStyle(
												foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
											),
											onPressed: () { },
											child: Text('Call'),
										),
										TextButton(
											style: ButtonStyle(
												foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
											),
											onPressed: () { },
											child: Text('Email'),
										),
									]
								),
								Row(
									children: [
										Column(
											crossAxisAlignment: CrossAxisAlignment.start,
											children: [
												SizedBox(height: 10),
												Text(customer.email,),
												SizedBox(height: 10),
												Text(customer.phone,),
											]
										),
										Column(
											crossAxisAlignment: CrossAxisAlignment.start,
											children: [

											]
										),
									]
								),
								
							]
						),
					]
				)
			),

		);
	}
}

