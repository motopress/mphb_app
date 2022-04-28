import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:mphb_app/models/customer.dart';

class BookingDetailCustomer extends StatelessWidget {

	const BookingDetailCustomer({required this.customer, Key? key}) : super(key: key);

	final Customer customer;

	String _getAddress() {

		List<String> parts = [
			customer.address1,
			customer.city,
			customer.state,
			customer.zip,
			customer.country,
		];

		parts.removeWhere((value) => value == '');

		return parts.join(', ');
	}

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
						offset: Offset(0, 4),
					),
				],
			),
			child: Column(
				crossAxisAlignment: CrossAxisAlignment.start,
				children: [
					Row(
						mainAxisSize: (customer.first_name  + customer.last_name).isEmpty ?
							MainAxisSize.max : MainAxisSize.min,
						children: [
							Padding(
								padding: EdgeInsets.only(right: 6.0),
								child: Icon(
									Icons.person,
									size: 16,
									color: Colors.indigo.shade100
								)
							),

							if ( (customer.first_name  + customer.last_name).isEmpty )
								Text(
									'not set',
									style: TextStyle(fontStyle: FontStyle.italic),
								),
							//endif

							Flexible(
								child: Text(
									customer.first_name + ' ' + customer.last_name,
									style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
								),
							),
						]
					),
					if ( ! customer.email.isEmpty )
						Padding(
							padding: EdgeInsets.only(top: 10.0),
							child: Row(
								mainAxisSize: MainAxisSize.min,
								children: [
									Padding(
										padding: EdgeInsets.only(right: 10.0),
										child: Icon(
											Icons.email,
											size: 12,
											color: Colors.indigo.shade100
										)
									),
									Expanded(
										child: Text(
											customer.email,
											style: TextStyle(fontSize: 14),
										),
									),
									IconButton(
										icon: const Icon(Icons.content_copy),
										iconSize: 14,
										onPressed: () {
											Clipboard.setData(
												ClipboardData(text: customer.email))
												.then((_) {

													final snackBar = SnackBar(
														content: Text(
															'${customer.email} copied'
														)
													);
													
													ScaffoldMessenger.of(context).
														clearSnackBars();
													ScaffoldMessenger.of(context).
														showSnackBar(snackBar);
												});
										},
									),
									Padding(
										padding: EdgeInsets.only(left: 10.0),
										child: OutlinedButton(
											child: const Icon(Icons.email, size: 14.0),
											onPressed: () {

												final Uri _emailLaunchUri = Uri(
													scheme: 'mailto',
													path: customer.email,
												);

												launch(_emailLaunchUri.toString());

											},
										),
									),
								],
							),
						),
					//endif

					if ( ! customer.phone.isEmpty )
						Padding(
							padding: EdgeInsets.only(top: 0.0),
							child: Row(
								mainAxisSize: MainAxisSize.min,
								children: [
									Padding(
										padding: EdgeInsets.only(right: 10.0),
										child: Icon(
											Icons.call,
											size: 12,
											color: Colors.indigo.shade100
										)
									),
									Expanded(
										child: Text(
											customer.phone,
											style: TextStyle(fontSize: 14),
										),
									),
									IconButton(
										icon: const Icon(Icons.content_copy),
										iconSize: 14,
										tooltip: 'Copy',
										onPressed: () {
											Clipboard.setData(
												ClipboardData(text: customer.phone))
												.then((_) {

													final snackBar = SnackBar(
														content: Text(
															'${customer.phone} copied'
														)
													);

													ScaffoldMessenger.of(context).
														clearSnackBars();
													ScaffoldMessenger.of(context).
														showSnackBar(snackBar);
												});
										},
									),
									Padding(
										padding: EdgeInsets.only(left: 10.0),
										child: OutlinedButton(
											onPressed: () {
												launch(('tel://${customer.phone}'));
											},
											child: const Icon(Icons.call, size: 14.0),
										),
									),
								],
							),
						),
					//endif
					if ( ! _getAddress().isEmpty )
						Padding(
							padding: EdgeInsets.only(top: 10.0),
							child: Row(
								mainAxisSize: MainAxisSize.min,
								children: [
									Padding(
										padding: EdgeInsets.only(right: 10.0),
										child: Icon(
											Icons.map,
											size: 12,
											color: Colors.indigo.shade100
										)
									),
									Expanded(
										child: Text(
											_getAddress()
										),
									),
								],
							),
						)
					//endif
				]
			),
		);
	}
}

