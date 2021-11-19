import 'package:flutter/material.dart';
import 'package:mphb_app/models/bookings_filters.dart';
import 'package:mphb_app/models/enum/date_range.dart';
import 'package:mphb_app/models/enum/booking_status.dart';

class BookingsFilter extends StatefulWidget {

	final Bookings_Filters bookings_filters;

	const BookingsFilter({
		required this.bookings_filters,
		Key? key
	}) : super(key: key);

	@override
	_BookingsFilterState createState() => _BookingsFilterState( bookings_filters: this.bookings_filters );

}

class _BookingsFilterState extends State<BookingsFilter> {

	_BookingsFilterState({
		required this.bookings_filters
	});

	Bookings_Filters bookings_filters;

	final List _bookingStatusesOptions = [
		const {'label': 'Confirmed', 'value': BookingStatusEnum.CONFIRMED},
		const {'label': 'Cancelled', 'value': BookingStatusEnum.CANCELLED},
		const {'label': 'Abandoned', 'value': BookingStatusEnum.ABANDONED},
		const {'label': 'Pending Admin', 'value': BookingStatusEnum.PENDING},
		const {'label': 'Pending User', 'value': BookingStatusEnum.PENDING_USER},
		const {'label': 'Pending Payment', 'value': BookingStatusEnum.PENDING_PAYMENT},
	];

	final List _bookingDateRangeOptions = [
		const {'label': 'Today', 'value': DateRangeEnum.TODAY},
		const {'label': 'This Week', 'value': DateRangeEnum.THIS_WEEK},
		const {'label': 'This Month', 'value': DateRangeEnum.THIS_MONTH},
	];

	Iterable<Widget> get bookingStatusesFilter sync* {
		for (final status in _bookingStatusesOptions) {
			yield Padding(
				padding: const EdgeInsets.all(4.0),
				child: FilterChip(
					label: Text(status['label']),
					selected: bookings_filters.post_status.contains(status['value']),
					onSelected: (bool value) {
						setState(() {
							if (value) {
								bookings_filters.post_status.add(status['value']);
							} else {
								bookings_filters.post_status.removeWhere((String value) {
									return value == status['value'];
								});
							}
						});
					},
				),
			);
		}
	}

	Iterable<Widget> get bookingDateRangeFilter sync* {
		for (final range in _bookingDateRangeOptions) {
			yield Padding(
				padding: const EdgeInsets.all(4.0),
				child: ChoiceChip(
					label: Text(range['label']),
					selected: bookings_filters.date_range == range['value'],
					onSelected: (bool value) {
						setState(() {
							if (value) {
								bookings_filters.date_range = range['value'];
							} else {
								bookings_filters.date_range = '';
							}
						});
					},
				),
			);
		}
	}

	void close() {
		Navigator.of(context).pop(
			bookings_filters
		);
	}

	void reset() {
		setState(() {
			bookings_filters = new Bookings_Filters();
		});
	}

	@override
	Widget build(BuildContext context) {

		return Scaffold(
			backgroundColor: Colors.white,
			appBar: AppBar(
				title: const Text('Filters'),
				actions: <Widget>[
					Padding(
						padding: EdgeInsets.all(10.0),
						child: TextButton(
							onPressed: reset,
							child: const Text('Reset'),
							style: TextButton.styleFrom(
								primary: Colors.black,
							),
						),
					),
				],
			),
			body: SingleChildScrollView(
				child: Container(
					padding: const EdgeInsets.all(20.0),
					child: Column(
						mainAxisAlignment: MainAxisAlignment.start,
						crossAxisAlignment: CrossAxisAlignment.start,
						children: <Widget>[

							Container(
								margin: const EdgeInsets.only(top: 0.0),
								child: Column(
									crossAxisAlignment: CrossAxisAlignment.start,
									children: [
										Padding(
											padding: const EdgeInsets.only(bottom: 10.0),
											child: Text('Booking Status:'),
										),
										Wrap(
											children: bookingStatusesFilter.toList(),
										),
										SizedBox(height: 10),
										//Text('Look for: ${bookings_filters.post_status.join(', ')}'),
									],
								),
							),
							Container(
								margin: const EdgeInsets.only(top: 20.0),
								child: Column(
									crossAxisAlignment: CrossAxisAlignment.start,
									children: [
										Padding(
											padding: const EdgeInsets.only(bottom: 10.0),
											child: Text('Date Range:'),
										),
										Wrap(
											children: bookingDateRangeFilter.toList(),
										),
										SizedBox(height: 10),
										//Text('Look for: ${bookings_filters.date_range}'),
									],
								),
							),
						],
					),
				),
			),

			persistentFooterButtons: [
				ElevatedButton(
					style: ElevatedButton.styleFrom(
						minimumSize: Size(double.infinity, 50), // double.infinity is the width and 50 is the height
						padding: EdgeInsets.all(10),
					),
					onPressed: close,
					child: const Text('Apply'),
				),
			],
		);

	}

}
