import 'package:flutter/material.dart';
import 'package:mphb_app/models/calendar_filters.dart';
import 'package:mphb_app/models/enum/booking_status.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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

	static List _bookingStatusesOptions(BuildContext context) {
    return [
      {'label': AppLocalizations.of(context).bookingConfirmedOptionText, 'value': BookingStatusEnum.CONFIRMED},
      {'label': AppLocalizations.of(context).bookingCanceledOptionText, 'value': BookingStatusEnum.CANCELLED},
      {'label': AppLocalizations.of(context).bookingAbandonedOptionText, 'value': BookingStatusEnum.ABANDONED},
      {'label': AppLocalizations.of(context).bookingPendingAdminOptionText, 'value': BookingStatusEnum.PENDING},
      {'label': AppLocalizations.of(context).bookingPendingUserOptionText, 'value': BookingStatusEnum.PENDING_USER},
      {'label': AppLocalizations.of(context).bookingPendingPaymentOptionText, 'value': BookingStatusEnum.PENDING_PAYMENT},
    ];
  }

	Iterable<Widget> get bookingStatusesFilter sync* {

		for (final status in _bookingStatusesOptions(context)) {
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
					title: Text(AppLocalizations.of(context).filtersTitleText),
					actions: <Widget>[
						Padding(
							padding: EdgeInsets.all(10.0),
							child: TextButton(
								onPressed: reset,
								child: Text(AppLocalizations.of(context).resetButtonText),
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
												child: Text(AppLocalizations.of(context).bookingStatusLabelText + ':'),
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
										title: Text(AppLocalizations.of(context).displayExternalBookingsLabelText),
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
