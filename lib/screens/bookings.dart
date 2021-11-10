import 'package:flutter/material.dart';
import 'package:mphb_app/screens/booking.dart';
import 'package:mphb_app/controller/bookings_controller.dart';
import 'package:mphb_app/models/booking.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class BookingsPage extends StatefulWidget {
  @override
  _BookingListViewState createState() => _BookingListViewState();
}

class _BookingListViewState extends State<BookingsPage> {
  static const _pageSize = 10;

  final PagingController<int, Booking> _pagingController =
      PagingController(firstPageKey: 0);

	late final BookingsController _bookingsController;

	final Map<String, String> _params = {};

	@override
	void initState() {

		_bookingsController = new BookingsController( params : _params );

		_pagingController.addPageRequestListener((pageKey) {
			_fetchPage(pageKey);
		});

		super.initState();
	}

	Future<void> _fetchPage(int pageKey) async {
		try {

			final newItems = await _bookingsController.wpGetBookings(pageKey, _pageSize);
			final isLastPage = newItems.length < _pageSize;

			if (isLastPage) {
				_pagingController.appendLastPage(newItems);
			} else {

				final nextPageKey = pageKey + newItems.length;
				_pagingController.appendPage(newItems, nextPageKey);
			}
		} catch (error) {
			_pagingController.error = error;
			print(error);
		}
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
							_pagingController.refresh();
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
							child: RefreshIndicator(
								onRefresh: () => Future.sync(
									() => _pagingController.refresh(),
								),
								child: PagedListView<int, Booking>(
									pagingController: _pagingController,
									builderDelegate: PagedChildBuilderDelegate<Booking>(
										itemBuilder: (context, item, index) => MyListItem(
											booking: item,
										),
									),
								),
							),
						),
					),
				]
			),
		);
	}

	@override
	void dispose() {
		_pagingController.dispose();
		super.dispose();
	}

}
