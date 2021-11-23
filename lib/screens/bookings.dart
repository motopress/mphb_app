import 'package:flutter/material.dart';
import 'package:mphb_app/screens/bookings/booking_list_item.dart';
import 'package:mphb_app/screens/bookings/bookings_filter.dart';
import 'package:mphb_app/controller/bookings_controller.dart';
import 'package:mphb_app/models/booking.dart';
import 'package:mphb_app/models/bookings_filters.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class BookingsPage extends StatefulWidget {
  @override
  _BookingsListViewState createState() => _BookingsListViewState();
}

class _BookingsListViewState extends State<BookingsPage> {

	static const _pageSize = 10;

	final PagingController<int, Booking> _pagingController =
		PagingController(firstPageKey: 0);

	late final BookingsController _bookingsController;

	late Bookings_Filters _bookings_filters;

	@override
	void initState() {
		super.initState();

		_bookingsController = new BookingsController();

		_bookings_filters = new Bookings_Filters();

		_pagingController.addPageRequestListener((pageKey) {
			_fetchPage(pageKey);
		});
	}

	Future<void> _fetchPage(int pageKey) async {
		try {

			final newItems = await _bookingsController.wpGetBookings(pageKey, _pageSize, _bookings_filters);
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
					Stack(
						alignment: Alignment.center,
						children: <Widget>[
							IconButton(
								icon: const Icon(Icons.filter_list),
								tooltip: 'Filter',
								onPressed: () async {
									await Navigator.push(context, MaterialPageRoute (
										builder: (BuildContext context) {
											return BookingsFilter( bookings_filters: _bookings_filters );
										},
									)).then((bookings_filters) {

										if ( bookings_filters != null ) {
											setState(() {
												_bookings_filters = bookings_filters;
											});
											_pagingController.refresh();
										}
									});
								},
							),
							if ( ! _bookings_filters.isEmpty() )
								IgnorePointer(
									child: Center(
										child: Container(
											height: 24.0,
											width: 24.0,
											child: Align(
												alignment: Alignment.topRight,
												child: Container(
													width: 10,
													height: 10,
													decoration: BoxDecoration(
														shape: BoxShape.circle,
														color: Colors.yellow,
													),
												),
											),
										),
									),
								),
						],
					),
					PopupMenuButton<String>(
						onSelected: (index){},
						itemBuilder: (BuildContext context) {
							return {'Logout', 'Settings'}.map((String choice) {
								return PopupMenuItem<String>(
									value: choice,
									child: Text(choice),
								);
							}).toList();
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

			body: Container(
				child: RefreshIndicator(
					onRefresh: () => Future.sync(
						() => _pagingController.refresh(),
					),
					child: PagedListView<int, Booking>(
						padding: EdgeInsets.all(20.0),
						pagingController: _pagingController,
						builderDelegate: PagedChildBuilderDelegate<Booking>(
							itemBuilder: (context, item, index) => BookingListItem(
								pagingController: _pagingController,
								index: index,
								booking: item,
							),
							noItemsFoundIndicatorBuilder: (context) => Center(child: Text('Nothing Found',),),
							firstPageErrorIndicatorBuilder: (context) => Text('Error'),
							newPageErrorIndicatorBuilder: (context) => Text('Error'),
						),
					),
				),
			),
			/*bottomNavigationBar: BottomNavigationBar(
				items: const <BottomNavigationBarItem>[
					BottomNavigationBarItem(
						icon: Icon(Icons.event),
						label: 'Bookings',
					),
					BottomNavigationBarItem(
						icon: Icon(Icons.payments),
						label: 'Payments',
					),
				],
			),*/
		);
	}

	@override
	void dispose() {
		_pagingController.dispose();
		super.dispose();
	}

}
