import 'package:flutter/material.dart';
import 'package:mphb_app/screens/booking.dart';
import 'package:mphb_app/controller/bookings_controller.dart';

class BookingsPage extends StatefulWidget {

	const BookingsPage({Key? key}) : super(key: key);

	@override
	_BookingsPageState createState() => _BookingsPageState();

}

class _BookingsPageState extends State<BookingsPage> {

	late Future<List> bookings;

	@override
	void initState() {
		super.initState();

		bookings = BookingsController.wpGetBookings();
	}

	void refreshList() {
		// reload
		setState(() {
			bookings = BookingsController.wpGetBookings();
		});
	}

	@override
	Widget build(BuildContext context) {

		return Scaffold(

			appBar: AppBar(
				title: Text('Bookings'),
				actions: <Widget>[
					IconButton(
						icon: const Icon(Icons.sync),
						tooltip: 'Refresh',
						onPressed: () {
							refreshList();
						},
					),
					IconButton(
						icon: const Icon(Icons.settings),
						tooltip: 'Settings',
						onPressed: () {
							Navigator.push(context, MaterialPageRoute<void>(
								builder: (BuildContext context) {
									return Scaffold(
										appBar: AppBar(
											title: const Text('Settings'),
										),
										body: const Center(
											child: Text(
												'Settings page',
												style: TextStyle(fontSize: 24),
											),
										),
									);
								},
							));
						},
					),
				],
			),


			body: Column(
				children: [
				Expanded(
					child: Container(
						margin: const EdgeInsets.only(top: 20.0, bottom: 20.0),
						child: FutureBuilder(
							future: bookings,
							builder: (context, AsyncSnapshot snapshot) {
								if (snapshot.connectionState == ConnectionState.waiting) {
									return new Center(
										child: new CircularProgressIndicator(),
									);
								} else if (snapshot.hasError) {
									return new Text('Error: ${snapshot.error}');
								} else {

									return ListView.builder(

										itemCount: snapshot.data!.length,
										itemBuilder: (BuildContext context, int index) {

											Map booking = snapshot.data[index];

											return MyListItem(booking);
										},

										// To make listView scrollable
										// even if there is only a single item.
										physics: const AlwaysScrollableScrollPhysics(),
									);
								}
							},
						)
					),
					),
                  ]
            ),
		);
	}
}