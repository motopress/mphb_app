import 'package:flutter/material.dart';
import 'package:mphb_app/wp-api.dart';
import 'package:mphb_app/screens/booking.dart';

//TODO: StatefulWidget
class MyHomePage extends StatelessWidget {

	@override
	Widget build(BuildContext context) {
		return Scaffold(

		appBar: AppBar(
			backgroundColor: Color(0xff353353),
			title: Text('Bookings'),
			actions: <Widget>[
				IconButton(
					icon: const Icon(Icons.sync),
					tooltip: 'Refresh',
					onPressed: () {
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
						child: FutureBuilder(
							future: fetchWpPosts(),
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