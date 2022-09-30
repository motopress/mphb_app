import 'package:flutter/material.dart';
import 'package:mphb_app/models/calendar_filters.dart';
import 'package:mphb_app/models/enum/booking_status.dart';

class CalendarFilter extends StatefulWidget {

	final Calendar_Filters calendar_filters;

	const CalendarFilter({
		required this.calendar_filters,
		Key? key
	}) : super(key: key);

	@override
	_CalendarFilterState createState() =>
		_CalendarFilterState( calendar_filters: this.calendar_filters );

}

class _CalendarFilterState extends State<CalendarFilter> {

	_CalendarFilterState({
		required this.calendar_filters
	});

	Calendar_Filters calendar_filters;

	final List _bookingStatusesOptions = [
		const {'label': 'Confirmed', 'value': BookingStatusEnum.CONFIRMED},
		const {'label': 'Cancelled', 'value': BookingStatusEnum.CANCELLED},
		const {'label': 'Abandoned', 'value': BookingStatusEnum.ABANDONED},
		const {'label': 'Pending Admin', 'value': BookingStatusEnum.PENDING},
		const {'label': 'Pending User', 'value': BookingStatusEnum.PENDING_USER},
		const {'label': 'Pending Payment', 'value': BookingStatusEnum.PENDING_PAYMENT},
	];

	Iterable<Widget> get bookingStatusesFilter sync* {

		for (final status in _bookingStatusesOptions) {
			yield Padding(
				padding: const EdgeInsets.all(4.0),
				child: FilterChip(
					label: Text(status['label']),
					selected: calendar_filters.post_status.contains(status['value']),
					onSelected: (bool value) {
						setState(() {
							if (value) {

								calendar_filters.post_status.add(status['value']);

							} else {

								calendar_filters.post_status.removeWhere((String value) {
									return value == status['value'];
								});
							}
						});
					},
				),
			);
		}
	}

	void reset() {
		setState(() {
			calendar_filters = new Calendar_Filters();
		});
	}

	@override
	Widget build(BuildContext context) {

		return WillPopScope(
			child: Scaffold(
				backgroundColor: const Color(0xFFF4F5F8),
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
										],
									),
								),
								Container(
									margin: const EdgeInsets.only(top: 20.0),
									child: SwitchListTile(
										title: const Text('Display external bookings'),
										value: calendar_filters.show_imported,
										onChanged: (bool value) {
											setState(() {
												calendar_filters.show_imported = value;
											});
										},
									),
								),
							],
						),
					),
				),
			),
			onWillPop: () async {
				Navigator.pop(context, calendar_filters);
				return false;
			}
		);
	}

}
