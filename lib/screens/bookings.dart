import 'package:flutter/material.dart';
import 'package:mphb_app/screens/bookings/booking_list_item.dart';
import 'package:mphb_app/screens/bookings/bookings_filter.dart';
import 'package:mphb_app/controller/bookings_controller.dart';
import 'package:mphb_app/models/booking.dart';
import 'package:mphb_app/models/bookings_filters.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:mphb_app/screens/bookings/create/create_booking.dart';
import 'package:mphb_app/screens/bookings/character_search_input_sliver.dart';

class BookingsPage extends StatefulWidget {
  @override
  _BookingsListViewState createState() => _BookingsListViewState();
}

class _BookingsListViewState extends State<BookingsPage> {

	static const _pageSize = 15;

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

			final newItems = await _bookingsController.wpGetBookings(
				pageKey, _pageSize, _bookings_filters);
			final isLastPage = newItems.length < _pageSize;

			if (isLastPage) {
				_pagingController.appendLastPage(newItems);
			} else {

				final nextPageKey = pageKey + newItems.length;
				_pagingController.appendPage(newItems, nextPageKey);
			}
		} catch (error) {

			_pagingController.error = error;
		}
	}

	void createBookingCallback( Booking booking ) {

		_pagingController.itemList?.insert( 0, booking );
		_pagingController.notifyListeners();
	}

	void deleteBookingCallback( int index ) {

		_pagingController.itemList?.removeAt( index );
		_pagingController.notifyListeners();
	}

	void _updateSearchTerm( String searchTerm ) {
		_bookings_filters.searchTerm = searchTerm;
		_pagingController.refresh();
	}

	@override
	Widget build(BuildContext context) {

		return Scaffold(

			appBar: AppBar(
				title: Text('Bookings'),
				shape: Border(
					bottom: BorderSide(
						color: const Color(0xFFF4F5F8),
						width: 1
					)
				),
				actions: <Widget>[
					IconButton(
						icon: const Icon(Icons.add_circle_outline),
						tooltip: 'New Booking',
						onPressed: () async {
							await Navigator.push(context, MaterialPageRoute (
								builder: (BuildContext context) {
									return CreateBookingPage(
										createBookingCallback:createBookingCallback
									);
								},
							)).then((value) {
							});
						},
					),
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
											return BookingsFilter(
												bookings_filters: _bookings_filters.clone()
											);
										},
									)).then((bookings_filters) {

										if ( ! bookings_filters.equals(_bookings_filters) ) {
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
				],
			),

			body: Container(
				child: RefreshIndicator(
					onRefresh: () => Future.sync(
						() => _pagingController.refresh(),
					),
					child: CustomScrollView(
						controller: ScrollController(),
						slivers: <Widget>[
							CharacterSearchInputSliver(
								onChanged: _updateSearchTerm,
							),
							SliverPadding(
								padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
								sliver: PagedSliverList<int, Booking>(
									pagingController: _pagingController,
									builderDelegate: PagedChildBuilderDelegate<Booking>(
										itemBuilder: (context, item, index) => BookingListItem(
											pagingController: _pagingController,
											index: index,
											booking: item,
											key: ObjectKey(item),
											deleteBookingCallback: deleteBookingCallback,
										),
										noItemsFoundIndicatorBuilder: (context) =>
											Center( child: Text('Nothing Found') ),

										firstPageErrorIndicatorBuilder: (context) =>
											Center( child: Text(_pagingController.error.toString()) ),

										newPageErrorIndicatorBuilder: (context) =>
											Center( child: Text(_pagingController.error.toString()) ),
									),
								),
							),
						],
					),
				),
			),
		);
	}

	@override
	void dispose() {
		_pagingController.dispose();
		super.dispose();
	}

}
