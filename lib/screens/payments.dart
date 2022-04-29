import 'package:flutter/material.dart';
import 'package:mphb_app/screens/payments/payments_list_item.dart';
import 'package:mphb_app/screens/payments/payments_filter.dart';
import 'package:mphb_app/controller/payments_controller.dart';
import 'package:mphb_app/models/payment.dart';
import 'package:mphb_app/models/payments_filters.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:mphb_app/screens/bookings/character_search_input_sliver.dart';

class PaymentsPage extends StatefulWidget {
  @override
  _PaymentsListViewState createState() => _PaymentsListViewState();
}

class _PaymentsListViewState extends State<PaymentsPage> {

	static const _pageSize = 10;

	final PagingController<int, Payment> _pagingController =
		PagingController(firstPageKey: 0);

	late final PaymentsController _paymentsController;

	late Payments_Filters _payments_filters;

	@override
	void initState() {
		super.initState();

		_paymentsController = new PaymentsController();

		_payments_filters = new Payments_Filters();

		_pagingController.addPageRequestListener((pageKey) {
			_fetchPage(pageKey);
		});
	}

	Future<void> _fetchPage(int pageKey) async {

		try {

			final newItems = await _paymentsController.wpGetPayments(
				pageKey, _pageSize, _payments_filters);
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

	void _updateSearchTerm( String searchTerm ) {
		_payments_filters.searchTerm = searchTerm;
		_pagingController.refresh();
	}

	@override
	Widget build(BuildContext context) {

		return Scaffold(

			appBar: AppBar(
				title: Text('Payments'),
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
											return PaymentsFilter(
												payments_filters: _payments_filters );
										},
									)).then((payments_filters) {

										if ( payments_filters != null ) {
											setState(() {
												_payments_filters = payments_filters;
											});
											_pagingController.refresh();
										}
									});
								},
							),
							if ( ! _payments_filters.isEmpty() )
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
								sliver: PagedSliverList<int, Payment>(
									pagingController: _pagingController,
									builderDelegate: PagedChildBuilderDelegate<Payment>(
										itemBuilder: (context, item, index) => PaymentListItem(
											pagingController: _pagingController,
											index: index,
											payment: item,
											key: ObjectKey(item),
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
