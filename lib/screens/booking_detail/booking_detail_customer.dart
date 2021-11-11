import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:mphb_app/models/customer.dart';

class BookingDetailCustomer extends StatelessWidget {

	const BookingDetailCustomer({required this.customer, Key? key}) : super(key: key);

	final Customer customer;

	@override
	Widget build(BuildContext context) {
		return Container(

			padding: EdgeInsets.all(20.0),
			margin: const EdgeInsets.only(top: 20.0, bottom: 20.0),
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
				crossAxisAlignment: CrossAxisAlignment.start,
				children: [
					Row(
						mainAxisSize: MainAxisSize.min,
						children: [
							Padding(
								padding: EdgeInsets.only(right: 10.0),
								child: Icon(
									Icons.person,
									size: 16
								)
							),

							Flexible(
								child: Text(
									customer.first_name + ' ' + customer.last_name,
									style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
									//overflow: TextOverflow.ellipsis,
								),
							),

							if ( !customer.phone.isEmpty )
								Padding(
									padding: EdgeInsets.only(left: 10.0),
									child: OutlinedButton(
										onPressed: () {
											launch(('tel://${customer.phone}'));
										},
										child: Text('Call'),
									),
								),
							if ( !customer.email.isEmpty )
								Padding(
									padding: EdgeInsets.only(left: 10.0),
									child: OutlinedButton(
										onPressed: () {

											final Uri _emailLaunchUri = Uri(
												scheme: 'mailto',
												path: customer.email,
											);

											launch(_emailLaunchUri.toString());

										},
										child: Text('Email'),
									),
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
		);
	}
}

