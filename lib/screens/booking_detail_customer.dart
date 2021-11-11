import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
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
				padding: EdgeInsets.all(10.0),
				child: Row(
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
										if ( !customer.phone.isEmpty )
											TextButton(
												style: ButtonStyle(
													foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
												),
												onPressed: () {
													launch(('tel://${customer.phone}'));
												},
												child: Text('Call'),
											),
										if ( !customer.email.isEmpty )
											TextButton(
												style: ButtonStyle(
													foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
												),
												onPressed: () {

													final Uri _emailLaunchUri = Uri(
														scheme: 'mailto',
														path: customer.email,
													);

													launch(_emailLaunchUri.toString());

												},
												child: Text('Email'),
											),
									]
								),
								Row(
									children: [
										Column(
											crossAxisAlignment: CrossAxisAlignment.start,
											children: [
												if ( !customer.email.isEmpty )
													Padding(
														padding: EdgeInsets.only(top: 5.0),
														child: Text(customer.email,),
													),
												if ( !customer.phone.isEmpty )
													Padding(
														padding: EdgeInsets.only(top: 5.0),
														child: Text(customer.phone,),
													),
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

