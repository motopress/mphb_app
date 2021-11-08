import 'package:flutter/material.dart';
import 'package:mphb_app/wp-api.dart';
import 'package:mphb_app/screens/booking.dart';

//TODO: StatefulWidget
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

		bookings = fetchWpPosts();
	}

	@override
	Widget build(BuildContext context) {

		return Scaffold(

			body: Column(
				children: [
				Expanded(
					child: Container(
						margin: const EdgeInsets.only(top: 20.0, bottom: 20.0),
						child: FutureBuilder(
							future: bookings,
							builder: (context, AsyncSnapshot snapshot) {
								if (snapshot.hasData) {

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

								return Column(
									children: [
										CircularProgressIndicator()
									]
								);
							},
						)
					),
					),
                  ]
            ),
		);
	}
}