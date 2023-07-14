import 'package:flutter/material.dart';
import 'package:mphb_app/models/bookings_filters.dart';
import 'package:mphb_app/models/enum/date_range.dart';
import 'package:mphb_app/models/enum/booking_status.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class BookingsFilter extends StatefulWidget {
  final Bookings_Filters bookings_filters;

  const BookingsFilter({required this.bookings_filters, Key? key})
      : super(key: key);

  @override
  _BookingsFilterState createState() =>
      _BookingsFilterState(bookings_filters: this.bookings_filters);
}

class _BookingsFilterState extends State<BookingsFilter> {
  _BookingsFilterState({required this.bookings_filters});

  Bookings_Filters bookings_filters;

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

  static List _bookingDateRangeOptions(BuildContext context) {
    return [
      {'label': AppLocalizations.of(context).todayOptionText, 'value': DateRangeEnum.TODAY},
      {'label': AppLocalizations.of(context).thisWeekOptionText, 'value': DateRangeEnum.THIS_WEEK},
      {'label': AppLocalizations.of(context).thisMonthOptionText, 'value': DateRangeEnum.THIS_MONTH},
    ];
  }

  Iterable<Widget> get bookingStatusesFilter sync* {
    for (final status in _bookingStatusesOptions(context)) {
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
    for (final range in _bookingDateRangeOptions(context)) {
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

  void reset() {
    setState(() {
      bookings_filters = new Bookings_Filters();
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
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10.0),
                          child: Text(AppLocalizations.of(context).dateCreatedLabelText + ':'),
                        ),
                        Wrap(
                          children: bookingDateRangeFilter.toList(),
                        ),
                        SizedBox(height: 10),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        onWillPop: () async {
          Navigator.pop(context, bookings_filters);
          return false;
        });
  }
}
