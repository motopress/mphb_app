import 'package:flutter/material.dart';
import 'package:mphb_app/screens/bookings/booking_list_item.dart';
import 'package:mphb_app/controller/bookings_controller.dart';
import 'package:mphb_app/models/booking.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class BookingsPage extends StatefulWidget {
  @override
  _BookingListViewState createState() => _BookingListViewState();
}

class _BookingListViewState extends State<BookingsPage> {

	final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

	void _openEndDrawer() {
		_scaffoldKey.currentState!.openEndDrawer();
	}

	void _closeEndDrawer() {
		Navigator.of(context).pop();
	}

	static const _pageSize = 10;

	final PagingController<int, Booking> _pagingController =
		PagingController(firstPageKey: 0);

	late final BookingsController _bookingsController;

	@override
	void initState() {
		super.initState();

		_bookingsController = new BookingsController();

		_pagingController.addPageRequestListener((pageKey) {
			_fetchPage(pageKey);
		});
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

			key: _scaffoldKey,
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
						icon: const Icon(Icons.filter_list),
						tooltip: 'Filter',
						onPressed: _openEndDrawer,
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

			endDrawer: Drawer(
				child: Center(
					child: Column(
						mainAxisAlignment: MainAxisAlignment.center,
						children: <Widget>[
							const Text('This is the Drawer'),
							ElevatedButton(
								onPressed: _closeEndDrawer,
								child: const Text('Close Drawer'),
							),
						],
					),
				),
			),
			// Disable opening the end drawer with a swipe gesture.
			endDrawerEnableOpenDragGesture: false,

		);
	}

	@override
	void dispose() {
		_pagingController.dispose();
		super.dispose();
	}

}
